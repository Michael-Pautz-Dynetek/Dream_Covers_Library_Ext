codeunit 50401 "Book Rentals"
{
    //Rent or return book based on the value of the rented field
    procedure RentOrReturnBook(var CurrentLibrary: Record Library)
    begin
        if CurrentLibrary.Rented then begin
            ReturnBook(CurrentLibrary);
            exit;
        end;

        RentBook(CurrentLibrary);
    end;

    // Return book procedure that clears the overdue data of the book
    // and updates the highest overdue level of the customer.
    local procedure ReturnBook(var CurrentLibrary: Record Library)
    var
        Customer: Record Customer;
        OverdueLevels: Enum "Overdue Levels";
        ConfirmReturn: Label 'Do you want to return "%1"?', Comment = 'Title of the selected book.';
    begin
        CurrentLibrary.SetLoadFields("Book No.", Title, Rented, "Customer No.", "Date Rented", "Weeks Overdue", "Overdue Level");
        if Confirm(ConfirmReturn, false, CurrentLibrary.Title) then begin
            SetProbationDate(Customer, CurrentLibrary);
            CurrentLibrary.Validate(Rented, false);
            CurrentLibrary.Validate("Customer No.", '');
            CurrentLibrary.Validate("Date Rented", 0D);
            CurrentLibrary.Validate("Weeks Overdue", 0);
            CurrentLibrary.Validate("Overdue Level", OverdueLevels::" ");
            CurrentLibrary.Modify(true);
            if Customer."Highest Overdue Level" <> OverdueLevels::Extreme then
                UpdateHighestOverdueLevel(Customer);
            LogRentReturn(CurrentLibrary, false);
        end;
    end;

    // assigns the probation date of 6 months after the current date to the customer when returning a book
    // that was of extreme overdue level
    local procedure SetProbationDate(var Customer: Record Customer; Library: Record Library)
    begin
        Customer.SetLoadFields("No.", "Highest Overdue Level", "Probation Date");
        if Customer.Get(Library."Customer No.") then begin
            if (Customer."Highest Overdue Level" = "Overdue Levels"::Extreme) AND (Customer."Probation Date" = 0D) then
                Customer.Validate("Probation Date", CalcDate('<+6M>', Today));
            Customer.Modify(true);
        end;
    end;

    // Updates the highest overdue level of the returning customer by looping through the books rented by the customer
    // and getting the highest overdue level
    local procedure UpdateHighestOverdueLevel(Customer: Record Customer) //Only for renting and returning
    var
        Library: Record Library;
        OverdueLevels: Enum "Overdue Levels";
    begin
        Library.SetLoadFields("Customer No.", "Overdue Level");
        Customer.SetLoadFields("Highest Overdue Level");
        Library.SetRange("Customer No.", Customer."No.");
        OverdueLevels := "Overdue Levels"::" ";
        if Library.FindSet() then begin
            repeat
                if Library."Overdue Level".AsInteger() >= OverdueLevels.AsInteger() then
                    OverdueLevels := Library."Overdue Level"
            until Library.Next() = 0;
            if OverdueLevels.AsInteger() <> Customer."Highest Overdue Level".AsInteger() then
                Customer.Validate("Highest Overdue Level", OverdueLevels);
        end
        else
            Customer.Validate("Highest Overdue Level", OverdueLevels::" ");
        Customer.Modify(true);
    end;

    local procedure RentBook(var CurrentLibrary: Record Library)
    var
        Customer: Record Customer;
        Author: Record Authors;
        AuthorCodes: List of [Text];
        RentOutMessage: Label 'You have rented out %1', Comment = 'Title of the book rented out.';
        CustNameError: Label 'No customer was selected.';
        Item: Text;
    begin
        if Page.RunModal(Page::"Rent Book Card", CurrentLibrary) = Action::LookupOK then begin
            if CurrentLibrary."Customer No." <> '' then begin
                CurrentLibrary."Amount Rented" += 1;
                CurrentLibrary.Validate(Rented, true);
                //CurrentLibrary.Validate("Date Rented", Today);
                CurrentLibrary.Modify(true);
                if Customer.Get(CurrentLibrary."Customer No.") then begin
                    Customer.Validate("Amount of Books", Customer."Amount of Books" + 1);
                    UpdateHighestOverdueLevel(Customer);
                end;
                AuthorCodes := CurrentLibrary."Author Codes".Split(',');
                foreach Item in AuthorCodes do begin
                    if Author.Get(Item) then
                        Author."Books Rented Amount" += 1;
                    Author.Modify(true);
                end;
                Message(RentOutMessage, CurrentLibrary.Title);
                LogRentReturn(CurrentLibrary, true);
            end;
        end
        else begin
            CurrentLibrary.Validate("Customer No.", '');
            CurrentLibrary.Modify(true);
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertLibrary(var Rec: Record Library)
    begin
        if Rec."Date Rented" <> 0D then begin
            if not CalcWeeksOverdue(Rec) then
                Error(CalcWeeksError);
            if not UpdateOverdueLevel(Rec) then
                Error(UpdateOverdueLevelError);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyLibrary(var Rec: Record Library)
    begin
        if Rec."Date Rented" <> 0D then begin
            if not CalcWeeksOverdue(Rec) then
                Error(CalcWeeksError);
            if not UpdateOverdueLevel(Rec) then
                Error(UpdateOverdueLevelError);
        end;
    end;

    [TryFunction]
    procedure UpdateOverdueLevel(var Library: Record Library)
    var
        GeneralSetup: Record "Library General Setup";
    begin
        GeneralSetup.Get();
        case Library."Weeks Overdue" of
            0:
                Library.Validate("Overdue Level", Library."Overdue Level"::" ");
            GeneralSetup."Mild Week Amount":
                Library.Validate("Overdue Level", Library."Overdue Level"::Mild);
            GeneralSetup."Mild Week Amount" .. GeneralSetup."Medium Week Amount":
                Library.Validate("Overdue Level", Library."Overdue Level"::Medium);
            GeneralSetup."High Week Amount":
                Library.Validate("Overdue Level", Library."Overdue Level"::High);
        end;
        if Library."Weeks Overdue" >= GeneralSetup."Extreme Week Amount" then
            Library.Validate("Overdue Level", Library."Overdue Level"::Extreme);
    end;

    [TryFunction]
    procedure CalcWeeksOverdue(var Library: Record Library)
    begin
        if Library."Date Rented" = 0D then
            exit;
        Library.Validate("Weeks Overdue", (Today - Library."Date Rented") DIV 7);
    end;

    procedure GetHighestLevel()
    var
        Library: Record Library;
    begin
        Library.SetLoadFields(Rented, "Customer No.", "Overdue Level");
        Library.SetRange(Rented, true);
        if Library.FindSet() then
            repeat
                SetHighestLevel(Library);
            until Library.Next() = 0;
    end;

    local procedure SetHighestLevel(var Library: Record Library)
    var
        Customer: Record Customer;
        OverdueLevels: Enum "Overdue Levels";
    begin
        Customer.SetLoadFields("No.", "Probation Date", "Highest Overdue Level");
        if Customer.Get(Library."Customer No.") then begin
            if (Today < Customer."Probation Date") AND (Customer."Highest Overdue Level" = OverdueLevels::Extreme) then
                exit;
            if Library."Overdue Level".AsInteger() > Customer."Highest Overdue Level".AsInteger() then
                Customer.Validate("Highest Overdue Level", Library."Overdue Level");
            Customer.Modify(true);
        end;
    end;

    procedure OpenPageUpdates()
    var
        Library: Record Library;
    begin
        Library.SetLoadFields(Rented, "Date Rented", "Weeks Overdue", "Overdue Level");
        Library.SetRange(Rented, true);
        if Library.FindSet() then
            repeat
                if not CalcWeeksOverdue(Library) then
                    Error(CalcWeeksError);
                if not UpdateOverdueLevel(Library) then
                    Error(UpdateOverdueLevelError);
                Library.Modify(true);
            until Library.Next() = 0;

        GetHighestLevel();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Book Details Card", OnOpenBookDetails, '', false, false)]
    local procedure DisplayBookOverdueMessage(Library: Record Library)
    var
        BookOverdueMessage: Label '%1 is overdue with a level of %2', Comment = 'Title of the book and overdue level';
    begin
        if Library."Overdue Level" = "Overdue Levels"::" " then
            exit;

        Message(BookOverdueMessage, Library.Title, Library."Overdue Level");
    end;

    local procedure LogRentReturn(Library: Record Library; Rent: Boolean)
    var
        RentReturnLog: Record "Rent Return Log";
    begin
        RentReturnLog.Init();
        RentReturnLog.Validate("Entry No.");
        RentReturnLog.Validate("Book No.", Library."Book No.");
        RentReturnLog.Validate("Customer Name", Library."Customer Name");
        //RentReturnLog.Validate("Entry Date", CurrentDateTime); Actual code for publishing
        RentReturnLog.Validate(Title, Library.Title);
        if Rent then begin
            RentReturnLog.Validate("Type", 'Rent');
            RentReturnLog.Validate("Entry Date", CreateDateTime(Library."Date Rented", Time));//for testing purposes
        end
        else begin
            RentReturnLog.Validate("Type", 'Return');
            RentReturnLog.Validate("Entry Date", CurrentDateTime)
        end;
        RentReturnLog.Insert(true);
    end;

    var
        CalcWeeksError: Label 'An error occurred while calculating the number of weeks overdue.';
        UpdateOverdueLevelError: Label 'An error occurred while updating the overdue level.';
}
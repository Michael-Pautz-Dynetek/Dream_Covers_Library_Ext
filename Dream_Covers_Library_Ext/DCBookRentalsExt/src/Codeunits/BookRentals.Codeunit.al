codeunit 50401 "Book Rentals"
{
    trigger OnRun()
    begin

    end;

    procedure RentOrReturnBook(var CurrentLibrary: Record Library)
    begin
        if CurrentLibrary.Rented then begin
            ReturnBook(CurrentLibrary);
            exit;
        end;

        RentBook(CurrentLibrary);
    end;

    local procedure ReturnBook(var CurrentLibrary: Record Library)
    var
        Customer: Record Customer;
        OverdueLevels: Enum "Overdue Levels";
        ConfirmReturn: Label 'Do you want to return "%1"?', Comment = 'Title of the selected book.';
    begin
        if Confirm(ConfirmReturn, false, CurrentLibrary.Title) then begin
            if Customer.Get(CurrentLibrary."Customer No.") then begin
                if (Customer."Highest Overdue Level" = OverdueLevels::Extreme) AND (Customer."Probation Date" = 0D) then
                    Customer.Validate("Probation Date", CalcDate('<+6M>', Today));
                Customer.Modify(true);
            end;
            CurrentLibrary.Validate(Rented, false);
            CurrentLibrary.Validate("Customer No.", '');
            CurrentLibrary.Validate("Date Rented", 0D);
            CurrentLibrary.Validate("Weeks Overdue", 0);
            CurrentLibrary.Validate("Overdue Level", OverdueLevels::" ");
            CurrentLibrary.Modify(true);
            if Customer."Highest Overdue Level" <> OverdueLevels::Extreme then
                UpdateHighestOverdueLevel(Customer);
        end;
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterReturnBook(Customer: Record Customer)
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Book Rentals", OnAfterReturnBook, '', false, false)]
    local procedure UpdateHighestOverdueLevel(Customer: Record Customer) //Only for renting and returning
    var
        Library: Record Library;
        OverdueLevels: Enum "Overdue Levels";
    begin
        Library.SetRange("Customer No.", Customer."No.");
        OverdueLevels := "Overdue Levels"::" ";
        if Library.FindSet() then begin
            repeat
                if Library."Overdue Level".AsInteger() >= OverdueLevels.AsInteger() then
                    OverdueLevels := Library."Overdue Level"
            until Library.Next() = 0;
            Customer.Validate("Highest Overdue Level", OverdueLevels);
        end
        else
            Customer.Validate("Highest Overdue Level", OverdueLevels::" ");
        Customer.Modify(true);
    end;

    local procedure RentBook(var CurrentLibrary: Record Library)
    var
        Customer: Record Customer;
        RentOutMessage: Label 'You have rented out %1', Comment = 'Title of the book rented out.';
        CustNameError: Label 'No customer was selected.';
    begin
        // if CurrentLibrary."Customer Name" = '' then
        //     Error(CustNameError);

        if Page.RunModal(Page::"Rent Book Card", CurrentLibrary) = Action::LookupOK then begin
            if CurrentLibrary."Customer No." <> '' then begin
                CurrentLibrary."Amount Rented" += 1;
                CurrentLibrary.Validate(Rented, true);
                CurrentLibrary.Modify(true);
                if Customer.Get(CurrentLibrary."Customer No.") then begin
                    Customer.Validate("Amount of Books", Customer."Amount of Books" + 1);
                    //Customer.Modify(true);
                    UpdateHighestOverdueLevel(Customer);
                end;
                Message(RentOutMessage, CurrentLibrary.Title);
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertLibrary(var Rec: Record Library)
    begin
        CalcWeeksOverdue(Rec);
        UpdateOverdueLevel(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Library, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyLibrary(var Rec: Record Library)
    begin
        CalcWeeksOverdue(Rec);
        UpdateOverdueLevel(Rec);
    end;

    procedure UpdateOverdueLevel(var Library: Record Library)
    begin
        case Library."Weeks Overdue" of
            0:
                Library.Validate("Overdue Level", Library."Overdue Level"::" ");
            1:
                Library.Validate("Overdue Level", Library."Overdue Level"::Mild);
            2 .. 3:
                Library.Validate("Overdue Level", Library."Overdue Level"::Medium);
            4:
                Library.Validate("Overdue Level", Library."Overdue Level"::High);
            else
                Library.Validate("Overdue Level", Library."Overdue Level"::Extreme);
        end;
    end;

    procedure CalcWeeksOverdue(var Library: Record Library)
    begin
        if Library."Date Rented" = 0D then
            exit;
        Library.Validate("Weeks Overdue", Round((Today - Library."Date Rented") / 7, 1, '='));
    end;

    procedure GetHighestLevel()
    var
        Library: Record Library;
    begin
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
        Library.SetRange(Rented, true);
        if Library.FindSet() then
            repeat
                CalcWeeksOverdue(Library);
                UpdateOverdueLevel(Library);
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
}
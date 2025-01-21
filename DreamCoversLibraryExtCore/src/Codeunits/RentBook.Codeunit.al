codeunit 50206 RentBook
{
    trigger OnRun()
    begin

    end;

    procedure "Rent Book"(var CurrentLibrary: Record Library)
    var
        RentOutMessage: Label 'You have rented out %1';
        CheckRentMessage: Label 'This book is currently being rented.';
    begin
        if CurrentLibrary.Rented = true then
            Message(CheckRentMessage)
        else
            if Page.RunModal(Page::"Rent Book Card", CurrentLibrary) = Action::LookupOK then begin
                CurrentLibrary."Amount Rented" += 1;
                CurrentLibrary.Rented := true;
                CurrentLibrary.Modify(true);
                Message(RentOutMessage, CurrentLibrary.Title);
            end;
    end;

    procedure "Remove Rented Status"(var CurrentLibrary: Record Library)
    var
        myInt: Integer;
    begin
        CurrentLibrary.Rented := false;
        CurrentLibrary."Client ID" := '';
        CurrentLibrary.Modify(true);
    end;
}
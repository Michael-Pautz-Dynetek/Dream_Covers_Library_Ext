codeunit 50206 RentBook
{
    trigger OnRun()
    begin

    end;

    procedure "Rent Book"(var CurrentRec: Record Library)
    begin
        if CurrentRec.Rented = true then
            Message('This book is currently being rented.')
        else
            if Page.RunModal(Page::"Rent Book Card", CurrentRec) = Action::LookupOK then begin
                CurrentRec.Rented := true;
                CurrentRec.Modify();
                Message('You have rented out %1', CurrentRec.Title);
            end;
    end;

    var
        myInt: Integer;
}
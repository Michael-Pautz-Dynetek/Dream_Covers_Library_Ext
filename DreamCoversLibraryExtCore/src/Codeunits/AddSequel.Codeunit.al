codeunit 50210 "Add Sequel"
{
    trigger OnRun()
    begin

    end;

    procedure InsertSequel(CurrentLibrary: Record Library)
    var
        NewLibrary: Record Library temporary;
    begin
        NewLibrary.Init();
        NewLibrary.Validate("Book No.");
        NewLibrary.Validate(Author, CurrentLibrary.Author);
        NewLibrary.Validate(Series, CurrentLibrary.Series);
        NewLibrary.Validate(Prequel, CurrentLibrary.Title);
        NewLibrary.Insert(true);

        if Page.RunModal(Page::"Add Sequel Card", NewLibrary) = Action::LookupOK then begin
            SaveSequel(NewLibrary);
            CurrentLibrary.Validate(Sequel, NewLibrary.Title);
            CurrentLibrary.Modify(true);
        end;
    end;

    local procedure SaveSequel(TempLibrary: Record Library temporary)
    var
        NewLibrary: Record Library;
    begin
        NewLibrary.Init();
        NewLibrary := TempLibrary;
        NewLibrary.Insert(true);
    end;
}
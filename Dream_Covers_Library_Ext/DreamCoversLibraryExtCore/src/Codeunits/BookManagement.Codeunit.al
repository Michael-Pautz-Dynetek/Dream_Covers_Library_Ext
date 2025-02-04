codeunit 50213 "Book Management"
{
    trigger OnRun()
    begin

    end;

    procedure BookManagementActions(var Library: Record Library; BookMgtOption: Enum "Book Management Options")
    begin
        case BookMgtOption of
            BookMgtOption::AddBook:
                AddBook();
            BookMgtOption::AddSequel:
                InsertSequel(Library);
        end;
    end;

    local procedure AddBook()
    var
        TempLibrary: Record Library temporary;
    begin
        TempLibrary.Init();
        TempLibrary.Insert(true);
        if Page.RunModal(Page::"Book Details Card", TempLibrary) = Action::LookupOK then
            InsertNewBook(TempLibrary);
    end;

    local procedure InsertNewBook(TempLibrary: Record Library)
    var
        NewLibrary: Record Library;
        AddMessage: Label 'You have added "%1" to the table.', Comment = 'Title of the new book.';
    begin
        NewLibrary.Init();
        NewLibrary := TempLibrary;
        NewLibrary.Insert(true);
        Message(AddMessage, NewLibrary.Title);
    end;

    local procedure InsertSequel(CurrentLibrary: Record Library)
    var
        NewLibrary: Record Library temporary;
        HasSequelMessage: Label '%1 book already has a sequel.', Comment = 'Title of the selected book.';
    begin
        if CurrentLibrary.Sequel <> '' then begin
            Message(HasSequelMessage, CurrentLibrary.Title);
            exit;
        end
        else
            InsertCurrentValues(NewLibrary, CurrentLibrary);
    end;

    local procedure SaveSequel(TempLibrary: Record Library temporary)
    var
        NewLibrary: Record Library;
    begin
        NewLibrary.Init();
        NewLibrary := TempLibrary;
        NewLibrary.Insert(true);
    end;

    local procedure InsertCurrentValues(NewLibrary: Record Library temporary; CurrentLibrary: Record Library)
    begin
        NewLibrary.Init();
        NewLibrary.Validate("Book No.");
        NewLibrary.Validate(Author, CurrentLibrary.Author);
        NewLibrary.Validate(Series, CurrentLibrary.Series);
        NewLibrary.Validate(Prequel, CurrentLibrary.Title);
        //NewLibrary.Validate("Prequel ID", CurrentLibrary."Book No.");
        NewLibrary.Validate(Genre, CurrentLibrary.Genre);
        NewLibrary.Insert(true);

        if Page.RunModal(Page::"Add Sequel Card", NewLibrary) = Action::LookupOK then begin
            SaveSequel(NewLibrary);
            CurrentLibrary.Validate(Sequel, NewLibrary.Title);
            CurrentLibrary.Modify(true);
        end;
    end;
}
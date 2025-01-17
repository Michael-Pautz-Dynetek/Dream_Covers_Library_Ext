codeunit 50210 "Add Sequel"
{
    trigger OnRun()
    begin

    end;

    procedure InsertSequel(var CurrentBook: Record Library; var NewBook: Record Library)
    begin
        NewBook.Init();
        NewBook.Series := CurrentBook.Series;
        NewBook.Prequel := CurrentBook.Title;
        NewBook.Author := CurrentBook.Author;
        NewBook.Insert(true);
    end;
}
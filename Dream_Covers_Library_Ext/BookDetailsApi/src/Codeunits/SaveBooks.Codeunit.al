codeunit 50503 "Save Books"
{
    trigger OnRun()
    begin

    end;

    procedure InsertSelectedBooks(TempLibrary: Record Library)
    var
        Library: Record Library;
        OpenLibraryApi: Codeunit "Open Library API";
    begin
        Library.Init();
        Library.Validate(Title, TempLibrary.Title);
        Library.Validate("Date Added", Today);
        //OpenLibraryApi.GetBookDescriptionRequest(TempLibrary."Open Library ID", Library);
        Library.Validate("Date Created", TempLibrary."Date Created");
        Library.Validate(Description, TempLibrary.Description);
        Library.Validate("Open Library ID", TempLibrary."Open Library ID");
        Library.Insert(true);
    end;

    //insert new author procedure to check author table for each auth key, if not found insert author details(send get request with querye auth key=key)
}
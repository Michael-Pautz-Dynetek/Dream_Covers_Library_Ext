codeunit 50503 "Save Books"
{
    trigger OnRun()
    begin

    end;

    procedure InsertSelectedBooks(TempLibrary: Record Library; var SavedTitles: Text)
    var
        OpenLibraryApi: Codeunit "Open Library API";
        Library: Record Library;
        BookExistsError: Label '%1 already exist in the system';
    begin
        Library.SetRange("Open Library ID", TempLibrary."Open Library ID");

        if not Library.FindSet() then begin
            Library.Init();
            Library.Validate(Title, TempLibrary.Title);
            SavedTitles += Library.Title + '\';
            Library.Validate("Date Added", Today);
            Library.Validate("Open Library ID", TempLibrary."Open Library ID");
            Library.Validate(Author, TempLibrary.Author);
            Library.Validate("Author Codes", TempLibrary."Author Codes");
            OpenLibraryApi.GetWorksDetailsRequest(TempLibrary."Open Library ID", Library);
            OpenLibraryApi.GetBookCoverRequest(TempLibrary."Cover No.", Library);
            Library.Insert(true);

            InsertAuthors(TempLibrary."Author Codes", Library."Book No.");
        end
        else
            Message(BookExistsError, TempLibrary.Title);
    end;

    //insert new author procedure to check author table for each auth key, if not found insert author details(send get request with querye auth key=key)
    local procedure InsertAuthors(AuthorString: Text; BookNo: Code[20])
    var
        OpenLibraryApi: Codeunit "Open Library API";
        Authors: Record Authors;
        CodeArray: List of [Text];
        Item: Text;
    begin
        CodeArray := AuthorString.Split(',');
        foreach Item in CodeArray do begin
            if not Authors.Get(Item) then begin
                Authors.Init();
                Authors.Validate("Author No.", Item);
                OpenLibraryApi.GetAuthorDetailsRequest(Item, Authors);
                OpenLibraryApi.GetGeneralAuthorRequest(Item, Authors.Name, Authors);
                OpenLibraryApi.GetAuthorPhotoRequest(Item, Authors);
                Authors.Insert(true);
            end;
        end;
    end;
}
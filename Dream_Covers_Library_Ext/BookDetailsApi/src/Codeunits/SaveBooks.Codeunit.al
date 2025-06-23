codeunit 50503 "Save Books"
{

    procedure InsertSelectedBooks(TempLibrary: Record Library; var SavedTitles: Text)
    var
        OpenLibraryApi: Codeunit "Open Library API";
        Library: Record Library;
        Window: Dialog;
        CurrentProcess: Text;
        BookExistsError: Label '%1 already exists in the system';
    begin
        Library.SetLoadFields("Book No.", "Open Library ID", Title, "Date Added", Author, "Author Codes", "Cover No.", Cover, "Date Created", Description, "Subject People", "Subject Places", Subjects);
        Library.SetRange("Open Library ID", TempLibrary."Open Library ID");

        if not Library.FindSet() then begin
            CurrentProcess := 'Saving details of ' + TempLibrary.Title + ' to Library.';
            if GuiAllowed then
                Window.Open(CurrentProcess);
            Library.Init();
            if BookDetailsValidation(TempLibrary, SavedTitles, Library) then begin
                OpenLibraryApi.GetBookCoverRequest(TempLibrary."Cover No.", Library);
                OpenLibraryApi.GetWorksDetailsRequest(TempLibrary."Open Library ID", Library);
                // if OpenLibraryApi.GetWorksDetailsRequest(TempLibrary."Open Library ID", Library) = false then
                //     exit;

                Library.Insert(true);
            end;
            Window.Close();

            CurrentProcess := 'Saving authors for ' + TempLibrary.Title + '.';
            if GuiAllowed then
                Window.Open(CurrentProcess);
            InsertAuthors(TempLibrary."Author Codes", Library."Book No.");
            Window.Close();
        end
        else
            Message(BookExistsError, TempLibrary.Title);
    end;

    //insert new author procedure to check author table for each auth key, if not found insert author details(send get request with querye auth key=key)
    local procedure InsertAuthors(AuthorString: Text; BookNo: Code[20])
    var
        OpenLibraryApi: Codeunit "Open Library API";
        Authors: Record Authors;
        BooksAuthors: Record BooksAuthors;
        CodeArray: List of [Text];
        Item, AuthorName : Text;
    begin
        Authors.SetLoadFields("Author No.", Name, Bio, "Death Date", "Birth Date", "Personal Name", "Work Count", "Top Work");
        CodeArray := AuthorString.Split(',');
        foreach Item in CodeArray do begin

            if not Authors.Get(Item) then begin
                Authors.Init();
                Authors.Validate("Author No.", Item);
                OpenLibraryApi.GetAuthorDetailsRequest(Item, Authors);
                OpenLibraryApi.GetGeneralAuthorRequest(Item, Authors.Name, Authors);
                AuthorName := Authors.Name;
                OpenLibraryApi.GetAuthorPhotoRequest(Item, Authors);
                Authors.Insert(true);
            end
            else
                AuthorName := Authors.Name;
            BooksAuthors.Init();
            BooksAuthors.Validate("Book No.", BookNo);
            BooksAuthors.Validate("Author No.", Item);
            BooksAuthors.Validate("Author Name", AuthorName);
            BooksAuthors.Validate("Valid Link", true);
            BooksAuthors.Insert(true);
        end;
    end;

    [TryFunction]
    local procedure BookDetailsValidation(var TempLibrary: Record Library; var SavedTitles: Text; var Library: Record Library)
    begin
        Library.Validate(Title, TempLibrary.Title);
        SavedTitles += Library.Title + '\';
        Library.Validate("Date Added", Today);
        Library.Validate("Open Library ID", TempLibrary."Open Library ID");
        //Library.Validate(Author, TempLibrary.Author);
        Library.Author := TempLibrary.Author;
        Library.Validate("Author Codes", TempLibrary."Author Codes");
    end;
}
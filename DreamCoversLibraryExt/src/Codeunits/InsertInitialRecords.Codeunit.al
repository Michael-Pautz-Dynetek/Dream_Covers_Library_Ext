codeunit 50202 "Insert Initial Records"
{
    trigger OnRun()
    var
        Books: Record Library;
    begin
        Books.DeleteAll();

        Books.Init();
        Books."Book No." := 1;
        Books.Title := 'The Hobbit';
        Books.Author := 'J.R.R. Tolkien';
        Books.Rented := true;
        Books.Genre := 'Fantasy';
        Books.Publisher := 'Penguin';
        Books."Book Price" := 250.00;
        Books."Publication Date" := DMY2Date(15, 1, 2010);
        Books.Pages := 410;
        Books.Series := 'Middle Earth';
        Books."Amount Rented" := 7;
        Books."Client Name" := 'Michael Pautz';
        Books.Insert();

        Books.Init();
        Books."Book No." := 2;
        Books.Title := 'Harry Potter and the Philosophers Stone';
        Books.Author := 'J.K. Rowling';
        Books.Rented := false;
        Books.Genre := 'Fantasy';
        Books.Publisher := 'Penguin';
        Books."Book Price" := 250.00;
        Books."Publication Date" := DMY2Date(11, 5, 2024);
        Books.Pages := 380;
        Books.Series := 'Harry Potter';
        Books."Amount Rented" := 5;
        Books.Sequel := 'Harry Potter and the Chamber of Secrets';
        Books.Insert();

        Books.Init();
        Books."Book No." := 3;
        Books.Title := 'The Colour of Magic';
        Books.Author := 'Terry Pratchett';
        Books.Rented := true;
        Books.Genre := 'Sci-fi';
        Books.Publisher := 'Penguin';
        Books."Book Price" := 150.00;
        Books."Publication Date" := DMY2Date(11, 5, 1994);
        Books.Pages := 280;
        Books.Series := 'Discworld Novel';
        Books."Amount Rented" := 2;
        Books."Client Name" := 'Arlo Roos';
        Books.Insert();

        Books.Init();
        Books."Book No." := 4;
        Books.Title := 'It';
        Books.Author := 'Stephen King';
        Books.Rented := false;
        Books.Genre := 'Horror';
        Books.Publisher := 'Penguin';
        Books."Book Price" := 180.00;
        Books."Publication Date" := DMY2Date(11, 8, 1992);
        Books.Pages := 380;
        Books."Amount Rented" := 4;
        Books.Insert();
    end;

    var
        myInt: Integer;
}
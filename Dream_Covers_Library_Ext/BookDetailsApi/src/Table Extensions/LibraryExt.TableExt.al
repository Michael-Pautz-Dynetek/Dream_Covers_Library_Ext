tableextension 50528 "Library Ext" extends Library
{
    fields
    {
        modify(Author)
        {
            trigger OnAfterValidate()
            var
                BooksAuthors: Record BooksAuthors;
                NameArray: List of [Text];
                AuthorString, Item : Text;
                Valid: Boolean;
            begin

                NameArray := Author.Split(',');
                BooksAuthors.SetRange("Book No.", "Book No.");
                if BooksAuthors.FindFirst() then
                    repeat
                        Valid := false;
                        foreach Item in NameArray do
                            if BooksAuthors."Author Name".ToUpper() = Item then
                                Valid := true;
                        if Valid = false then begin
                            BooksAuthors.Delete();
                        end;
                    until BooksAuthors.Next() = 0;
                // BooksAuthors.Reset();
                // BooksAuthors.SetRange("Valid Link", false);
                // //BooksAuthors.DeleteAll();
                // if BooksAuthors.FindSet() then
                //     repeat
                //         BooksAuthors.Delete();
                //     until BooksAuthors.Next() = 0;

            end;
        }
        field(200; "Author Filter"; Text[2048])
        {
            FieldClass = FlowFilter;
        }
    }
}
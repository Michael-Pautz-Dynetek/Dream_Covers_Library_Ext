tableextension 50528 "Library Ext" extends Library
{
    fields
    {
        modify(Author)
        {
            trigger OnAfterValidate()
            var
                BooksAuthors: Record BooksAuthors;
                NameArray, CodeArray : List of [Text];
                AuthorString, Item, AuthorID : Text;
                Valid, Found, IsFirst : Boolean;
            begin

                NameArray := Author.Split(',');
                CodeArray := "Author Codes".Split(',');
                AuthorString := '';
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
                IsFirst := true;
                foreach AuthorID in CodeArray do begin
                    Found := false;
                    BooksAuthors.SetRange("Book No.", "Book No.");
                    if BooksAuthors.FindSet() then
                        repeat
                            if AuthorID = BooksAuthors."Author No." then
                                Found := true;
                        until BooksAuthors.Next() = 0;
                    if Found then begin
                        if IsFirst then begin
                            AuthorString += AuthorID;
                            IsFirst := false;
                        end
                        else
                            AuthorString += ',' + AuthorID;
                    end;
                end;
                Validate("Author Codes", AuthorString);
                SetFilter("Author Filter", Rec."Author Codes".Replace(',', '|'));
                Modify(true);
                //SetFilter("Author Filter", Author.Replace(',', '|'));
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
        field(210; "Subject Places"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject Places';
        }
        field(220; "Subjects"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Subjects';
        }
        field(230; "Subject People"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Subject People';
        }
    }
}
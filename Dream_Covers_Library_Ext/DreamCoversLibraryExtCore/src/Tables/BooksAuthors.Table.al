table 50215 "BooksAuthors"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Book No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Library."Book No.";
        }
        field(2; "Author No."; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Authors."Author No.";
        }
    }

    keys
    {
        key(PK; "Book No.", "Author No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
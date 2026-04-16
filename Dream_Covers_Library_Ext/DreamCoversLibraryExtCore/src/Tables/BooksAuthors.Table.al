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
        field(3; "Valid Link"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Author Name"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Book No.", "Author No.")
        {
            Clustered = true;
        }
    }

}
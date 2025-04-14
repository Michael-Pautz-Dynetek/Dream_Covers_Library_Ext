table 50214 Authors
{
    DataClassification = CustomerContent;
    Caption = 'Authors';

    fields
    {
        field(1; "Author No."; Code[50])
        {
            Caption = 'Author No.';
            DataClassification = CustomerContent;
        }
        field(10; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = ToBeClassified;
        }
        field(20; "Death Date"; Date)
        {
            Caption = 'Death Date';
            DataClassification = ToBeClassified;
        }
        field(30; Bio; Blob)
        {
            Caption = 'Bio';
            DataClassification = ToBeClassified;
        }
        field(40; "Personal Name"; Text[250])
        {
            Caption = 'Personal Name';
            DataClassification = ToBeClassified;
        }
        field(50; Name; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(60; "Work Count"; Integer)
        {
            Caption = 'Work Count';
            DataClassification = ToBeClassified;
        }
        field(70; "Top Work"; Text[500])
        {
            Caption = 'Top Work';
            DataClassification = ToBeClassified;
        }
        field(80; Photo; Media)
        {
            Caption = 'Photo';
            DataClassification = CustomerContent;
        }
        field(200; "Books Rented Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Books Rented Amount';
        }
    }

    keys
    {
        key(PK; "Author No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(Brick; "Birth Date", Name, Photo)
        {

        }
    }

    trigger OnDelete()
    var
        BooksAuthors: Record BooksAuthors;
    begin
        BooksAuthors.SetRange("Author No.", Rec."Author No.");
        if BooksAuthors.FindSet() then
            repeat
                BooksAuthors.Delete();
                
            until BooksAuthors.Next() = 0;
    end;

}
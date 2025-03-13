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
        field(30; Bio; Text[2048])
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
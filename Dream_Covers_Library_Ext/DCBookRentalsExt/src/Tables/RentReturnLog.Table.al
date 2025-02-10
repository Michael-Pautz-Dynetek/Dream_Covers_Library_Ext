table 50417 "Rent Return Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Book No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Book No.';
            TableRelation = Library."Book No.";
        }
        field(10; "Title"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(20; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Log Date';
            trigger OnValidate()
            begin
                CalculateDuration();
            end;
        }
        field(30; "Customer Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Name';
        }
        field(40; "Type"; Text[125])
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(50; "Days Difference"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Days Difference';
        }
    }

    keys
    {
        key(PK; "Entry No.")
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

    local procedure CalculateDuration()
    var
        RentReturnLog: Record "Rent Return Log";
    begin
        RentReturnLog.SetRange("Book No.", "Book No.");
        if RentReturnLog.FindLast() then
            Validate("Days Difference", "Entry Date" - RentReturnLog."Entry Date")
        else
            Validate("Days Difference", 0);
    end;

}
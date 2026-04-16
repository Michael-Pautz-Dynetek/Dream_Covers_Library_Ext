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
        field(20; "Entry Date"; DateTime)
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
        field(50; "Days Difference"; Text[250])
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

    local procedure CalculateDuration()
    var
        RentReturnLog: Record "Rent Return Log";
    begin
        RentReturnLog.SetRange("Book No.", "Book No.");
        if RentReturnLog.FindLast() then
            Validate("Days Difference", FormatDuration("Entry Date" - RentReturnLog."Entry Date"))
        else
            Validate("Days Difference", '0');
    end;

    local procedure FormatDuration(DurationDifference: Duration): Text
    var
        Result: Text;
        Minutes, Hours, Days, RemainingMinutes, RemainingHours : Decimal;
    begin
        Minutes := DurationDifference / (60000);
        Hours := Minutes / 60;
        RemainingMinutes := Minutes MOD 60;
        Days := Hours / 24;
        RemainingHours := Hours MOD 24;
        Result := StrSubstNo('%1 days %2 hours %3 minutes', Round(Days, 1), Round(RemainingHours, 1), Round(RemainingMinutes, 1));
        exit(Result);
    end;

}
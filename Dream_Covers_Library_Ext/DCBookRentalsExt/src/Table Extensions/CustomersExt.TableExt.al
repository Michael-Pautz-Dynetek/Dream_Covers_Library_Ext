tableextension 50407 "Customers Ext" extends Customer
{
    fields
    {
        field(50400; "Amount of Books"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount of Books';
        }
        field(50401; "Highest Overdue Level"; Enum "Overdue Levels")
        {
            DataClassification = CustomerContent;
            Caption = 'Highest Overdue Level';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                SetRentAllowed();
            end;
        }
        field(50402; "Rent Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rent Allowed';
        }
        field(50403; "Book Limit"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Book Limit';

        }
        field(50404; "Probation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Probation Date';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Probation Date" = 0D then begin
                    Validate("Rent Allowed", true);
                    Modify(true);
                end;
            end;
        }
    }

    local procedure SetRentAllowed()
    begin
        if "Probation Date" = 0D then
            case "Highest Overdue Level" of
                "Highest Overdue Level"::" ":
                    begin
                        Validate("Rent Allowed", true);
                        Validate("Book Limit", 0);
                    end;
                "Highest Overdue Level"::Mild:
                    begin
                        Validate("Rent Allowed", true);
                        Validate("Book Limit", "Amount of Books" + 3);
                    end;
                "Highest Overdue Level"::Medium:
                    begin
                        Validate("Rent Allowed", false);
                        Validate("Book Limit", 0);
                    end;
                "Highest Overdue Level"::High:
                    begin
                        Validate("Rent Allowed", false);
                        Validate("Book Limit", 0);
                    end;
                "Highest Overdue Level"::Extreme:
                    begin
                        Validate("Rent Allowed", false);
                        Validate("Book Limit", 0);
                    end;
            end
        else
            Validate("Rent Allowed", false);
    end;

    var
        myInt: Integer;
}
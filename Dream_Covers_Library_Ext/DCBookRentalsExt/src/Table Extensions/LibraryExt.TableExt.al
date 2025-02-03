tableextension 50403 "Library Ext" extends Library
{
    fields
    {
        field(141; "Overdue Level"; Enum "Overdue Levels")
        {
            DataClassification = CustomerContent;
            Caption = 'Overdue Level';
        }
        field(142; "Date Rented"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Rented';
        }
        field(143; "Weeks Overdue"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Weeks Overdue';
        }
        modify("Customer No.")
        {
            trigger OnBeforeValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get(Rec."Customer No.") then begin
                    RentOutWarnings(Customer);
                end;
            end;
        }
    }

    local procedure RentOutWarnings(Customer: Record Customer)
    var
        RentNotAllowedError: Label '%1 is not allowed to rent out books due to Overdue Level: %2.', Comment = 'Placeholders for customer name and overdue level.';
        OnProbationError: Label '%1 is not allowed to rent out books until %2.', Comment = 'Placeholders for customer name and probation date.';
        BookLimitMessage: Label '%1 can only rent %2 more books', Comment = 'Placeholders for customer name and book limit';
        BookLimitError: Label '%1 has reached their renting limit';
    begin
        if Customer."Rent Allowed" AND (Customer."Highest Overdue Level" <> "Overdue Levels"::Mild) then
            exit;

        case Customer."Highest Overdue Level" of
            "Overdue Levels"::Mild:
                begin
                    if Customer."Amount of Books" = Customer."Book Limit" then
                        Error(BookLimitError, Customer.Name, Customer."Book Limit")
                    else
                        Message(BookLimitMessage, Customer.Name, Customer."Book Limit");
                end;
            "Overdue Levels"::Medium:
                Error(RentNotAllowedError, Customer.Name, Customer."Highest Overdue Level");
            "Overdue Levels"::High:
                Error(RentNotAllowedError, Customer.Name, Customer."Highest Overdue Level");
            "Overdue Levels"::Extreme:
                Error(RentNotAllowedError, Customer.Name, Customer."Highest Overdue Level");
            else
                Error(OnProbationError, Customer.Name, Customer."Probation Date");
        end;
    end;
}
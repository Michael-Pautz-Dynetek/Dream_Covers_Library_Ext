codeunit 50408 "Customer Renting Status"
{
    trigger OnRun()
    begin

    end;

    procedure CustomerOverdueMessage(Customer: Record Customer)
    var
        //OverdueLevels: Enum "Overdue Levels";
        ProbationWarning: Label '%1 is on a renting probation until %2.', Comment = 'Placeholders for the customer name and the probation date.';
        OverdueWarning: Label '%1 has an overdue level of %2.', Comment = 'Placeholders for customer name and highest overdue level';
    begin
        if (Customer."Rent Allowed") then
            exit;
        if (Customer."Probation Date" <> 0D) AND (Today < Customer."Probation Date") then begin
            Message(ProbationWarning, Customer.Name, Customer."Probation Date");
            exit;
        end;
        case Customer."Highest Overdue Level" of
            "Overdue Levels"::Mild:
                Message(OverdueWarning, Customer.Name, Customer."Highest Overdue Level");
            "Overdue Levels"::Medium:
                Message(OverdueWarning, Customer.Name, Customer."Highest Overdue Level");
            "Overdue Levels"::High:
                Message(OverdueWarning, Customer.Name, Customer."Highest Overdue Level");
            "Overdue Levels"::Extreme:
                Message(OverdueWarning, Customer.Name, Customer."Highest Overdue Level");
        end;
    end;

    var
        myInt: Integer;
}
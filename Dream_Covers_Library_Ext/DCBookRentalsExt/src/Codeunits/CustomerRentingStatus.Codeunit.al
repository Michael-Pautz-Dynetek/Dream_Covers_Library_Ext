codeunit 50408 "Customer Renting Status"
{
    procedure CustomerOverdueMessage(Customer: Record Customer)
    var
        GeneralSetup: Record "Library General Setup";
        ProbationWarning: Label '%1 is on a renting probation until %2.', Comment = 'Placeholders for the customer name and the probation date.';
        MildWarning: Label '%1 has an overdue level of Mild. Send a reminder to return books.', Comment = 'Customer name';
        MediumWarning: Label '%1 has an overdue level of Medium. Notify them that a fine of R%2 will be charged if not returned.', Comment = 'Customer name and base fine amount';
        HighWarning: Label '%1 has an overdue level of High. Notify them that a fine of R%2 has been charged.', Comment = 'Customer name and base fine amount';
        ExtremeWarning: Label '%1 has an overdue level of Extreme. Notify them of the additional fine of R%2 and that a 6 month probation period will start when they return the books.', Comment = 'Customer name and extreme fine amount';
    begin
        if (Customer."Rent Allowed") AND (Customer."Highest Overdue Level" <> "Overdue Levels"::Mild) then
            exit;
        if (Customer."Probation Date" <> 0D) AND (Today < Customer."Probation Date") then begin
            Message(ProbationWarning, Customer.Name, Customer."Probation Date");
            exit;
        end;
        GeneralSetup.Get(2);
        case Customer."Highest Overdue Level" of
            "Overdue Levels"::Mild:
                Message(MildWarning, Customer.Name);
            "Overdue Levels"::Medium:
                Message(MediumWarning, Customer.Name, GeneralSetup."Base Fine");
            "Overdue Levels"::High:
                Message(HighWarning, Customer.Name, GeneralSetup."Base Fine");
            "Overdue Levels"::Extreme:
                Message(ExtremeWarning, Customer.Name, GeneralSetup."Extreme Fine");
        end;
    end;

    procedure OpenCustomerCardPage(Library: Record Library)
    var
        CustomerCard: Page "Customer Card";
        Customer: Record Customer;
    begin
        Customer.Get(Library."Customer No.");
        CustomerCard.SetRecord(Customer);
        CustomerCard.Run();
    end;
}
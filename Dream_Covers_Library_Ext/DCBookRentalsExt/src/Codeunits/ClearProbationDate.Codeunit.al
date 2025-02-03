codeunit 50411 "Clear Probation Date"
{
    trigger OnRun()
    begin

    end;

    procedure ClearCompletedProbationDates()
    var
        Customer: Record Customer;
        ProbationDatesRemovedMessage: Label 'All completed probation dates have been removed.';
        NoProbationDatesMessage: Label 'No probation dates were found.';
    begin
        Customer.SetFilter("Probation Date", '<>%1', 0D);
        if Customer.FindSet() then begin
            repeat
                if Today > Customer."Probation Date" then begin
                    Customer.Validate("Probation Date", 0D);
                    Customer.Modify(true);
                end;
            until Customer.Next() = 0;
            Message(ProbationDatesRemovedMessage);
            exit;
        end;
        Message(NoProbationDatesMessage);
    end;

    var
        myInt: Integer;
}
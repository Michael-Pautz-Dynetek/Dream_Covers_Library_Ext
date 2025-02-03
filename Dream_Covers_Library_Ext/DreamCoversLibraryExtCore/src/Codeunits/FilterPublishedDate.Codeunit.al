codeunit 50205 "Filter Published Date"
{
    procedure FilterLast2Years(var Rec: Record Library)
    var
        ConfirmFilter: Label 'Do you want to view the books published in the last 2 years?';
    begin
        if Confirm(ConfirmFilter, false) then
            DateFilter(Rec);
    end;

    local procedure DateFilter(var Rec: Record Library)
    var
        StartDate, EndDate : Date;
    begin
        StartDate := CalcDate('<-2y>', Today());
        EndDate := Today();
        Rec.SetFilter(Rec."Publication Date", '%1..%2', StartDate, EndDate);
    end;
}
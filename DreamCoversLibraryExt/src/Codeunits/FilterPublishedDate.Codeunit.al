codeunit 50205 "Filter Published Date"
{
    procedure FilterLast2Years(var Rec: Record Library)
    var
        StartDate, EndDate : Date;
    begin
        StartDate := CalcDate('<-2y>', Today());
        EndDate := Today();
        Rec.SetFilter(Rec."Publication Date", '%1..%2', StartDate, EndDate);
    end;

    var
        myInt: Integer;
}
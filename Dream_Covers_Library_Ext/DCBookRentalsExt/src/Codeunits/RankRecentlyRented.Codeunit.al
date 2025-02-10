codeunit 50420 "Rank Recently Rented"
{
    trigger OnRun()
    begin
        RankBooks();
    end;

    local procedure RankBooks()
    begin
        CalculateAmountRentedPastMonth();
        SetRank();
    end;

    local procedure CalculateAmountRentedPastMonth()
    var
        Library: Record Library;
        RentReturnLog: Record "Rent Return Log";
    begin
        if Library.FindSet() then
            repeat
                RentReturnLog.SetRange("Book No.", Library."Book No.");
                RentReturnLog.SetRange(Type, 'Rent');
                RentReturnLog.SetRange("Entry Date", CalcDate('-1M', Today), Today);
                if RentReturnLog.FindSet() then
                    Library.Validate("Amount Rented Last Month", RentReturnLog.Count)
                else
                    Library.Validate("Amount Rented Last Month", 0);
                Library.Modify();
            until Library.Next() = 0;
    end;

    local procedure SetRank()
    var
        Library: Record Library;
        PreviousRecord: Record Library;
        Rank: Integer;
    begin
        Library.SetCurrentKey("Amount Rented Last Month");
        Library.Ascending(false);
        if Library.FindSet() then
            repeat
                if PreviousRecord."Amount Rented Last Month" <> Library."Amount Rented Last Month" then
                    Library.Validate("Rented Rank", PreviousRecord."Rented Rank" + 1)
                else
                    Library.Validate("Rented Rank", PreviousRecord."Rented Rank");
                Library.Modify();
                PreviousRecord.Copy(Library);
            until Library.Next() = 0;
    end;

    var
        myInt: Integer;
}
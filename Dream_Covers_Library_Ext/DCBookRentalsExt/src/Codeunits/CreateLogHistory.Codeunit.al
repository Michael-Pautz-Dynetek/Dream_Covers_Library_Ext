codeunit 50419 "Create Log History"
{
    trigger OnRun()
    begin
        ClearLogData();
        LogRentReturn('B-0001', 'Adatum Corporation', DMY2Date(23, 04, 2024), 'The Hobbit', true);
        LogRentReturn('B-0002', 'Alpine Ski House', DMY2Date(30, 04, 2024), 'Harry Potter and the Philosophers Stone', true);
        LogRentReturn('B-0001', 'Adatum Corporation', DMY2Date(04, 05, 2024), 'The Hobbit', false);
        LogRentReturn('B-0003', 'Trey Research', DMY2Date(10, 05, 2024), 'Jack Reacher', true);
        LogRentReturn('B-0002', 'Alpine Ski House', DMY2Date(15, 05, 2024), 'Harry Potter and the Philosophers Stone', false);
        LogRentReturn('B-0001', 'School of Fine Art', DMY2Date(25, 07, 2024), 'The Hobbit', true);
        LogRentReturn('B-0001', 'School of Fine Art', DMY2Date(10, 08, 2024), 'The Hobbit', false);
        LogRentReturn('B-0003', 'Trey Research', DMY2Date(11, 08, 2024), 'Jack Reacher', false);
        LogRentReturn('B-0007', 'Relecloud', DMY2Date(30, 08, 2024), 'Ready Player One', true);
        LogRentReturn('B-0008', 'Trey Research', DMY2Date(20, 09, 2024), 'It', true);
        LogRentReturn('B-0007', 'Relecloud', DMY2Date(14, 10, 2024), 'Ready Player One', false);
        LogRentReturn('B-0001', 'Alpine Ski House', DMY2Date(14, 10, 2024), 'The Hobbit', true);
        //
        LogRentReturn('B-0015', 'Trey Research', DMY2Date(28, 10, 2024), 'Harry Potter and the Prisoner of Azkaban', true);
        LogRentReturn('B-0001', 'Alpine Ski House', DMY2Date(01, 11, 2024), 'The Hobbit', false);
        LogRentReturn('B-0018', 'Relecloud', DMY2Date(04, 11, 2024), 'Lord of the Rings: The Two Towers', true);
        LogRentReturn('B-0015', 'Trey Research', DMY2Date(24, 11, 2024), 'Harry Potter and the Prisoner of Azkaban', false);
        LogRentReturn('B-0018', 'Relecloud', DMY2Date(25, 11, 2024), 'Lord of the Rings: The Two Towers', false);
        LogRentReturn('B-0005', 'School of Fine Art', DMY2Date(14, 12, 2024), 'Harry Potter and the Chamber of Secrets', true);
        LogRentReturn('B-0005', 'School of Fine Art', DMY2Date(01, 01, 2025), 'Harry Potter and the Chamber of Secrets', false);
    end;

    local procedure LogRentReturn(BookNo: Code[20]; CustomerName: Text[250]; EntryDate: Date; Title: Text[250]; Rent: Boolean)
    var
        RentReturnLog: Record "Rent Return Log";
    begin
        RentReturnLog.Init();
        RentReturnLog.Validate("Entry No.");
        RentReturnLog.Validate("Book No.", BookNo);
        RentReturnLog.Validate("Customer Name", CustomerName);
        RentReturnLog.Validate("Entry Date", EntryDate);
        RentReturnLog.Validate(Title, Title);
        if Rent then
            RentReturnLog.Validate("Type", 'Rent')
        else
            RentReturnLog.Validate("Type", 'Return');
        RentReturnLog.Insert(true);
    end;

    local procedure ClearLogData()
    var
        RentReturnLog: Record "Rent Return Log";
    begin
        if RentReturnLog.FindSet() then
            repeat
                RentReturnLog.Delete();
            until RentReturnLog.Next() = 0;
    end;

    var
        myInt: Integer;
}
codeunit 50416 "Overdue Update"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    begin
        case Rec."Parameter String" of
            'Update Renting Details':
                UpdateRentingDetails();
        end;
        
    end;

    local procedure UpdateRentingDetails()
    var
        Library: Record Library;
        BookRentals: Codeunit "Book Rentals";
    begin
        Library.SetRange(Rented, true);
        if Library.FindSet() then
            repeat
                BookRentals.CalcWeeksOverdue(Library);
                BookRentals.UpdateOverdueLevel(Library);
                Library.Modify(true);
            until Library.Next() = 0;

        BookRentals.GetHighestLevel();
    end;
    
    var
        myInt: Integer;
}
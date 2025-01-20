codeunit 50204 "Most Rented"
{
    trigger OnRun()
    var
        Counter: Integer;
        Result: Text;
        Books: Record Library;
        MostRentedMessage: Label 'The 3 most rented books in the library are:', Comment = 'Message to display the 3 most rented books.';
    begin
        Counter := 0;
        Result := '';
        Books.SetCurrentKey("Amount Rented");
        Books.Ascending(false);
        if Books.FindFirst() then begin
            repeat
                Result += '\•' + Books.Title;
                Counter += 1;
            until (Books.Next() = 0) or (Counter = 3);
        end;
        Message(MostRentedMessage + Result);
    end;
}
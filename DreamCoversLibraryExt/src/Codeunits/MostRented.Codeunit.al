codeunit 50204 "Most Rented"
{
    trigger OnRun()
    var
        Counter: Integer;
        Result: Text;
        Books: Record Library;
    begin
        Counter := 0;
        Result := '';
        Books.SetCurrentKey("Amount Rented");
        if Books.FindLast() then begin
            repeat
                Result += '\•' + Books.Title;
                Counter += 1;
            until (Books.Next(-1) = 0) or (Counter = 3);
        end;
        Message('The 3 most rented books in the library are:' + Result);
    end;
}
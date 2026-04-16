codeunit 50204 "Most Rented"
{
    trigger OnRun()
    var
        Books: Record Library;
        Counter: Integer;
        Result: Text;
        MostRentedBooks: Label 'Top 3 most rented books historically:\';
    begin
        Counter := 1;
        Result := '';
        Books.SetCurrentKey("Amount Rented");
        Books.Ascending(false);
        Books.SetLoadFields(Title);
        if Books.FindFirst() then
            repeat
                Result += '\' + Format(Counter) + '. ' + Books.Title + '\';
                Counter += 1;
            until (Books.Next() = 0) or (Counter = 4);
        Message(MostRentedBooks + Result);
    end;

    procedure OpenSpecifiedView(ViewID: Text; PageID: Integer)
    var
        DefaultView: Text;
        URL: Text;
    begin
        DefaultView := '&view=' + ViewID;
        URL := GetUrl(CurrentClientType, CompanyName, ObjectType::Page, PageID) + DefaultView;
        Hyperlink(URL);
    end;
}
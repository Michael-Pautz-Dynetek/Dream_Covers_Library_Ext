codeunit 50529 "Author Management"
{

    procedure PopularAuthors()
    var
        Authors: Record Authors;
        Counter: Integer;
        Result: Text;
        MostRentedAuthors: Label 'Top 3 most popular Authors:\';
    begin
        Counter := 1;
        Result := '';
        Authors.SetCurrentKey("Books Rented Amount");
        Authors.Ascending(false);
        if Authors.FindFirst() then
            repeat
                Result += '\' + Format(Counter) + '. ' + Authors.Name + '\';
                Counter += 1;
            until (Authors.Next() = 0) or (Counter = 4);
        Message(MostRentedAuthors + Result);
    end;
}
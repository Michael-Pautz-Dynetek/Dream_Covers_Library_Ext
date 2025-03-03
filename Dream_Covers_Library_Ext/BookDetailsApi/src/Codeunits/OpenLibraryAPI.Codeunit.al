codeunit 50501 "Open Library API"
{
    trigger OnRun()
    begin

    end;

    procedure SearchBookRequest(SearchText: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        RequestJsonBody: JsonObject;
        Query: Text;
    begin
        AATRestHelper.LoadAPIConfig('AAT0001');
        Query:='?title='+SearchText;
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + Query);
        AATRestHelper.SetContentType('application/json');
        AATRestHelper.Send();
    end;

    var
        myInt: Integer;
}
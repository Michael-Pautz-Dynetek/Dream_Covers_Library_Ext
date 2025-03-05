codeunit 50501 "Open Library API"
{
    trigger OnRun()
    begin

    end;

    procedure SearchBookRequest(SearchText: Text; var TempLibrary: Record Library temporary)
    var
        AATJsonHelper: Codeunit "AAT JSON Helper";
        ResultObject: JsonObject;
        LinesArray: JsonArray;
        LinesToken: JsonToken;
        DataObject: JsonObject;
        Query: Text;
        counter: Integer;
    begin
        Query := '?title=' + FormatSearchText(SearchText) + '&page=1&limit=100';
        SendGetRequest('AAT0001', AATJsonHelper, ResultObject, Query);
        counter := 0;
        TempLibrary.DeleteAll();
        if AATJsonHelper.GetJsonArray(ResultObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                TempLibrary.Init();
                TempLibrary.Validate("Book No.", Format(counter));
                TempLibrary.Validate(Title, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'title').AsText());
                TempLibrary.Validate("Open Library ID", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'key').AsCode());
                TempLibrary.Insert();
                counter += 1;
            end;
    end;

    procedure GetBookDescriptionRequest(BookKey: Code[50]; var Library: Record Library)
    var
        AATJsonHelper: Codeunit "AAT JSON Helper";
        ResultObject: JsonObject;
        Query: Text;
    begin
        Query := BookKey + '.json';
        SendGetRequest('AAT0003', AATJsonHelper, ResultObject, Query);
        //Library.Validate(Description, AATJsonHelper.GetJsonObject(ResultObject, 'description').AsText());
    end;


    local procedure FormatSearchText(SearchText: Text): Text
    begin
        exit(SearchText.Replace(' ', '+'));
    end;

    local procedure SendGetRequest(ApiNo: Code[20]; var AATJsonHelper: Codeunit "AAT JSON Helper"; var ResultObject: JsonObject; var Query: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
    begin
        AATRestHelper.LoadAPIConfig(ApiNo);
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + Query);
        AATRestHelper.SetContentType('application/json');
        AATRestHelper.Send();

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        ResultObject := AATJsonHelper.GetJsonObject();
    end;

    var
        myInt: Integer;
}
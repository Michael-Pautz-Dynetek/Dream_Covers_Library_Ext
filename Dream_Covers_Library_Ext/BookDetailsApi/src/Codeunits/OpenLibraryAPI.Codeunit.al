codeunit 50501 "Open Library API"
{
    trigger OnRun()
    begin

    end;

    procedure SearchBookRequest(SearchText: Text; var TempLibrary: Record Library temporary)
    var
        ResultObject, DataObject : JsonObject;
        LinesArray: JsonArray;
        LinesToken: JsonToken;
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
                GetWorksDetailsRequest(TempLibrary."Open Library ID", TempLibrary);
                TempLibrary.Insert();
                counter += 1;
            end;
    end;

    procedure GetWorksDetailsRequest(WorksKey: Code[50]; var Library: Record Library)
    var
        ResultObject, DataObject : JsonObject;
        Query: Text;
    begin
        Query := WorksKey + '.json';
        SendGetRequest('AAT0003', AATJsonHelper, ResultObject, Query);
        Library.Validate(Description, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'description').AsText());
        AATJsonHelper.GetJsonObject(ResultObject, 'created', DataObject);
        Library.Validate("Date Created", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsDateTime());
    end;

    local procedure GetBookDetailsRequest(BookKey: Code[50]; var Library: Record Library)
    var
        ResultObject, DataObject : JsonObject;
        Query: Text;
    begin
        Query := BookKey + '.json';
        SendGetRequest('AAT0003', AATJsonHelper, ResultObject, Query);
        Library.Validate(Description, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'description').AsText());
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
        AATJsonHelper: Codeunit "AAT JSON Helper";
}
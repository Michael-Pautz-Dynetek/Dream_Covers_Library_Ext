codeunit 50501 "Open Library API"
{
    trigger OnRun()
    begin

    end;

    procedure SearchBookRequest(SearchText: Text; var TempLibrary: Record Library temporary)
    var
        AATJsonHelper: Codeunit "AAT JSON Helper";
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        LinesArray, AuthorCodeArray, AuthorNameArray : JsonArray;
        LinesToken, JsonToken : JsonToken;
        Query, AuthorString : Text;
        counter: Integer;
    begin
        Query := '?title=' + FormatSearchText(SearchText) + '&page=1&limit=100';
        SendGetRequest('AAT0001', ResultObject, Query, AATRestHelper, 'application/json');
        counter := 0;
        TempLibrary.DeleteAll();
        if AATJsonHelper.GetJsonArray(ResultObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                TempLibrary.Init();
                TempLibrary.Validate("Book No.", Format(counter));
                TempLibrary.Validate(Title, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'title').AsText());
                TempLibrary.Validate("Open Library ID", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'key').AsCode());
                if DataObject.Get('cover_edition_key', JsonToken) then
                    TempLibrary.Validate("Cover No.", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'cover_edition_key').AsCode());
                if AATJsonHelper.GetJsonArray(DataObject, 'author_key', AuthorCodeArray) then begin
                    FormatAuthors(TempLibrary."Author Codes", AuthorCodeArray, AuthorString);

                end;
                if AATJsonHelper.GetJsonArray(DataObject, 'author_name', AuthorNameArray) then begin
                    FormatAuthors(TempLibrary.Author, AuthorNameArray, AuthorString);
                end;
                TempLibrary.Insert();
                counter += 1;
            end;
        
    end;

    procedure GetBookCoverRequest(CoverNo: Code[50]; var Library: Record Library)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        JsonToken: JsonToken;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        InStream: InStream;
        Query: Text;
    begin
        Query := '/' + CoverNo + '.jpg';
        AATRestHelper.LoadAPIConfig('AAT0006');
        HttpClient.Get(AATRestHelper.GetAPIConfigBaseEndpoint() + Query, HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode then begin
            HttpResponseMessage.Content.ReadAs(InStream);
            Library.Cover.ImportStream(InStream, '');
        end else
            Error('Image download failure');
    end;

    procedure GetWorksDetailsRequest(WorksKey: Code[50]; var Library: Record Library)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        JsonToken: JsonToken;
        Query: Text;
    begin
        Query := WorksKey + '.json';
        SendGetRequest('AAT0003', ResultObject, Query, AATRestHelper, 'application/json');
        if ResultObject.Get('description', JsonToken) then
            if JsonToken.IsObject then begin
                AATJsonHelper.GetJsonObject(ResultObject, 'description', DataObject);
                Library.Validate(Description, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
            end
            else
                Library.Validate(Description, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'description').AsText());
        AATJsonHelper.GetJsonObject(ResultObject, 'created', DataObject);
        Library.Validate("Date Created", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsDateTime());
    end;

    procedure GetGeneralAuthorRequest(AuthorKey: Text; AuthorName: Text; var Authors: Record Authors)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        LinesArray: JsonArray;
        LinesToken, JsonToken : JsonToken;
        Query: Text;
        DeathDate: Date;
    begin
        Query := '?q=' + FormatSearchText(AuthorName);
        SendGetRequest('AAT0004', ResultObject, Query, AATRestHelper, 'application/json');
        if AATJsonHelper.GetJsonArray(ResultObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                if AATJsonHelper.GetJsonTokenAsValue(DataObject, 'key').AsText() = AuthorKey then begin
                    // if DataObject.Get('death_date', JsonToken) then begin
                    //     Evaluate(DeathDate, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'death_date').AsText(), 1);
                    //     Authors.Validate("Death Date", DeathDate);
                    // end;
                    if DataObject.Get('work_count', JsonToken) then
                        Authors.Validate("Work Count", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'work_count').AsInteger());
                    if DataObject.Get('top_work', JsonToken) then
                        Authors.Validate("Top Work", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'top_work').AsText());
                end;
            end;
    end;

    procedure GetAuthorDetailsRequest(AuthorKey: Text; var Authors: Record Authors)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        JsonToken: JsonToken;
        Query: Text;
        BirthDate, DeathDate : Date;
    begin
        Query := '/' + AuthorKey + '.json';
        SendGetRequest('AAT0005', ResultObject, Query, AATRestHelper, 'application/json');
        //Authors.Validate("Author No.", AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'key').AsCode());
        if ResultObject.Get('birth_date', JsonToken) then begin
            Evaluate(BirthDate, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'birth_date').AsText(), 1);
            Authors.Validate("Birth Date", BirthDate);
        end;
        if ResultObject.Get('death_date', JsonToken) then begin
            Evaluate(DeathDate, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'death_date').AsText(), 1);
            Authors.Validate("Death Date", DeathDate);
        end;
        if ResultObject.Get('bio', JsonToken) then
            if JsonToken.IsObject then begin
                AATJsonHelper.GetJsonObject(ResultObject, 'bio', DataObject);
                Authors.Validate(Bio, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
            end else
                Authors.Validate(Bio, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'bio').AsText());
        if ResultObject.Get('personal_name', JsonToken) then
            Authors.Validate("Personal Name", AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'personal_name').AsText());
        Authors.Validate(Name, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'name').AsText());
    end;

    local procedure FormatSearchText(SearchText: Text): Text
    begin
        exit(SearchText.Replace(' ', '+'));
    end;

    local procedure SendGetRequest(ApiNo: Code[20]; var ResultObject: JsonObject; var Query: Text; var AATRestHelper: Codeunit "AAT REST Helper"; ContentType: Text)
    begin
        AATRestHelper.LoadAPIConfig(ApiNo);
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + Query);
        AATRestHelper.SetContentType(ContentType);
        AATRestHelper.Send();

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        ResultObject := AATJsonHelper.GetJsonObject();
    end;

    local procedure FormatAuthors(var Field: Text; var AuthorArray: JsonArray; var AuthorString: Text)
    var
        AuthorToken: JsonToken;
        IsFirst: Boolean;
    begin
        AuthorString := '';
        IsFirst := true;
        foreach AuthorToken in AuthorArray do begin
            if IsFirst <> true then
                AuthorString += ',' + AuthorToken.AsValue().AsCode()
            else begin
                AuthorString += AuthorToken.AsValue().AsCode();
                IsFirst := false;
            end;
        end;
        Field := AuthorString;
    end;

    var
        AATJsonHelper: Codeunit "AAT JSON Helper";
    //AATRestHelper: Codeunit "AAT REST Helper";

}
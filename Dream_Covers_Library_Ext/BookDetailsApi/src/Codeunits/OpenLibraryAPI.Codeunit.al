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
        Query, AuthorString, ReferenceID : Text;
        CoverKey: Code[50];
        counter: Integer;
    begin
        ReferenceID := 'Book Search: ' + SearchText;
        Query := '/search.json?title=' + FormatSearchText(SearchText) + '&page=1&limit=100';
        SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
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
                    TempLibrary.Validate("Cover No.", JsonToken.AsValue().AsText());
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
        InStream: InStream;
        Query, ReferenceID : Text;
    begin
        ReferenceID := 'Book Cover: ' + CoverNo;
        Query := '/b/olid/' + CoverNo + '.jpg';
        GetImageRequest(Query, InStream);
        Library.Cover.ImportStream(InStream, '');
    end;

    procedure GetAuthorPhotoRequest(AuthorNo: Code[50]; var Author: Record Authors)
    var
        InStream: InStream;
        Query, ReferenceID : Text;
    begin
        ReferenceID := 'Author Photo: ' + AuthorNo;
        Query := '/a/olid/' + AuthorNo + '.jpg';
        GetImageRequest(Query, InStream);
        Author.Photo.ImportStream(InStream, '');
    end;

    local procedure GetImageRequest(Query: Text; var InStream: InStream)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
    begin
        AATRestHelper.LoadAPIConfig('AAT0006');
        HttpClient.Get(AATRestHelper.GetAPIConfigBaseEndpoint() + Query, HttpResponseMessage);
        if HttpResponseMessage.IsSuccessStatusCode then
            HttpResponseMessage.Content.ReadAs(InStream)
        //Author.Photo.ImportStream(InStream, '');
        else
            Error('Image download failure');
    end;

    procedure GetWorksDetailsRequest(WorksKey: Code[50]; var Library: Record Library)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        JsonToken: JsonToken;
        Query, ReferenceID : Text;
    begin
        ReferenceID := 'Book Details: ' + WorksKey;
        Query := WorksKey + '.json';
        SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
        if ResultObject.Get('description', JsonToken) then
            if JsonToken.IsObject then begin
                //DataObject := JsonToken.AsObject();
                //Library.Validate(Description, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
                Library.Validate(Description, AATJsonHelper.SelectJsonValueAsText('$.description.value', false));
            end
            else
                Library.Validate(Description, AATJsonHelper.SelectJsonValueAsText('$.description', false));
        AATJsonHelper.GetJsonObject(ResultObject, 'created', DataObject);
        Library.Validate("Date Created", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsDateTime());
    end;

    procedure GetGeneralAuthorRequest(AuthorKey: Text; AuthorName: Text; var Authors: Record Authors)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        LinesArray: JsonArray;
        LinesToken, JsonToken : JsonToken;
        Query, ReferenceID : Text;
        DeathDate: Date;
    begin
        ReferenceID := 'General Author: ' + AuthorKey;
        Query := '/search/authors.json?q=' + FormatSearchText(AuthorName);
        SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
        if AATJsonHelper.GetJsonArray(ResultObject, 'docs', LinesArray) then
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                if AATJsonHelper.GetJsonTokenAsValue(DataObject, 'key').AsText() = AuthorKey then begin
                    if DataObject.Get('work_count', JsonToken) then
                        Authors.Validate("Work Count", JsonToken.AsValue().AsInteger());
                    if DataObject.Get('top_work', JsonToken) then
                        Authors.Validate("Top Work", JsonToken.AsValue().AsText());
                end;
            end;
    end;

    procedure GetAuthorDetailsRequest(AuthorKey: Text; var Authors: Record Authors)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        JsonToken: JsonToken;
        Query, ReferenceID : Text;
        BirthDate, DeathDate : Date;
    begin
        ReferenceID := 'Author Details: ' + AuthorKey;
        Query := '/authors/' + AuthorKey + '.json';
        SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
        //Authors.Validate("Author No.", AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'key').AsCode());
        //if ResultObject.Get('birth_date', JsonToken) then begin
        Evaluate(BirthDate, AATJsonHelper.SelectJsonValueAsText('$.birth_date', false), 1);
        Authors.Validate("Birth Date", BirthDate);
        //end;
        //if ResultObject.Get('death_date', JsonToken) then begin
        Evaluate(DeathDate, AATJsonHelper.SelectJsonValueAsText('$.death_date', false), 1);
        Authors.Validate("Death Date", DeathDate);
        //end;
        if ResultObject.Get('bio', JsonToken) then
            if JsonToken.IsObject then begin
                //DataObject := JsonToken.AsObject();
                //Authors.Validate(Bio, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
                Authors.Validate(Bio, AATJsonHelper.SelectJsonValueAsText('$.bio.value', false));
            end else
                Authors.Validate(Bio, AATJsonHelper.SelectJsonValueAsText('$.bio', false));
        //if ResultObject.Get('personal_name', JsonToken) then
        Authors.Validate("Personal Name", AATJsonHelper.SelectJsonValueAsText('$.personal_name', false));
        Authors.Validate(Name, AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'name').AsText());
    end;

    local procedure FormatSearchText(SearchText: Text): Text
    begin
        exit(SearchText.Replace(' ', '+'));
    end;

    local procedure SendGetRequest(var ResultObject: JsonObject; var Query: Text; var AATRestHelper: Codeunit "AAT REST Helper"; ReferenceID: Text)
    begin
        GeneralSetup.Get(2);
        AATRestHelper.LoadAPIConfig(GeneralSetup."Open Library API AAT No.");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + Query);
        AATRestHelper.SetContentType('application/json');
        if AATRestHelper.Send(ReferenceID) then begin
            AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
            ResultObject := AATJsonHelper.GetJsonObject();
        end;
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
        GeneralSetup: Record "Library General Setup";
    //AATRestHelper: Codeunit "AAT REST Helper";

}
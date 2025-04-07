codeunit 50501 "Open Library API"
{
    //[TryFunction]
    procedure SearchBookRequest(SearchText: Text; var TempLibrary: Record Library temporary)
    var
        AATJsonHelper: Codeunit "AAT JSON Helper";
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        LinesArray, AuthorCodeArray, AuthorNameArray : JsonArray;
        LinesToken, JsonToken : JsonToken;
        Window: Dialog;
        Query, ReferenceID : Text;
        CoverKey: Code[50];
        counter, InsertedRowCount, UpdateInterval : Integer;
    begin
        ReferenceID := 'Book Search: ' + SearchText;
        Query := '/search.json?title=' + FormatSearchText(SearchText) + '&page=1&limit=100';
        // SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
        GeneralSetup.Get();
        AATRestHelper.LoadAPIConfig(GeneralSetup."Open Library API AAT No.");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + Query);
        AATRestHelper.SetContentType('application/json');
        if AATRestHelper.Send(ReferenceID) then begin
            AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
            ResultObject := AATJsonHelper.GetJsonObject();
        end else
            Error(GetLastErrorText());
        // if not SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID) then
        //     Error(GetLastErrorText());
        counter := 0;
        TempLibrary.DeleteAll();
        if AATJsonHelper.GetJsonArray(ResultObject, 'docs', LinesArray) then begin
            InsertedRowCount := 0;
            UpdateInterval := 10;
            if GuiAllowed then
                Window.Open('Loading Books: #1', InsertedRowCount);
            foreach LinesToken in LinesArray do begin
                DataObject := LinesToken.AsObject();
                TempLibrary.Init();
                TempLibrary.Validate("Book No.", Format(counter));
                TempLibrary.Validate(Title, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'title').AsText());
                TempLibrary.Validate("Open Library ID", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'key').AsCode());

                if DataObject.Get('cover_edition_key', JsonToken) then
                    TempLibrary.Validate("Cover No.", JsonToken.AsValue().AsText());

                if AATJsonHelper.GetJsonArray(DataObject, 'author_key', AuthorCodeArray) then
                    FormatArray(TempLibrary."Author Codes", AuthorCodeArray);

                if AATJsonHelper.GetJsonArray(DataObject, 'author_name', AuthorNameArray) then
                    FormatArray(TempLibrary.Author, AuthorNameArray);

                TempLibrary.Insert();
                counter += 1;
                InsertedRowCount += 1;

                if ((InsertedRowCount mod UpdateInterval) = 0) Or (InsertedRowCount = 1) then
                    Window.Update(1, InsertedRowCount);
            end;
            Window.Close();
        end;
    end;

    procedure GetBookCoverRequest(CoverNo: Code[50]; var Library: Record Library)
    var
        InStream: InStream;
        Query, ReferenceID : Text;
    begin
        ReferenceID := 'Book Cover: ' + CoverNo;
        Query := '/b/olid/' + CoverNo + '.jpg';
        if GetImageRequest(Query, InStream) then
            Library.Cover.ImportStream(InStream, '');
    end;

    procedure GetAuthorPhotoRequest(AuthorNo: Code[50]; var Author: Record Authors)
    var
        InStream: InStream;
        Query, ReferenceID : Text;
    begin
        ReferenceID := 'Author Photo: ' + AuthorNo;
        Query := '/a/olid/' + AuthorNo + '.jpg';
        if GetImageRequest(Query, InStream) then
            Author.Photo.ImportStream(InStream, '');
    end;

    [TryFunction]
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

    [TryFunction]
    procedure GetWorksDetailsRequest(WorksKey: Code[50]; var Library: Record Library)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        ResultObject, DataObject : JsonObject;
        SubjectArray, PlacesArray, PeopleArray : JsonArray;
        JsonToken: JsonToken;
        OutStream: OutStream;
        Query, ReferenceID : Text;
    begin
        ReferenceID := 'Book Details: ' + WorksKey;
        Query := WorksKey + '.json';
        SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
        // if not SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID) then
        //     Error(GetLastErrorText());
        Library.Description.CreateOutStream(OutStream);
        if ResultObject.Get('description', JsonToken) then
            if JsonToken.IsObject then
                //DataObject := JsonToken.AsObject();
                //Library.Validate(Description, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
                //Library.Validate(Description, AATJsonHelper.SelectJsonValueAsText('$.description.value', false));
                OutStream.WriteText(AATJsonHelper.SelectJsonValueAsText('$.description.value', false))
            else
                OutStream.WriteText(AATJsonHelper.SelectJsonValueAsText('$.description', false));
        // AATJsonHelper.GetJsonObject(ResultObject, 'created', DataObject);
        // Library.Validate("Date Created", AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsDateTime());
        Library.Validate("Date Created", AATJsonHelper.SelectJsonValueAsDateTime('$.created.value', false));

        if AATJsonHelper.GetJsonArray(ResultObject, 'subjects', SubjectArray) then
            FormatArray(Library.Subjects, SubjectArray, true);

        if AATJsonHelper.GetJsonArray(ResultObject, 'subject_places', PlacesArray) then
            FormatArray(Library."Subject Places", PlacesArray, true);

        if AATJsonHelper.GetJsonArray(ResultObject, 'subject_people', PeopleArray) then
            FormatArray(Library."Subject People", PeopleArray, true);
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
        // if not SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID) then
        //     Error(GetLastErrorText());
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
        OutStream: OutStream;
        Query, ReferenceID, BirthText, DeathText : Text;
        BirthDate, DeathDate : Date;
        BirthYear, DeathYear : Integer;
    begin
        ReferenceID := 'Author Details: ' + AuthorKey;
        Query := '/authors/' + AuthorKey + '.json';
        SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID);
        // if not SendGetRequest(ResultObject, Query, AATRestHelper, ReferenceID) then
        //     Error(GetLastErrorText());
        //Authors.Validate("Author No.", AATJsonHelper.GetJsonTokenAsValue(ResultObject, 'key').AsCode());
        //if ResultObject.Get('birth_date', JsonToken) then begin
        DeathText := AATJsonHelper.SelectJsonValueAsText('$.death_date', false);
        if StrLen(DeathText) <> 4 then
            Evaluate(DeathDate, DeathText, 1)
        else begin
            Evaluate(DeathYear, DeathText);
            DeathDate := DMY2Date(1, 1, DeathYear);
        end;
        Authors.Validate("Death Date", DeathDate);

        BirthText := AATJsonHelper.SelectJsonValueAsText('$.birth_date', false);
        if StrLen(BirthText) <> 4 then
            Evaluate(BirthDate, BirthText, 1)
        else begin
            Evaluate(BirthYear, BirthText);
            BirthDate := DMY2Date(1, 1, BirthYear);
        end;
        Authors.Validate("Birth Date", BirthDate);
        //end;
        //if ResultObject.Get('death_date', JsonToken) then begin

        //end;
        Authors.Bio.CreateOutStream(OutStream);
        if ResultObject.Get('bio', JsonToken) then
            if JsonToken.IsObject then begin
                //DataObject := JsonToken.AsObject();
                //Authors.Validate(Bio, AATJsonHelper.GetJsonTokenAsValue(DataObject, 'value').AsText());
                OutStream.WriteText(AATJsonHelper.SelectJsonValueAsText('$.bio.value', false));
            end else
                OutStream.WriteText(AATJsonHelper.SelectJsonValueAsText('$.bio', false));
        //if ResultObject.Get('personal_name', JsonToken) then
        Authors.Validate("Personal Name", AATJsonHelper.SelectJsonValueAsText('$.personal_name', false));
        Authors.Validate(Name, AATJsonHelper.SelectJsonValueAsText('$.name', false));
    end;

    local procedure FormatSearchText(SearchText: Text): Text
    begin
        exit(SearchText.Replace(' ', '+'));
    end;

    //[TryFunction]
    local procedure SendGetRequest(var ResultObject: JsonObject; var Query: Text; var AATRestHelper: Codeunit "AAT REST Helper"; ReferenceID: Text)
    begin
        GeneralSetup.Get();
        AATRestHelper.LoadAPIConfig(GeneralSetup."Open Library API AAT No.");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + Query);
        AATRestHelper.SetContentType('application/json');
        if AATRestHelper.Send(ReferenceID) then begin
            AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
            ResultObject := AATJsonHelper.GetJsonObject();
        end else
            Error(GetLastErrorText());
    end;

    //[TryFunction]
    local procedure FormatArray(var Field: Text; var ValueArray: JsonArray/*; var AuthorString: Text*/)
    var
        JsonToken: JsonToken;
        IsFirst: Boolean;
        ResultString: Text;
    begin
        ResultString := '';
        IsFirst := true;
        foreach JsonToken in ValueArray do begin
            if IsFirst <> true then
                ResultString += ',' + JsonToken.AsValue().AsCode()
            else begin
                ResultString += JsonToken.AsValue().AsCode();
                IsFirst := false;
            end;
        end;
        Field := ResultString;
    end;

    local procedure FormatArray(var Field: Text; var ValueArray: JsonArray; ListFormat: Boolean/*; var AuthorString: Text*/)
    var
        JsonToken: JsonToken;
        IsFirst: Boolean;
        ResultString: Text;
    begin
        ResultString := '';
        IsFirst := true;
        foreach JsonToken in ValueArray do
            ResultString += JsonToken.AsValue().AsCode() + '\';
        Field := ResultString;
    end;

    var
        AATJsonHelper: Codeunit "AAT JSON Helper";
        GeneralSetup: Record "Library General Setup";
    //AATRestHelper: Codeunit "AAT REST Helper";

}
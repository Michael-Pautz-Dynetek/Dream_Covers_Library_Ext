/// <summary>
/// Codeunit AAT JSON Helper (ID 80100).
/// </summary>
codeunit 80100 "AAT JSON Helper"
{
    Access = Public;

    var
        JsonObjectVar: JsonObject;
        JsonArrayVar: JsonArray;

    /// <summary>
    /// InitializeJsonObjectFromText.
    /// </summary>
    /// <param name="JSONText">Text.</param>
    procedure InitializeJsonObjectFromText(JSONText: Text)
    begin
        if not JsonObjectVar.ReadFrom(JSONText) then
            Error('Invalid JSON Text \ %1', JSONText);
    end;


    /// <summary>
    /// InitializeJsonOArrayFromText.
    /// </summary>
    /// <param name="JSONText">Text.</param>
    procedure InitializeJsonOArrayFromText(JSONText: Text)
    begin
        if not JsonArrayVar.ReadFrom(JSONText) then
            Error('Invalid JSON Text \ %1', JSONText);
    end;

    /// <summary>
    /// InitializeJsonObjectFromToken.
    /// </summary>
    /// <param name="Token">JsonToken.</param>
    procedure InitializeJsonObjectFromToken(Token: JsonToken)
    begin
        JsonObjectVar := Token.AsObject();
    end;

    /// <summary>
    /// GetJsonObject.
    /// </summary>
    /// <returns>Return value of type JsonObject.</returns>
    procedure GetJsonObject(): JsonObject
    begin
        exit(JsonObjectVar);
    end;

    /// <summary>
    /// GetJsonArray.
    /// </summary>
    /// <returns>Return value of type JsonObject.</returns>
    procedure GetJsonArray(): JsonArray
    begin
        exit(JsonArrayVar);
    end;

    /// <summary>
    /// GetJsonToken.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="TokenKey">text.</param>
    /// <returns>Return variable JsonToken of type JsonToken.</returns>
    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    /// <summary>
    /// GetJsonToken.
    /// </summary>
    /// <param name="TokenKey">text.</param>
    /// <returns>Return variable JsonToken of type JsonToken.</returns>
    procedure GetJsonToken(TokenKey: Text) JsonToken: JsonToken
    begin
        if not JsonObjectVar.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    /// <summary>
    /// GetJsonTokenAsValue.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="TokenKey">text.</param>
    /// <returns>Return variable JsonValue of type JsonValue.</returns>
    procedure GetJsonTokenAsValue(JsonObject: JsonObject; TokenKey: Text) JsonValue: JsonValue
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
        JsonValue := JsonToken.AsValue();
    end;

    /// <summary>
    /// SelectJsonToken.
    /// </summary>
    /// <param name="Path">text.</param>
    /// <returns>Return variable JsonToken of type JsonToken.</returns>
    procedure SelectJsonToken(Path: Text) JsonToken: JsonToken
    begin
        if not JsonObjectVar.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    /// <summary>
    /// SelectJsonToken.
    /// </summary>
    /// <param name="Path">Text.</param>
    /// <param name="GiveError">Boolean.</param>
    /// <returns>Return variable JsonToken of type JsonToken.</returns>
    procedure SelectJsonToken(Path: Text; GiveError: Boolean) JsonToken: JsonToken
    begin
        if not JsonObjectVar.SelectToken(Path, JsonToken) then
            if GiveError then
                Error('Could not find a token with path %1', Path);
    end;

    /// <summary>
    /// SelectJsonToken.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="Path">text.</param>
    /// <returns>Return variable JsonToken of type JsonToken.</returns>
    procedure SelectJsonToken(JsonObject: JsonObject; Path: Text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    local procedure CheckJsonValueNotNull(SelectedToken: JsonToken; Path: Text; GiveError: Boolean) NotNull: Boolean
    begin
        NotNull := true;

        if not SelectedToken.IsValue() then
            if GiveError then
                Error('Could not find a value token at path %1.', Path)
            else
                NotNull := false;

        if SelectedToken.AsValue().IsNull() or SelectedToken.AsValue().IsUndefined() then
            if GiveError then
                Error('Token at path %1 is Null or Undefined.', Path)
            else
                NotNull := false;
    end;

    procedure SelectJsonValueAsDecimal(Path: Text; GiveError: Boolean): Decimal
    var
        SelectedToken: JsonToken;
    begin
        SelectedToken := SelectJsonToken(Path, GiveError);
        if not CheckJsonValueNotNull(SelectedToken, Path, GiveError) then
            exit(0);
        exit(SelectedToken.AsValue().AsDecimal());

    end;

    procedure SelectJsonValueAsInteger(Path: Text; GiveError: Boolean): Integer
    var
        SelectedToken: JsonToken;
    begin
        SelectedToken := SelectJsonToken(Path, GiveError);
        if not CheckJsonValueNotNull(SelectedToken, Path, GiveError) then
            exit(0);
        exit(SelectedToken.AsValue().AsInteger());

    end;

    procedure SelectJsonValueAsText(Path: Text; GiveError: Boolean): Text
    var
        SelectedToken: JsonToken;
    begin
        SelectedToken := SelectJsonToken(Path, GiveError);
        if not CheckJsonValueNotNull(SelectedToken, Path, GiveError) then
            exit('');
        exit(SelectedToken.AsValue().AsText());

    end;

    procedure SelectJsonValueAsDate(Path: Text; GiveError: Boolean): Date
    var
        SelectedToken: JsonToken;
    begin
        SelectedToken := SelectJsonToken(Path, GiveError);
        if not CheckJsonValueNotNull(SelectedToken, Path, GiveError) then
            exit(0D);
        exit(SelectedToken.AsValue().AsDate());

    end;

    procedure SelectJsonValueAsDateTime(Path: Text; GiveError: Boolean): DateTime
    var
        SelectedToken: JsonToken;
    begin
        SelectedToken := SelectJsonToken(Path, GiveError);
        if not CheckJsonValueNotNull(SelectedToken, Path, GiveError) then
            exit(0DT);
        exit(SelectedToken.AsValue().AsDateTime());
    end;

    procedure SelectJsonValueAsBoolean(Path: Text; GiveError: Boolean): Boolean
    var
        SelectedToken: JsonToken;
    begin
        SelectedToken := SelectJsonToken(Path, GiveError);
        if not CheckJsonValueNotNull(SelectedToken, Path, GiveError) then
            exit(false);

        exit(SelectedToken.AsValue().AsBoolean());
    end;

    /// <summary>
    /// SetValue.
    /// </summary>
    /// <param name="Key">Text.</param>
    /// <param name="Value">text.</param>
    procedure SetValue("Key": Text; "Value": Text)
    begin
        if JsonObjectVar.Contains("Key") then
            JsonObjectVar.Replace("Key", "Value")
        else
            JsonObjectVar.Add("Key", "Value");

    end;

    /// <summary>
    /// GetJsonValue.
    /// </summary>
    /// <param name="FromObj">JsonObject.</param>
    /// <param name="KeyText">Text.</param>
    /// <param name="JsonValResult">VAR JsonValue.</param>
    /// <returns>False if an runtime error occurred. Otherwise true.</returns>
    [TryFunction]
    procedure GetJsonValue(FromObj: JsonObject; KeyText: Text; var JsonValResult: JsonValue)
    var
        Token: JsonToken;
    begin
        FromObj.Get(KeyText, Token);
        if Token.IsValue then begin
            JsonValResult := Token.AsValue();
            if JsonValResult.IsNull then
                Error('');
        end else
            Error('');
    end;

    /// <summary>
    /// GetJsonObject.
    /// </summary>
    /// <param name="FromObj">JsonObject.</param>
    /// <param name="KeyText">Text.</param>
    /// <param name="JsonObjResult">VAR JsonObject.</param>
    /// <returns>False if an runtime error occurred. Otherwise true.</returns>
    [TryFunction]
    procedure GetJsonObject(FromObj: JsonObject; KeyText: Text; var JsonObjResult: JsonObject)
    var
        Token: JsonToken;
    begin
        FromObj.Get(KeyText, Token);
        if Token.IsObject then
            JsonObjResult := Token.AsObject()
        else
            Error('');
    end;

    /// <summary>
    /// GetJsonArray.
    /// </summary>
    /// <param name="FromObj">JsonObject.</param>
    /// <param name="KeyText">Text.</param>
    /// <param name="JsonArrResult">VAR JsonArray.</param>
    /// <returns>False if an runtime error occurred. Otherwise true.</returns>
    [TryFunction]
    procedure GetJsonArray(FromObj: JsonObject; KeyText: Text; var JsonArrResult: JsonArray)
    var
        Token: JsonToken;
    begin
        FromObj.Get(KeyText, Token);
        if Token.IsArray then
            JsonArrResult := Token.AsArray()
        else
            Error('');
    end;
}
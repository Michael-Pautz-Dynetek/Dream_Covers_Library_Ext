/// <summary>
/// Codeunit AAT REST Helper (ID 80101).
/// </summary>
codeunit 80101 "AAT REST Helper"
{
    Access = Public;

    var
        // API Setups
        AatAPIConfig: Record "AAT API";
        WebHttpClient: HttpClient;
        WebHttpRequestMessage: HttpRequestMessage;
        WebHttpResponseMessage: HttpResponseMessage;
        WebRequestHeaders: HttpHeaders;
        WebContentHeaders: HttpHeaders;
        WebHttpContent: HttpContent;
        CurrentContentType: Text;
        RestHeaders: TextBuilder;
        ContentTypeSet: Boolean;
        SendRequestSucess: Boolean;
        TransmitFailure: Boolean; // Did the actual .Send() fail? or error on .Send()
        APIConfigBaseEndpoint: Text[250];
        APIConfigAccessToken: Text[1024];
        APIConfigSecretKey: Text[250];
        APIConfigRefreshToken: Text[250];
        APIConfigExpiryDate: DateTime;
        APIConfigOAuthEndpointURL: Text[500];


    /// <summary>
    /// Initialize.
    /// </summary>
    /// <param name="Method">Text.</param>
    /// <param name="URI">Text.</param>

    procedure Initialize(Method: Text; URI: Text);
    begin
        WebHttpRequestMessage.Method := Method;
        WebHttpRequestMessage.SetRequestUri(URI);

        WebHttpRequestMessage.GetHeaders(WebRequestHeaders);
    end;

    /// <summary>
    /// AddRequestHeader.
    /// </summary>
    /// <param name="HeaderKey">Text.</param>
    /// <param name="HeaderValue">Text.</param>
    procedure AddRequestHeader(HeaderKey: Text; HeaderValue: Text)
    begin
        RestHeaders.AppendLine(HeaderKey + ': ' + HeaderValue);

        WebRequestHeaders.Add(HeaderKey, HeaderValue);
    end;

    /// <summary>
    /// AddBody.
    /// </summary>
    /// <param name="Body">Text.</param>
    procedure AddBody(Body: Text)
    begin
        WebHttpContent.WriteFrom(Body);

        ContentTypeSet := true;
    end;

    /// <summary>
    /// SetContentType.
    /// </summary>
    /// <param name="ContentType">Text.</param>
    procedure SetContentType(ContentType: Text)
    begin
        CurrentContentType := ContentType;

        WebHttpContent.GetHeaders(WebContentHeaders);
        if WebContentHeaders.Contains('Content-Type') then
            WebContentHeaders.Remove('Content-Type');
        WebContentHeaders.Add('Content-Type', ContentType);
    end;

    /// <summary>
    /// Send.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure Send(): Boolean
    begin
        exit(Send(''));
    end;
    /// <summary>
    /// Send.
    /// /// </summary>
    /// <param name="ReferenceID">Unique Indentifier that can be used to find log entry for specific request - Text[1024].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure Send(ReferenceID: Text[1024]): Boolean
    var
        StartDateTime: DateTime;
        TotalDuration: Duration;
    begin

        if ContentTypeSet then
            WebHttpRequestMessage.Content(WebHttpContent);


        StartDateTime := CurrentDateTime();
        if not TrySend() then begin
            TransmitFailure := true;
            exit(false);
        end;
        TotalDuration := CurrentDateTime() - StartDateTime;

        if SendRequestSucess then
            if not WebHttpResponseMessage.IsSuccessStatusCode() then
                SendRequestSucess := false;

        Log(StartDateTime, TotalDuration, ReferenceID);

        exit(SendRequestSucess);

    end;


    [TryFunction]
    local procedure TrySend()
    begin
        TransmitFailure := false;
        SendRequestSucess := WebHttpClient.Send(WebHttpRequestMessage, WebHttpResponseMessage);
    end;

    /// <summary>
    /// IsTransmitIssue.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsTransmitIssue(): Boolean
    begin
        exit(TransmitFailure);
    end;

    /// <summary>
    /// GetResponseContentAsText.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetResponseContentAsText(): Text
    var
        ResponseContentText: Text;
    begin
        if not TryReadResponseAsText(ResponseContentText) then
            exit('');

        exit(ResponseContentText);
    end;

    [TryFunction]
    local procedure TryReadResponseAsText(var result: Text)
    var
        RestTempBlob: Codeunit "Temp Blob";
        ResponseInstream: InStream;
    begin

        RestTempBlob.CreateInStream(ResponseInstream);
        WebHttpResponseMessage.Content().ReadAs(result);
    end;

    procedure GetResponseAsInStream() ResponseStream: InStream
    begin
         //WebHttpResponseMessage.Content.ReadAs(ResponseStream);
    end;

    /// <summary>
    /// GetResponseReasonPhrase.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetResponseReasonPhrase(): Text
    begin
        exit(WebHttpResponseMessage.ReasonPhrase());
    end;

    /// <summary>
    /// GetHttpStatusCode.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetHttpStatusCode(): Integer
    begin
        exit(WebHttpResponseMessage.HttpStatusCode());
    end;

    local procedure Log(StartDateTime: DateTime; TotalDuration: Duration; ReferenceID: Text[1024])
    var
        AATAPIRequestLog: Record "AAT API Request Log";
        RESTTempBlob: Codeunit "Temp Blob";
        ResponseTempBlob: Codeunit "Temp Blob";
        RESTInStream: InStream;
        ResponseInStream: InStream;
        RequestOutStream: OutStream;
        IsHandled: Boolean;
    begin
        RESTTempBlob.CreateInStream(RESTInStream);
        if (not TransmitFailure) then
            WebHttpContent.ReadAs(RESTInStream);

        ResponseTempBlob.CreateInStream(ResponseInStream);
        if WebHttpResponseMessage.Content().ReadAs(ResponseInStream) then;

        AATAPIRequestLog.Init();

        AATAPIRequestLog."API No." := AatAPIConfig."No.";
        AATAPIRequestLog.RequestUrl := CopyStr(WebHttpRequestMessage.GetRequestUri(), 1, MaxStrLen(AATAPIRequestLog.RequestUrl));
        AATAPIRequestLog.RequestMethod := CopyStr(WebHttpRequestMessage.Method(), 1, MaxStrLen(AATAPIRequestLog.RequestMethod));
        AATAPIRequestLog.DateTimeCreated := StartDateTime;
        AATAPIRequestLog.User := CopyStr(UserId(), 1, MaxStrLen(AATAPIRequestLog.User));
        AATAPIRequestLog.Duraction := TotalDuration;
        AATAPIRequestLog.ContentType := CopyStr(CurrentContentType, 1, MaxStrLen(AATAPIRequestLog.ContentType));
        AATAPIRequestLog.RequestHeaders := CopyStr(RestHeaders.ToText(), 1, MaxStrLen(AATAPIRequestLog.RequestHeaders));
        AATAPIRequestLog."Reference ID" := ReferenceID;

        OnBeforeLogInsert(AATAPIRequestLog, IsHandled);

        if IsHandled then
            exit;

        AATAPIRequestLog.Insert();

        AATAPIRequestLog.ResponseHttpStatusCode := GetHttpStatusCode();
        // AATAPIRequestLog.Modify();

        AATAPIRequestLog.RequestBody.CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, RESTInStream);
        AATAPIRequestLog.RequestBodySize := AATAPIRequestLog.RequestBody.Length();
        // AATAPIRequestLog.Modify();

        AATAPIRequestLog.Response.CreateOutStream(RequestOutStream);
        CopyStream(RequestOutStream, ResponseInStream);
        AATAPIRequestLog.ResponseSize := AATAPIRequestLog.Response.Length();
        AATAPIRequestLog.Modify();

        OnAfterLogCreation(AATAPIRequestLog);
    end;

    // ### API Setups & Related Logic ###
    /// <summary>
    /// Load API Config and prepare variables according to API Status.
    /// Will Error if the API is Disabled or Blocked.
    /// </summary>
    /// <param name="APINo">The AAT API No to load.</param>

    procedure LoadAPIConfig(APINo: Text)
    var
        EndpointPath: Text;
    begin
        AatAPIConfig.Get(APINo);

        // Check if the API Is blocked or disabled
        if AatAPIConfig.Blocked then
            Error('Failed to Initalize API. The API %1 is Blocked.', AatAPIConfig."No.");

        if AatAPIConfig.Status = "AAT Status"::Disabled then
            Error('Failed to Initalize API. The API %1 is Disabled.', AatAPIConfig."No.");

        // Load Config Data
        case AatAPIConfig.Status of
            "AAT Status"::Production:
                begin
                    APIConfigBaseEndpoint := AatAPIConfig."Prod. Base Endpoint";
                    APIConfigAccessToken := AatAPIConfig."Prod. Access Token";
                    APIConfigSecretKey := AatAPIConfig."Prod. Secret Key";
                    APIConfigRefreshToken := AatAPIConfig."Prod. Refresh Token";
                    APIConfigExpiryDate := AatAPIConfig."Prod. Expiry DateTime";
                    APIConfigOAuthEndpointURL := AatAPIConfig."Prod. OAuth Endpoint URL"
                end;

            "AAT Status"::Development:
                begin
                    APIConfigBaseEndpoint := AatAPIConfig."Dev. Base Endpoint";
                    APIConfigAccessToken := AatAPIConfig."Dev. Access Token";
                    APIConfigSecretKey := AatAPIConfig."Dev. Secret Key";
                    APIConfigRefreshToken := AatAPIConfig."Dev. Refresh Token";
                    APIConfigExpiryDate := AatAPIConfig."Dev. Expiry DateTime";
                    APIConfigOAuthEndpointURL := AatAPIConfig."Dev. OAuth Endpoint URL"
                end;
        end;

        // Request Catcher Override
        if AatAPIConfig."Send to RequestCatcher" then begin
            EndpointPath := APIConfigBaseEndpoint;

            APIConfigBaseEndpoint := 'https://';
            APIConfigBaseEndpoint += AatAPIConfig."RequestCatcher Subdomain".Trim();
            APIConfigBaseEndpoint += '.requestcatcher.com';

            if GetEndpointPath(EndpointPath) then
                APIConfigBaseEndpoint += EndpointPath;
        end;
    end;

    local procedure GetEndpointPath(var EndpointPath: Text): Boolean
    var
        EndpointParts: List of [Text];
        EndpointPart: Text;
        PartIndex: Integer;
    begin
        EndpointParts := EndpointPath.Split('/');
        EndpointPath := '/';

        if EndpointParts.Count > 4 then begin
            for PartIndex := 4 to EndpointParts.Count do begin
                EndpointParts.Get(PartIndex, EndpointPart);
                EndpointPath += EndpointPart + '/';
            end;

            EndpointPath := EndpointPath.Substring(1, StrLen(EndpointPath) - 1);
            exit(true);
        end;

        exit(false);
    end;

    /// <summary>
    /// Add Basic Authentication header in the format: Basic B64([AccessToken]:[SecretKey])
    /// Error if AccessToken or SecretKey is empty.
    /// </summary>
    procedure AddBasicAuthHeader()
    var
        Base64Convert: Codeunit "Base64 Convert";
    begin
        if ((APIConfigAccessToken = '') or (APIConfigSecretKey = '')) then
            Error('Unable to set Authentication Header, "Access Token" or "Secret Key" is empty');

        AddRequestHeader('Authorization', 'Basic ' + Base64Convert.ToBase64(APIConfigAccessToken + ':' + APIConfigSecretKey));
    end;

    // ### API Config Related Getters ###

    /// <summary>
    /// EndpointHasExpired.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure EndpointHasExpired(): Boolean
    begin
        if AatAPIConfig."Send to RequestCatcher" then
            exit(false);

        if APIConfigExpiryDate <> 0DT then
            exit(false);

        exit(APIConfigExpiryDate > CurrentDateTime);
    end;

    /// <summary>
    /// GetAPIConfigBaseEndpoint.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetAPIConfigBaseEndpoint(): Text
    begin
        exit(APIConfigBaseEndpoint);
    end;

    /// <summary>
    /// GetAPIConfigSecretKey.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetAPIConfigAccessToken(): Text
    begin
        exit(APIConfigAccessToken);
    end;

    /// <summary>
    /// GetAPIConfigSecretKey.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetAPIConfigSecretKey(): Text
    begin
        exit(APIConfigSecretKey);
    end;

    /// <summary>
    /// GetAPIConfigRefreshToken.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetAPIConfigRefreshToken(): Text
    begin
        exit(APIConfigRefreshToken);
    end;

    /// <summary>
    /// GetAPIConfigExpiryDate.
    /// </summary>
    /// <returns>Return value of type Date.</returns>
    procedure GetAPIConfigExpiryDate(): DateTime
    begin
        exit(APIConfigExpiryDate);
    end;


    /// <summary>
    /// GetAPIConfigBlocked.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetAPIConfigBlocked(): Boolean
    begin
        exit(AatAPIConfig.Blocked);
    end;

    /// <summary>
    /// GetAPIConfigBlockedOrDisabled.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure GetAPIConfigBlockedOrDisabled(): Boolean
    begin
        exit(AatAPIConfig.Blocked and (AatAPIConfig.Status = "AAT Status"::Disabled));
    end;

    procedure GetOAuthEndpointURL(): Text[500]
    begin
        exit(APIConfigOAuthEndpointURL);
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeLogInsert(var AATAPIRequestLog: Record "AAT API Request Log"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterLogCreation(var AATAPIRequestLog: Record "AAT API Request Log")
    begin
    end;
}

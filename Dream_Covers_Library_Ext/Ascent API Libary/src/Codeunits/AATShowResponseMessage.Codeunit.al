/// <summary>
/// Codeunit AAT Show Response Message (ID 80103).
/// </summary>
codeunit 80103 "AAT Show Response Message"
{
    /// <summary>
    /// ShowResponseMessage.
    /// </summary>
    /// <param name="AATAPIRequestLog">VAR Record "AAT API Request Log".</param>
    procedure ShowResponseMessage(var AATAPIRequestLog: Record "AAT API Request Log");
    var
        Handled: Boolean;
    begin
        DoShowResponseMessage(AATAPIRequestLog, Handled);
    end;

    local procedure DoShowResponseMessage(var AATAPIRequestLog: Record "AAT API Request Log"; Handled: Boolean);
    var
        ResponseInstream: InStream;
        ResponseMessage: Text;
        TempText: Text;
        CRLF: Text[2];
    begin

        if Handled then
            exit;

        CRLF[1] := 13;
        CRLF[2] := 10;

        AATAPIRequestLog.CalcFields(Response);
        AATAPIRequestLog.Response.CreateInStream(ResponseInstream);
        // Instr.ReadText(RequestMessage);

        //show only 50,000 line
        while (not ResponseInstream.EOS) and (StrLen(ResponseMessage) < 50000) do begin
            ResponseInstream.ReadText(TempText);
            if (StrLen(ResponseMessage) > 0) then
                ResponseMessage := ResponseMessage + CRLF + TempText
            else
                ResponseMessage := TempText;
        end;


        Message(ResponseMessage);
    end;
}
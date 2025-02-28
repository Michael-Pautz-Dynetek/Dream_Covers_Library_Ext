/// <summary>
/// Codeunit AAT Show Request Message (ID 80102).
/// </summary>
codeunit 80102 "AAT Show Request Message"
{
    /// <summary>
    /// ShowRequestMessage.
    /// </summary>
    /// <param name="AATAPIRequestLog">VAR Record "AAT API Request Log".</param>
    procedure ShowRequestMessage(var AATAPIRequestLog: Record "AAT API Request Log");
    var
        Handled: Boolean;
    begin
        DoShowRequestMessage(AATAPIRequestLog, Handled);
    end;

    local procedure DoShowRequestMessage(var AATAPIRequestLog: Record "AAT API Request Log"; Handled: Boolean);
    var
        RequestInStream: InStream;
        RequestMessage: Text;
        TempText: Text;
        CRLF: Text[2];
    begin

        if Handled then
            exit;

        CRLF[1] := 13;
        CRLF[2] := 10;

        AATAPIRequestLog.CalcFields(RequestBody);
        AATAPIRequestLog.RequestBody.CreateInStream(RequestInStream);
        // Instr.ReadText(RequestMessage);

        //show only 50,000 line
        while (not RequestInStream.EOS) and (StrLen(RequestMessage) < 50000) do begin
            RequestInStream.ReadText(TempText);
            if (StrLen(RequestMessage) > 0) then
                RequestMessage := RequestMessage + CRLF + TempText
            else
                RequestMessage := TempText;
        end;

        Message(RequestMessage);
    end;

}
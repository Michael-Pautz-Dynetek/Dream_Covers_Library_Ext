codeunit 80105 "AAT Manage Request Log Entries"
{
    procedure ExportRequestLogEntries(AATAPIRequestLog: Record "AAT API Request Log"; StartDate: Date; EndDate: Date; UpdateInterval: Integer)
    var
        AATAPIRequestLog2: Record "AAT API Request Log";
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        PeriodText: text;
        Window: Dialog;
        TotalCounter: Integer;
        CurrCount: Integer;
        StartTime: Time;

    begin
        OnBeforeExportRequestLogEntries(AATAPIRequestLog, StartDate, EndDate);

        StartTime := Time;
        StartDateTime := CreateDateTime(StartDate, 0T);
        EndDateTime := CreateDateTime(EndDate, 235959T);

        AATAPIRequestLog.SetFilter(DateTimeCreated, '%1..%2', StartDateTime, EndDateTime);
        AATAPIRequestLog.SetCurrentKey(DateTimeCreated);
        if (AATAPIRequestLog.IsEmpty) then
            Error(ExportErrorLbl);

        PeriodText := format(StartDate).Replace('\', '-').Replace('/', '-') + '_' + format(EndDate).Replace('\', '-').Replace('/', '-');
        InitExport(PeriodText);
        // ExportedSalesOrderCount := ChangeLogEntry.Count;
        AATAPIRequestLog2.Init();
        AATAPIRequestLog2.SetCurrentKey(DateTimeCreated);
        AATAPIRequestLog2.CopyFilters(AATAPIRequestLog);
        TotalCounter := AATAPIRequestLog2.CountApprox;
        if GuiAllowed then
            Window.Open('Exporting API Request Log Entries. ...\Current Line: #1####\Total: #2####', CurrCount, TotalCounter);

        if AATAPIRequestLog2.FindSet() then
            repeat
                CurrCount += 1;
                MapChangeLogToCSV(AATAPIRequestLog2);

                if (CurrCount mod UpdateInterval = 0) or (CurrCount = 1) then
                    if GuiAllowed then
                        Window.Update();

            until AATAPIRequestLog2.Next() = 0;

        if GuiAllowed then begin
            Window.Close();
            Message('Exported API Request Log Entries. ...\Time: #1########## (min)\Total: #2##########', format((Time - StartTime) / 60000), TotalCounter);
        end;

        SaveDataAndDownload();

        OnAfterExportRequestLogEntries(AATAPIRequestLog, StartDate, EndDate);
    end;

    procedure DeleteRequestLogEntries(AATAPIRequestLog: Record "AAT API Request Log"; StartDate: Date; EndDate: Date; UpdateInterval: Integer)
    var
        AATAPIRequestLog2: Record "AAT API Request Log";
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        PeriodText: text;
        Window: Dialog;
        TotalCounter: Integer;
        StartTime: Time;
    begin
        OnBeforeDeleteRequestLogEntries(AATAPIRequestLog, StartDate, EndDate);

        StartTime := Time;
        StartDateTime := CreateDateTime(StartDate, 0T);
        EndDateTime := CreateDateTime(EndDate, 235959T);

        AATAPIRequestLog.SetFilter(DateTimeCreated, '%1..%2', StartDateTime, EndDateTime);
        AATAPIRequestLog.SetCurrentKey(DateTimeCreated);
        if (AATAPIRequestLog.IsEmpty) then
            Error(DeleteErrorLbl);

        PeriodText := format(StartDate).Replace('\', '-').Replace('/', '-') + '_' + format(EndDate).Replace('\', '-').Replace('/', '-');
        // InitExport(PeriodText);
        // ExportedSalesOrderCount := ChangeLogEntry.Count;
        AATAPIRequestLog2.Init();
        AATAPIRequestLog2.SetCurrentKey(DateTimeCreated);
        AATAPIRequestLog2.CopyFilters(AATAPIRequestLog);
        TotalCounter := AATAPIRequestLog2.CountApprox;

        if Dialog.Confirm(StrSubstNo(DeleteConfirmLbl, TotalCounter), false) then
            AATAPIRequestLog2.DeleteAll();

        if GuiAllowed then
            Message('Exported API Request Log Entries. ...\Time: #1########## (min)\Total: #2##########', format((Time - StartTime) / 60000), TotalCounter);


        OnAfterDeleteRequestLogEntries(AATAPIRequestLog, StartDate, EndDate);
    end;

    local procedure InitExport(PeriodText: text)
    begin
        ExportFileName := 'API Request Export - ' + PeriodText + '.csv';
        CurrentLineNumber := 1;
        TempCSVBuffer.DeleteAll();
        GenerateCSVHeaders();
    end;

    procedure GenerateCSVHeaders()
    var
    begin
        AddLineToCSV(1, 'Entry No.');
        AddLineToCSV(2, 'Reference ID');
        AddLineToCSV(3, 'API No');
        AddLineToCSV(4, 'Request URL');
        AddLineToCSV(5, 'Request Method');
        AddLineToCSV(6, 'Request Body (Base64)');
        AddLineToCSV(7, 'Request Body Size');
        AddLineToCSV(8, 'Content Type');
        AddLineToCSV(9, 'Request Headers');
        AddLineToCSV(10, 'Response HTTP Status Code');
        AddLineToCSV(11, 'Response (Base64)');
        AddLineToCSV(12, 'Response Size');
        AddLineToCSV(13, 'Date Time Created');
        AddLineToCSV(14, 'Duration');
        AddLineToCSV(15, 'User');
    end;

    local procedure MapChangeLogToCSV(AATAPIRequestLog: Record "AAT API Request Log")
    var
        AATAPIRequestLog2: Record "AAT API Request Log";
    begin
        if AATAPIRequestLog2.Get(AATAPIRequestLog."Entry No.") then begin
            CurrentLineNumber += 1;
            AddLineToCSV(1, format(AATAPIRequestLog2."Entry No."));
            AddLineToCSV(2, AATAPIRequestLog2."Reference ID");
            AddLineToCSV(3, AATAPIRequestLog2."API No.");
            AddLineToCSV(4, AATAPIRequestLog2.RequestUrl);
            AddLineToCSV(5, AATAPIRequestLog2.RequestMethod);
            AddLineToCSV(6, GetBase64FromBlob(AATAPIRequestLog2, true, false));
            AddLineToCSV(7, format(AATAPIRequestLog2.RequestBodySize));
            AddLineToCSV(8, AATAPIRequestLog2.ContentType);
            AddLineToCSV(9, AATAPIRequestLog2.RequestHeaders);
            AddLineToCSV(10, format(AATAPIRequestLog2.ResponseHttpStatusCode));
            AddLineToCSV(11, GetBase64FromBlob(AATAPIRequestLog2, false, true));
            AddLineToCSV(12, format(AATAPIRequestLog2.ResponseSize));
            AddLineToCSV(13, format(AATAPIRequestLog2.DateTimeCreated));
            AddLineToCSV(14, format(AATAPIRequestLog2.Duraction));
            AddLineToCSV(15, AATAPIRequestLog2.User);
        end;
    end;

    local procedure GetBase64FromBlob(AATAPIRequestLog: Record "AAT API Request Log"; Request: Boolean; Response: Boolean): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        Base64Text: Text;
        TempText: Text;
        CRLF: Text[2];
    begin
        AATAPIRequestLog.CalcFields(Response, RequestBody);
        case true of
            Request:
                AATAPIRequestLog.RequestBody.CreateInStream(InStream);
            Response:
                AATAPIRequestLog.Response.CreateInStream(InStream);
        end;
        CRLF[1] := 13;
        CRLF[2] := 10;

        //show only 50,000 line
        while (not InStream.EOS) and (StrLen(Base64Text) < 50000) do begin
            InStream.ReadText(TempText);
            if (StrLen(Base64Text) > 0) then
                Base64Text := Base64Text + CRLF + TempText
            else
                Base64Text := TempText;
        end;
        // InStream.ReadText(Base64Text, InStream.Length);
        // Message(Base64Text);

        exit(Base64Convert.ToBase64(Base64Text));

    end;

    local procedure AddLineToCSV(ColumnNumber: Integer; entryValue: Text)
    var
        CarriageReturn: char;
        LineFeed: char;
    begin
        //CR - ASCII
        CarriageReturn := 13;
        //LF - ASCII
        LineFeed := 10;
        entryValue := entryValue.Replace(',', ' ');
        entryValue := entryValue.Replace(CarriageReturn, ' ');
        entryValue := entryValue.Replace(LineFeed, ' ');
        TempCSVBuffer.InsertEntry(CurrentLineNumber, ColumnNumber, CopyStr(entryValue, 1, 250));
    end;

    local procedure SaveDataAndDownload()
    var
        CSVDataTempBlob: Codeunit "Temp Blob";
        CSVInStream: InStream;
    begin
        if (TempCSVBuffer.GetNumberOfLines() <= 2) then begin
            if (GuiAllowed) then
                Message(ExportNoDataLbl);
            exit;
        end;

        TempCSVBuffer.SaveDataToBlob(CSVDataTempBlob, ',');
        CSVDataTempBlob.CreateInStream(CSVInStream);
        File.DownloadFromStream(CSVInStream, 'Export Orders.', '', '*.csv', ExportFileName);

        // if (GuiAllowed) then
        //     Message(ExportedSalesOrderLbl, ExportedSalesOrderCount);

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeExportRequestLogEntries(var AATAPIRequestLog: Record "AAT API Request Log"; var StartDate: Date; var EndDate: Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterExportRequestLogEntries(var AATAPIRequestLog: Record "AAT API Request Log"; StartDate: Date; EndDate: Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteRequestLogEntries(var AATAPIRequestLog: Record "AAT API Request Log"; StartDate: Date; EndDate: Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteRequestLogEntries(var AATAPIRequestLog: Record "AAT API Request Log"; StartDate: Date; EndDate: Date)
    begin
    end;

    var
        TempCSVBuffer: Record "CSV Buffer" temporary;
        CurrentLineNumber: Integer;
        ExportFileName: Text;
        ExportedSalesOrderCount: Integer;
        ExportErrorLbl: Label 'No data found to export.';
        ExportNoDataLbl: Label 'No data to export.';
        DeleteErrorLbl: Label 'No records to delete.';
        DeleteConfirmLbl: Label 'You are about to delete %1 from AAT API Request Log, do you want to continue?';
}

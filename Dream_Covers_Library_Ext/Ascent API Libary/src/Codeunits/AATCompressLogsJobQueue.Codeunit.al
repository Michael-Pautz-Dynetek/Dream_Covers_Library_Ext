// /// <summary>
// /// Job Queue to compress AAT Logs using GZip
// /// </summary>
// codeunit 80106 "AAT Compress Logs Job Queue"
// {

//     procedure Compress()
//     var
//         APIRequestLog: Record "AAT API Request Log";
//         LogCount: Integer;
//         ProcessedCount: Integer;

//         Window: Dialog;

//     begin
//         Window.Open('#1#####\of\#2#####');

//         APIRequestLog.SetRange(Compressed, false);
//         LogCount := APIRequestLog.Count;
//         Window.Update(2, LogCount);

//         if APIRequestLog.FindSet() then
//             repeat
//                 CompressLogEntry(APIRequestLog);

//                 ProcessedCount += 1;
//                 if (ProcessedCount mod 1000 = 0) then begin
//                     Commit(); //why not?
//                     Window.Update(1, ProcessedCount);
//                 end;

//             until APIRequestLog.Next() = 0;

//         // Commit();
//         Message('Entries: %1\\Was: %2\Now: %3\Save:%4', LogCount, TotalBefore, TotalAfter, TotalBefore - TotalAfter);

//     end;

//     local procedure CompressLogEntry(var APIRequestLog: Record "AAT API Request Log")
//     var
//         TempBlob: Codeunit "Temp Blob";
//         TempInStream: InStream;
//         TempOutStream: OutStream;

//         TempInStream2: InStream;
//         TempOutStream2: OutStream;

//     begin
//         // Compress Request

//         APIRequestLog.CalcFields(RequestBody);
//         TotalBefore += APIRequestLog.RequestBody.Length;

//         Clear(TempBlob);
//         Clear(TempOutStream);
//         Clear(TempInStream);
//         APIRequestLog.RequestBody.CreateInStream(TempInStream);
//         TempBlob.CreateOutStream(TempOutStream);
//         DataCompression.GZipCompress(TempInStream, TempOutStream);
//         //-
//         Clear(APIRequestLog.RequestBody);
//         Clear(TempInStream2);
//         Clear(TempOutStream2);
//         APIRequestLog.RequestBody.CreateOutStream(TempOutStream2);
//         TempBlob.CreateInStream(TempInStream2);

//         CopyStream(TempOutStream2, TempInStream2);

//         TotalAfter += APIRequestLog.RequestBody.Length();

//         //-------------------

//         APIRequestLog.CalcFields(Response);
//         TotalBefore += APIRequestLog.Response.Length;

//         Clear(TempBlob);
//         Clear(TempOutStream);
//         Clear(TempInStream);
//         APIRequestLog.Response.CreateInStream(TempInStream);
//         TempBlob.CreateOutStream(TempOutStream);
//         DataCompression.GZipCompress(TempInStream, TempOutStream);
//         //-
//         Clear(APIRequestLog.Response);
//         APIRequestLog.Response.CreateOutStream(TempOutStream2);
//         TempBlob.CreateInStream(TempInStream2);

//         CopyStream(TempOutStream2, TempInStream2);

//         TotalAfter += APIRequestLog.Response.Length();

//         APIRequestLog.Compressed := true;
//         APIRequestLog.Modify();
//     end;



//     var
//         DataCompression: Codeunit "Data Compression";
//         TotalBefore: BigInteger;
//         TotalAfter: BigInteger;
// }
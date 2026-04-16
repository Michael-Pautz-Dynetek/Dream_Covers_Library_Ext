// codeunit 80106 "AAT Usage Example CU"
// {
//     trigger OnRun()
//     var
//         AATRestHelper: Codeunit "AAT REST Helper";
//     begin
//         YourExtensionSetup.GetRecordOnce();

//         AATRestHelper.LoadAPIConfig(YourExtensionSetup."Account Payment Term API");
//         AATRestHelper.Initialize('PATCH', AATRestHelper.GetAPIConfigBaseEndpoint() + '/FinalTarget');
//         AATRestHelper.AddBasicAuthHeader();

//         AATRestHelper.AddRequestHeader('Key', 'Value');
//         AATRestHelper.AddBody('{"testProp": "Hello There"}');
//         AATRestHelper.SetContentType('application/json');

//         if NOT AATRestHelper.Send() then begin
//             if AATRestHelper.IsTransmitIssue() then
//                 Error('Failed to send Request. Check URL and try again.');

//             Error(
//                 'API Error.\Code: %1\Message: %2\Reason: %3',
//                 AATRestHelper.GetHttpStatusCode(),
//                 AATRestHelper.GetResponseContentAsText(),
//                 AATRestHelper.GetResponseReasonPhrase()
//             );
//         end;

//         Message(
//             'Reason: %1\Result:\%2',
//             AATRestHelper.GetResponseReasonPhrase(),
//             AATRestHelper.GetResponseContentAsText()
//             );

//     end;
// }
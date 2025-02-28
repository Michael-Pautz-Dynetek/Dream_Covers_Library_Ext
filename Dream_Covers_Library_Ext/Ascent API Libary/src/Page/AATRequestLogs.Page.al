/// <summary>
/// Page AAT Request Logs (ID 80102).
/// </summary>
page 80102 "AAT Request Logs"
{
    PageType = List;
    SourceTable = "AAT API Request Log";
    Caption = 'AAT Request Logs';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "AAT Request Log Card";
    SourceTableView = sorting("Entry No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the Entry No.';
                    ApplicationArea = All;
                }
                field("Reference ID"; Rec."Reference ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference ID field.';
                    Visible = false;
                }
                field("API No."; Rec."API No.")
                {
                    ToolTip = 'The AAT API that was used for this request.';
                    ApplicationArea = All;
                }
                field(RequestMethod; Rec.RequestMethod)
                {
                    ToolTip = 'Specifies the RequestMethod';
                    ApplicationArea = All;
                }
                field(RequestUrl; Rec.RequestUrl)
                {
                    ToolTip = 'Specifies the RequestUrl';
                    ApplicationArea = All;
                }
                field(ContentType; Rec.ContentType)
                {
                    ToolTip = 'Specifies the ContentType';
                    ApplicationArea = All;
                }
                field(DateTimeCreated; Rec.DateTimeCreated)
                {
                    ToolTip = 'Specifies the DateTimeCreated';
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duraction)
                {
                    Caption = 'Duration';
                    ToolTip = 'Specifies the Duration';
                    ApplicationArea = All;
                }
                field(RequestBodySize; Rec.RequestBodySize)
                {
                    ToolTip = 'Specifies the RequestBodySize';
                    ApplicationArea = All;
                }
                field(RequestHeaders; Rec.RequestHeaders)
                {
                    ToolTip = 'Specifies the RequestHeaders';
                    ApplicationArea = All;
                }
                field(ResponseHttpStatusCode; Rec.ResponseHttpStatusCode)
                {
                    ToolTip = 'Specifies the ResponseHttpStatusCode';
                    ApplicationArea = All;
                }
                field(ResponseSize; Rec.ResponseSize)
                {
                    ToolTip = 'Specifies the ResponseSize';
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the User';
                    ApplicationArea = All;
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Request)
            {
                action(ShowRequestMessage)
                {
                    ToolTip = 'Shows the request Paylaod';
                    ApplicationArea = All;
                    Image = Replan;
                    Caption = 'View Request Paylaod';
                    ShortcutKey = 'Ctrl+Alt+S';
                    Scope = "Repeater";

                    trigger OnAction()
                    begin
                        Rec.ShowRequestMessage();
                    end;
                }
            }

            group(Response)
            {
                action(ShowResponseMessage)
                {
                    ToolTip = 'Shows the response payload';
                    ApplicationArea = All;
                    Image = Insert;
                    Caption = 'View Response Paylaod';
                    Scope = "Repeater";
                    ShortcutKey = 'Ctrl+Alt+F';

                    trigger OnAction()
                    begin
                        Rec.ShowResponseMessage();
                    end;
                }
            }
            group(Manage)
            {
                action(ExportToday)
                {
                    ToolTip = 'Export the request log entires for today.';
                    ApplicationArea = All;
                    Image = Export;
                    Caption = 'Export Request Log Entries (Today)';
                    Scope = "Repeater";
                    ShortcutKey = 'Ctrl+Alt+D';

                    trigger OnAction()
                    var
                        AATManageRequestLogEntries: Codeunit "AAT Manage Request Log Entries";
                    begin
                        AATManageRequestLogEntries.ExportRequestLogEntries(Rec, Today(), Today(), 10);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Report)
            {
                Caption = 'Payload';
                Image = DesignCodeBehind;
                actionref(ShowRequestMessage_Promoted; ShowRequestMessage)
                {

                }

                actionref(ShowRequestMessage_Rromoted; ShowResponseMessage)
                {

                }
            }
        }

    }

}

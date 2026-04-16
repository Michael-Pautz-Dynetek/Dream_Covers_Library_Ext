/// <summary>
/// Page AAT Request Log Card (ID 80101).
/// </summary>
page 80101 "AAT Request Log Card"
{
    PageType = Card;
    SourceTable = "AAT API Request Log";
    Caption = 'AAT Request Log Card';
    Editable = false;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
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
                field(Duraction; Rec.Duraction)
                {
                    ToolTip = 'Specifies the Duraction';
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the User';
                    ApplicationArea = All;
                }
            }
            group(Request)
            {
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
            }
            group(Response)
            {
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
            }
        }
    }

}

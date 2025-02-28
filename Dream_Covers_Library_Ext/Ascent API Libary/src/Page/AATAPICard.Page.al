/// <summary>
/// Page AAT API Card (ID 80103).
/// </summary>
page 80103 "AAT API Card"
{
    Caption = 'AAT API Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "AAT API";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Description field.';
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the value of the Search Description field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Stops all functionality for API untill unblocked.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Auth Type"; Rec."Auth Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Authentication type for the endpoint.';
                }

            }
            group(Develpoment)
            {
                Caption = 'Development';


                field("Dev. Access Token"; Rec."Dev. Access Token")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev. Access Token field.';
                }
                field("Dev. Secret Key"; Rec."Dev. Secret Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev. Secret Key field.';
                }
                field("Dev. Base Endpoint"; Rec."Dev. Base Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev. Base Endpoint field.';
                }
                field("Dev. Refresh Token"; Rec."Dev. Refresh Token")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev. Refresh Token field.';
                }
                field("Dev. Expiry Date"; Rec."Dev. Expiry DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev. Expiry Date field.';
                }
                field("Dev. OAuth Endpoint URL"; Rec."Dev. OAuth Endpoint URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dev. OAuth Endpoint URL';
                }
            }
            group(Production)
            {
                Caption = 'Production';


                field("Prod. Access Token"; Rec."Prod. Access Token")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Access Token field.';
                }
                field("Prod. Secret Key"; Rec."Prod. Secret Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Secret Key field.';
                }
                field("Prod. Base Endpoint"; Rec."Prod. Base Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Base Endpoint field.';
                }
                field("Prod. Refresh Token"; Rec."Prod. Refresh Token")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Refresh Token field.';
                }
                field("Prod. Expiry Date"; Rec."Prod. Expiry DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. Expiry Date field.';
                }
                field("Prod. OAuth Endpoint URL"; Rec."Prod. OAuth Endpoint URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod. OAuth Endpoint URL';
                }
            }
            group("RequestCatcher for testing")
            {
                Caption = 'RequestCatcher for testing';
                field("Send to RequestCatcher"; Rec."Send to RequestCatcher")
                {
                    ApplicationArea = All;
                    ToolTip = 'Debugging tool that overides sent URL with request catcher.';
                }
                field("RequestCatcher Subdomain"; Rec."RequestCatcher Subdomain")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RequestCatcher Subdomain field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&API")
            {
                Caption = '&API';
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(API),
                                  "No." = field("No.");
                    ToolTip = 'View or add comments for the record.';
                }
            }
        }
        area(Promoted)
        {
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Category4)
            {
                Caption = 'New Document', Comment = 'Generated from the PromotedActionCategories property index 3.';
            }
            group(Category_Category5)
            {
                Caption = 'API', Comment = 'Generated from the PromotedActionCategories property index 4.';
            }
            group(Category_Category6)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
            }
        }
    }

    var
        IsOfficeAddin: Boolean;

    local procedure ActivateFields()
    var
        OfficeManagement: Codeunit "Office Management";
    begin
        IsOfficeAddin := OfficeManagement.IsAvailable();
    end;
}

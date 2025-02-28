/// <summary>
/// Table AAT API (ID 80102).
/// </summary>
table 80102 "AAT API"
{
    Caption = 'AAT API';
    DataCaptionFields = Description, "No.";
    DrillDownPageId = "AAT API List";
    LookupPageId = "AAT API List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetAPISetup();
                    NoSeriesManagement.TestManual(AATAPISetup."API Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(5; Status; Enum "AAT Status")
        {
            Caption = 'Status';
        }
        field(6; "Dev. Access Token"; Text[1024])
        {
            Caption = 'Dev. Access Token';
        }
        field(7; "Dev. Secret Key"; Text[100])
        {
            Caption = 'Dev. Secret Key';
        }
        field(8; "Dev. Refresh Token"; Text[100])
        {
            Caption = 'Dev. Refresh Token';
        }
        field(9; "Dev. Expiry Date"; Date)
        {
            Caption = 'Dev. Expiry Date';
        }
        field(10; "Dev. Base Endpoint"; Text[500])
        {
            Caption = 'Dev. Base Endpoint';

            trigger OnValidate();
            begin
                if Rec."Dev. Base Endpoint" = '' then
                    exit;

                if (Rec."Dev. Base Endpoint".Substring(StrLen(Rec."Dev. Base Endpoint"), 1) = '/') then begin
                    Rec."Dev. Base Endpoint" := CopyStr(Rec."Dev. Base Endpoint".Substring(1, StrLen(Rec."Dev. Base Endpoint") - 1), 1, MaxStrLen(Rec."Dev. Base Endpoint"));
                    Rec.Modify();
                end;
            end;
        }
        field(11; "Prod. Access Token"; Text[1024])
        {
            Caption = 'Prod. Access Token';
        }
        field(12; "Prod. Secret Key"; Text[100])
        {
            Caption = 'Prod. Secret Key';
        }
        field(13; "Prod. Refresh Token"; Text[100])
        {
            Caption = 'Prod. Refresh Token';
        }
        field(14; "Prod. Base Endpoint"; Text[500])
        {
            Caption = 'Prod. Base Endpoint';

            trigger OnValidate();
            begin

                if Rec."Prod. Base Endpoint" = '' then
                    exit;
                if (Rec."Prod. Base Endpoint".Substring(StrLen(Rec."Prod. Base Endpoint"), 1) = '/') then begin
                    Rec."Prod. Base Endpoint" := CopyStr(Rec."Prod. Base Endpoint".Substring(1, StrLen(Rec."Prod. Base Endpoint") - 1), 1, MaxStrLen(Rec."Prod. Base Endpoint"));
                    Rec.Modify();
                end;
            end;
        }
        field(15; "Prod. Expiry Date"; Date)
        {
            Caption = 'Prod. Expiry Date';
        }
        field(16; "Send to RequestCatcher"; Boolean)
        {
            Caption = 'Send to RequestCatcher';
        }
        field(17; "RequestCatcher Subdomain"; Text[250])
        {
            Caption = 'RequestCatcher Subdomain';
        }
        field(18; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(19; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(21; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(API), "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Dev. OAuth Endpoint URL"; Text[500])
        {
            Caption = 'Dev. OAuth Endpoint URL';
        }
        field(35; "Dev. Expiry DateTime"; DateTime)
        {
            Caption = 'Dev. Expiry DateTime';
        }
        field(40; "Prod. OAuth Endpoint URL"; Text[500])
        {
            Caption = 'Prod. OAuth Endpoint URL';
        }
        field(45; "Prod. Expiry DateTime"; DateTime)
        {
            Caption = 'Prod. Expiry DateTime';
        }
        field(50; "Auth Type"; Enum "Auth Type")
        {
            Caption = 'Auth Type';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Description") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Description 2", "No.") { }
        fieldgroup(Brick; Description, "No.") { }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            TestAPINoSeries();
            NoSeriesManagement.InitSeries(AATAPISetup."API Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::API);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();

    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        AATAPISetup: Record "AAT API Setup";
        CommentLine: Record "Comment Line";
        AATAPI: Record "AAT API";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        APISetupRead: Boolean;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <param name="AATAPIOld">Record "AAT API".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(AATAPIOld: Record "AAT API"): Boolean
    begin
        AATAPI := Rec;
        TestAPINoSeries();
        if NoSeriesManagement.SelectSeries(AATAPISetup."API Nos.", AATAPIOld."No. Series", AATAPI."No. Series") then begin
            TestAPINoSeries();
            NoSeriesManagement.SetSeries(AATAPI."No.");
            Rec := AATAPI;
            exit(true);
        end;
    end;

    local procedure GetAPISetup()
    begin
        if not APISetupRead then
            AATAPISetup.Get();

        APISetupRead := true;

        OnAfterGetAPISetup(AATAPISetup);
    end;

    /// <summary>
    /// GetAPICredentials.
    /// </summary>
    /// <param name="EndpointUrl">VAR Text.</param>
    /// <param name="AccessToken">VAR Text.</param>
    /// <param name="SecretKey">VAR Text.</param>
    procedure GetAPICredentials(var EndpointUrl: Text; var AccessToken: Text; var SecretKey: Text)
    begin
        Rec.TestField(Rec.Status);

        case Rec.Status of
            Rec.Status::Production:
                begin
                    Rec.TestField("Prod. Base Endpoint");
                    Rec.TestField("Prod. Access Token");
                    Rec.TestField("Prod. Secret Key");

                    EndpointUrl := Rec."Prod. Base Endpoint";
                    AccessToken := Rec."Prod. Access Token";
                    SecretKey := Rec."Prod. Secret Key";
                end;
            Rec.Status::Development:
                begin
                    Rec.TestField("Dev. Base Endpoint");
                    Rec.TestField("Dev. Access Token");
                    Rec.TestField("Dev. Secret Key");

                    EndpointUrl := Rec."Dev. Base Endpoint";
                    AccessToken := Rec."Dev. Access Token";
                    SecretKey := Rec."Dev. Secret Key";
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetAPISetup(var AATAPISetup: Record "AAT API Setup")
    begin
    end;

    local procedure TestAPINoSeries()
    begin
        GetAPISetup();
        AATAPISetup.TestField("API Nos.");
    end;

    /// <summary>
    /// TestBlocked.
    /// </summary>
    procedure TestBlocked()
    begin
        TestField(Blocked, false);
    end;
}

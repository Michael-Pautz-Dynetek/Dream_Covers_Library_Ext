/// <summary>
/// Table AAT API Setup (ID 80101).
/// </summary>
table 80101 "AAT API Setup"
{
    Caption = 'AAT API Setup';
    DrillDownPageId = "AAT API Setup";
    LookupPageId = "AAT API Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "API Nos."; Code[20])
        {
            Caption = 'API Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    /// <summary>
    /// GetRecordOnce.
    /// </summary>
    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Rec.Get();
        RecordHasBeenRead := true;
    end;
}

table 50213 "Library General Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }

        field(2; "Book Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Book Nos.';
        }

        field(3; "Mild Week Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Mild Week Amount';
        }

        field(4; "Medium Week Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Medium Week Amount';
        }

        field(5; "High Week Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'High Week Amount';
        }

        field(6; "Extreme Week Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Extreme Week Amount';
        }

        field(7; "Base Fine"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Fine Amount';
            DecimalPlaces = 2;
        }

        field(8; "Extreme Fine"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Extreme Fine Amount';
            DecimalPlaces = 2;
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get(2);
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get(2) then begin
            Init();
            Insert(true);
        end;
    end;


}
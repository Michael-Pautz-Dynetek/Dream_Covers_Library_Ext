/// <summary>
/// Table AAT API Request Log (ID 80100).
/// </summary>
table 80100 "AAT API Request Log"
{
    Access = Public;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(50; "Reference ID"; Text[1024])
        {
            Caption = 'Reference ID';
            DataClassification = ToBeClassified;
        }

        field(21; "API No."; Code[20])
        {
            Caption = 'API No.';
            TableRelation = "AAT API"."No.";
        }

        field(2; RequestUrl; Text[250])
        {
            Caption = 'RequestUrl';
        }
        field(3; RequestMethod; Code[10])
        {
            Caption = 'RequestMethod';
        }
        field(4; RequestBody; Blob)
        {
            Caption = 'RequestBody';
        }
        field(5; RequestBodySize; BigInteger)
        {
            Caption = 'RequestBodySize';
        }
        field(6; ContentType; Text[50])
        {
            Caption = 'Content Type';
        }
        field(7; RequestHeaders; Text[1000])
        {
            Caption = 'Headers';
        }
        field(8; ResponseHttpStatusCode; Integer)
        {
            Caption = 'ResponseHttpStatusCode';
        }
        field(9; Response; Blob)
        {
            Caption = 'Response';
        }
        field(10; ResponseSize; BigInteger)
        {
            Caption = 'ResponseSize';
        }
        field(11; DateTimeCreated; DateTime)
        {
            Caption = 'Date Time Created';
        }
        field(12; Duraction; Duration)
        {
            Caption = 'Duraction';
        }
        field(20; User; Text[50])
        {
            Caption = 'User';
            DataClassification = EndUserIdentifiableInformation;
        }


    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(RefID; "Reference ID")
        {
        }
    }

    /// <summary>
    /// ShowRequestMessage.
    /// </summary>
    procedure ShowRequestMessage()
    var
        AATShowRequestMessage: Codeunit "AAT Show Request Message";
    begin
        AATShowRequestMessage.ShowRequestMessage(Rec);
    end;

    /// <summary>
    /// ShowResponseMessage.
    /// </summary>
    procedure ShowResponseMessage()
    var
        AATShowResponseMessage: Codeunit "AAT Show Response Message";
    begin
        AATShowResponseMessage.ShowResponseMessage(Rec);
    end;

}
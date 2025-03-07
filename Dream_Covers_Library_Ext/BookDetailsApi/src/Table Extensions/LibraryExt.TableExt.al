tableextension 50507 "Library Ext" extends Library
{
    fields
    {
        field(131; "Author Codes"; Text[1024])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}
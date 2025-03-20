tableextension 50527 "Authors Ext" extends Authors
{
    fields
    {
        field(200; BookAuthorRelationFilter; Text[2048])
        {
            FieldClass = FlowFilter;
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
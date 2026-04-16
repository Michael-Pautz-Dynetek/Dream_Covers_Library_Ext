tableextension 50527 "Authors Ext" extends Authors
{
    fields
    {
        field(205; BookAuthorRelationFilter; Text[2048])
        {
            FieldClass = FlowFilter;
        }
        field(201; Age; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Age';
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            begin
                if ("Death Date" = 0D) and ("Birth Date" <> 0D) then
                    Validate(Age, Today.Year() - "Birth Date".Year())
                else if ("Birth Date" <> 0D) and ("Death Date" <> 0D) then
                    Validate(Age, "Death Date".Year() - "Birth Date".Year());
            end;
        }
    }
}
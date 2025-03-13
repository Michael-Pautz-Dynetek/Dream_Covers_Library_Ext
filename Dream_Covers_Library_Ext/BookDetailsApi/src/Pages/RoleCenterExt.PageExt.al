pageextension 50522 "Role Center Ext" extends "Business Manager Role Center"
{
    layout
    {

    }

    actions
    {
        // Add changes to page actions here
        addfirst(New)
        {
            action("Import Books")
            {

            }
        }
    }

    var
        myInt: Integer;
}
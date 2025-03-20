pageextension 50522 "Role Center Ext" extends "Business Manager Role Center"
{
    layout
    {

    }

    actions
    {
        // Add changes to page actions here
        addfirst(creation)
        {
            action("Import Books")
            {
                Caption = 'Import Books';
                RunObject = Page "Search Book API";
                RunPageMode = View;
            }
        }
    }
}
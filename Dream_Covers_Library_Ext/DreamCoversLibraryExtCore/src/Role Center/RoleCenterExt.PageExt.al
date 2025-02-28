pageextension 50213 "Role Center Part Ext" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control139)
        {
            part("Library Inventory Cues"; "Library Inventory Cues")
            {

            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action("View Book List")
            {
                Caption = 'View Book List';
                RunObject = Page "Book List";
                RunPageMode = View;
            }
        }
    }
}
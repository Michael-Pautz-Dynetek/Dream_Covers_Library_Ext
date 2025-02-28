pageextension 50425 "Role Center Nav Ext" extends "Business Manager Role Center"
{
    actions
    {
        addfirst(processing)
        {
            action("View Inventory Dashboard")
            {
                Caption = 'View Inventory Dashboard';
                RunObject = Page "Inventory Dashboard";
                RunPageMode = View;
            }
        }
    }
}
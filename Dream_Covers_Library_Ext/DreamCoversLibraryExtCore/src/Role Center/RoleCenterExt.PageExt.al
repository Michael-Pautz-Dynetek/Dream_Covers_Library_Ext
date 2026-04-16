pageextension 50213 "Role Center Part Ext" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control139)
        {
            part("Library Inventory Cues"; "Library Inventory Cues")
            {
                ApplicationArea = all;
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
                ApplicationArea = all;
            }

            action("Item list - Test01")
            {
                ApplicationArea = All;
                Caption = 'Item list - Test01';
                Image = Open;
                

                // trigger OnAction()
                // begin
                //     OpenSpecifiedView('aa49406f-6f68-4565-b857-496faa0e77aa_Test0112223', Page::"Item List");
                // end;
            }
        }
    }
    var
        MostRented: Codeunit "Most Rented";
}
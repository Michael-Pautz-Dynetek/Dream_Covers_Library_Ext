pageextension 50510 "Book List Author Ext." extends "Book List"
{
    layout
    {
        // Add changes to page layout here
        modify(Author)
        {
            trigger OnDrillDown()
            var
                Authors: Record Authors;
                AuthorFilter: Text;
            begin
                AuthorFilter := Rec."Author Codes";
                Authors.SetFilter("Author No.", AuthorFilter.Replace(',', '|'));
                Page.Run(Page::"Authors List", Authors);
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(Processing)
        {
            action("View Authors")
            {
                Caption = 'View Authors';
                Image = View;
                ToolTip = 'View the Author list page.';
                ApplicationArea=all;
                trigger OnAction()
                begin
                    Page.Run(Page::"Authors List");
                end;
            }

            action("Import Books")
            {
                Caption = 'Import Books';
                Image = Import;
                ToolTip = 'Import books from Open Library API.';
                ApplicationArea=all;
                trigger OnAction()
                begin
                    Page.Run(Page::"Search Book API");
                end;
            }
        }
        addlast(Category_Category5)
        {
            actionref("View Authors_Promoted"; "View Authors")
            {
            }
        }
        addlast(Category_New)
        {
            actionref("Import Books_Promoted"; "Import Books")
            {
            }
        }
    }

}
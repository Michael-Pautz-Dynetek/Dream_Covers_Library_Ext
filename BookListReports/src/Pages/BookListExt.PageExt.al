pageextension 50301 "Book List Ext" extends "Book List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Processing)
        {
            action("Library Reporting")
            {
                Image = Report;
                Caption = 'Library Reporting';

                trigger OnAction()
                var
                    ReportList: Page "Book Reports List";
                begin
                    ReportList.Run();
                end;
            }
        }
    }
}
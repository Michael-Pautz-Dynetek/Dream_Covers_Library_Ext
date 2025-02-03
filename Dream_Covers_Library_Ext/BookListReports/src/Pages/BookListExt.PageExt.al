pageextension 50301 "Book List Ext" extends "Book List"
{
    actions
    {
        addlast(Processing)
        {
            action("Library Reporting")
            {
                Image = RelatedInformation;
                Caption = 'Open Library Reporting Page';
                ToolTip = 'Open the reporting page of the book list.';

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
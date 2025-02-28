page 50418 "Rent Return Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rent Return Log";
    SourceTableView = order(descending);
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Logs)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Book No."; Rec."Book No.")
                {
                    ToolTip = 'Specifies the value of the Book No. field.', Comment = '%';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Rent or Return"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Rent or Return field.', Comment = '%';
                }
                field("Entry Date"; Rec."Entry Date")
                {
                    ToolTip = 'Specifies the value of the Log Date field.', Comment = '%';
                }
                field("Duration"; Rec."Days Difference")
                {
                    ToolTip = 'Specifies the value of the Days Difference field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Rent Logs")
            {
                Caption = 'View Rent Logs';
                Image = View;
                trigger OnAction()
                var
                    RentReturnLogActions: Codeunit "Rent Return Log Actions";
                begin
                    RentReturnLogActions.FilterType(Rec, 'Rent');
                    CurrPage.Update(false);
                end;
            }
            action("View Return Logs")
            {
                Caption = 'View Return Logs';
                Image = View;
                trigger OnAction()
                var
                    RentReturnLogActions: Codeunit "Rent Return Log Actions";
                begin
                    RentReturnLogActions.FilterType(Rec, 'Return');
                    CurrPage.Update(false);
                end;
            }
            action("Rank Monthly Rented")
            {
                Caption = 'Rank Monthly Rented';
                Image = SortAscending;
                trigger OnAction()
                var
                    RankRecentlyRented: Codeunit "Rank Recently Rented";
                begin
                    RankRecentlyRented.Run();
                end;
            }
            action("Filter Selected Book")
            {
                Caption = 'Filter Selected Book';
                Image = Filter;
                trigger OnAction()
                var
                    RentReturnLog: Record "Rent Return Log";
                begin
                    CurrPage.SetSelectionFilter(RentReturnLog);
                    RentReturnLog.FindFirst();
                    Rec.SetRange("Book No.", RentReturnLog."Book No.");
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Views';

                actionref("View Rent Logs_Promoted"; "View Rent Logs")
                {
                }
                actionref("View Return Logs_Promoted"; "View Return Logs")
                {
                }
                actionref("Filter Selected Book_Promoted"; "Filter Selected Book")
                {
                }
            }
        }
    }
}
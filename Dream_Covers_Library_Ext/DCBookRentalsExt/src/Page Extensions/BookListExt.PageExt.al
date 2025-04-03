pageextension 50402 "Book List Ext" extends "Book List"
{
    layout
    {
        addafter("Customer Name")
        {
            field("Overdue Level"; Rec."Overdue Level")
            {
                Caption = 'Overdue Level';
                ToolTip = 'Specifies the overdue level of the book based on weeks overdue.';
                ApplicationArea = All;
            }
            field("Date Rented"; Rec."Date Rented")
            {
                Caption = 'Date Rented';
                ToolTip = 'Specifies the date the book was rented out.';
                ApplicationArea = All;
            }
            field("Weeks Overdue"; Rec."Weeks Overdue")
            {
                Caption = 'Weeks Overdue';
                ToolTip = 'Specifies the amount of weeks the book is overdue.';
                ApplicationArea = All;
            }
            field("Rented Rank"; Rec."Rented Rank")
            {
                Caption = 'Rented Rank';
                ToolTip = 'Specifies the rank of the books for the last month.';
                ApplicationArea = All;
            }
            field("Amount Rented Last Month"; Rec."Amount Rented Last Month")
            {

            }
        }
        modify("Customer Name")
        {
            trigger OnDrillDown()
            var
                CustomerRentingStatus: Codeunit "Customer Renting Status";
                CustomerCardError: Label 'The card page for %1 could not be opened.', Comment = 'Name of customer whose card page was not found.';
            begin
                if not CustomerRentingStatus.OpenCustomerCardPage(Rec) then
                    Error(CustomerCardError, Rec."Customer Name");
            end;
        }
    }

    actions
    {
        addafter("Filter Published Date")
        {
            action("Rent or Return Book")
            {
                Caption = 'Rent/Return Book';
                Image = Customer;
                ToolTip = 'Rent or return the selected book.';

                trigger OnAction()
                var
                    BookRentals: Codeunit "Book Rentals";
                begin
                    BookRentals.RentOrReturnBook(Rec);
                end;
            }
            action("Order by Rank")
            {
                Caption = 'Order by Rank';
                Image = SortAscending;
                Tooltip = 'Sort the list by the rank ascending';
                trigger OnAction()
                begin
                    Rec.SetCurrentKey("Rented Rank");
                    CurrPage.Update(false);
                end;
            }

            action("View Overdue Customers")
            {
                Caption = 'View Overdue Customers';
                ToolTip = 'Open a list page of customers with overdue books';
                Image = View;
                trigger OnAction()
                var
                    BookRentals: Codeunit "Book Rentals";
                begin
                    BookRentals.GetHighestLevel();
                    Page.Run(Page::"Overdue Customers List");
                end;
            }

            action("Rent/Return Logs")
            {
                Caption = 'View Rent/Return Logs';
                ToolTip = 'Open the Rent/Return log page.';
                Image = Log;
                trigger OnAction()
                begin
                    Page.Run(Page::"Rent Return Log List");
                end;
            }

            action("View Inventory Dashboard")
            {
                Caption = 'View Inventory Dashboard';
                ToolTip = 'Open the Library Inventory Dashboard page.';
                Image = View;
                trigger OnAction()
                begin
                    Page.Run(Page::"Inventory Dashboard");
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

        }
        addlast(Category_Category6)
        {
            actionref("Rent or Return Book_Promoted"; "Rent or Return Book")
            {
            }
        }
        addlast(Category_Category4)
        {
            actionref("Order by Rank_Promoted"; "Order by Rank")
            {
            }
        }
        addlast(Category_Category5)
        {
            actionref("View Overdue Customers_Promoted"; "View Overdue Customers")
            {
            }
            actionref("Rent/Return Logs_Promoted"; "Rent/Return Logs")
            {
            }
            actionref("View Inventory Dashboard_Promoted"; "View Inventory Dashboard")
            {
            }
        }
    }

    trigger OnOpenPage()
    var
        BookRentals: Codeunit "Book Rentals";
    begin
        //BookRentals.OpenPageUpdates();
    end;
}
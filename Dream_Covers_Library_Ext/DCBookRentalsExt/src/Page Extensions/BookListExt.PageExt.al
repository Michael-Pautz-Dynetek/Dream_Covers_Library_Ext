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
                ToolTip = 'Specifies the amount of weeks the book is overdue';
                ApplicationArea = All;
            }
        }
        modify("Customer Name")
        {
            trigger OnDrillDown()
            var
                CustomerRentingStatus: Codeunit "Customer Renting Status";
            begin
                CustomerRentingStatus.OpenCustomerCardPage(Rec);
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
        }
    }

    trigger OnOpenPage()
    var
        BookRentals: Codeunit "Book Rentals";
    begin
        BookRentals.OpenPageUpdates();
    end;

    var
        myInt: Integer;
}
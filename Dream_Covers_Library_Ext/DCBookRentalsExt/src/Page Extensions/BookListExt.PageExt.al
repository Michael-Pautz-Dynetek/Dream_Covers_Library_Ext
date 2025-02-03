pageextension 50402 "Book List Ext" extends "Book List"
{
    layout
    {
        addafter("Customer Name")
        {
            field("Overdue Level"; Rec."Overdue Level")
            {
                ApplicationArea = All;
            }
            field("Date Rented"; Rec."Date Rented")
            {
                ApplicationArea = All;
            }
            field("Weeks Overdue"; Rec."Weeks Overdue")
            {
                ApplicationArea = All;
            }
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

            action("Open Overdue Customers")
            {
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
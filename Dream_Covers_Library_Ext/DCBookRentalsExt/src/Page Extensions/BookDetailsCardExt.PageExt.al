pageextension 50406 "Book Details Card Ext" extends "Book Details Card"
{
    layout
    {
        addafter("Customer Name")
        {
            field("Overdue Level"; Rec."Overdue Level")
            {
                ApplicationArea = All;
                Caption = 'Overdue Level';
                ToolTip = 'Specifies the overdue level of the book based on weeks overdue.';
                Editable = false;
            }
            field("Date Rented"; Rec."Date Rented")
            {
                ApplicationArea = All;
                Caption = 'Date Rented';
                ToolTip = 'Specifies the date the book was rented out.';
                //Editable = false;
            }
            field("Weeks Overdue"; Rec."Weeks Overdue")
            {
                ApplicationArea = All;
                Caption = 'Weeks Overdue';
                ToolTip = 'Specifies the amount of weeks the book is overdue';
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
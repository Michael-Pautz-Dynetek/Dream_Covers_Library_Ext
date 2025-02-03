pageextension 50406 "Book Details Card Ext" extends "Book Details Card"
{
    layout
    {
        addafter("Customer Name")
        {
            field("Overdue Level"; Rec."Overdue Level")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Date Rented"; Rec."Date Rented")
            {
                ApplicationArea = All;
                //Editable = false;
            }
            field("Weeks Overdue"; Rec."Weeks Overdue")
            {
                ApplicationArea = All;
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
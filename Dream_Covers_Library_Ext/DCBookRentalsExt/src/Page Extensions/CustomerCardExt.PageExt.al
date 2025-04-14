pageextension 50410 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {

            field("Highest Overdue Level"; Rec."Highest Overdue Level")
            {
                Caption = 'Highest Overdue Level';
                ToolTip = 'Specifies the highest overdue level the customer currently has.';
                Editable = false;
                ApplicationArea = all;
            }
            field("Rent Allowed"; Rec."Rent Allowed")
            {
                Caption = 'Rent Allowed';
                ToolTip = 'Specifies if the customer is allowed to rent books.';
                //Editable = false;
                ApplicationArea = all;
            }
            field("Probation Date"; Rec."Probation Date")
            {
                Caption = 'Probation Date';
                ToolTip = 'Specifies the end date of the customers probation period.';
                //Editable = false;
                ApplicationArea = all;
            }
            field("Amount of Books"; Rec."Amount of Books")
            {
                ApplicationArea = all;
            }
        }
    }

    trigger OnOpenPage()
    var
        CustomerRentingStatus: Codeunit "Customer Renting Status";
    begin
        CustomerRentingStatus.CustomerOverdueMessage(Rec);
    end;
}
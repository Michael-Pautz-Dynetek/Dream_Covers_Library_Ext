page 50409 "Overdue Customers List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;
    CardPageId = "Customer Card";
    SourceTableView = where("Highest Overdue Level" = filter(<> "Overdue Levels"::" "));

    layout
    {
        area(Content)
        {
            repeater(Customers)
            {
                //Editable = false;
                field("No."; Rec."No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the customer no.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Customer Name';
                    ToolTip = 'Specifies the customer Name.';
                }
                field("Highest Overdue Level"; Rec."Highest Overdue Level")
                {
                    Caption = 'Highest Overdue Level';
                    ToolTip = 'Specifies the current highest overdue level of the customer.';
                }
                field("Rent Allowed"; Rec."Rent Allowed")
                {
                    Caption = 'Rent Allowed';
                    ToolTip = 'Specifies whether the customer is allowed to rent books';
                }
                field("Amount of Books"; Rec."Amount of Books")
                {
                    Caption = 'Books Rented Amount';
                    ToolTip = 'Specifies the amount of books the customer has rented.';
                }
                field("Book Limit"; Rec."Book Limit")
                {
                    Caption = 'Book Limit';
                    ToolTip = 'Specifies the limit of books the customer can rent.';
                }
                field("Probation Date"; Rec."Probation Date")
                {
                    Caption = 'Probation Date';
                    ToolTip = 'Specifies the end of the 6 month probation period.';
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                    ToolTip = 'Specifies the customer address.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                    ToolTip = 'Specifies the customer phone no.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                    ToolTip = 'Specifies the customer e-mail.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clear Completed Probation Dates")
            {
                Caption = 'Clear Completed Probation Dates';
                Image = Delete;
                trigger OnAction()
                var
                    ClearProbationDate: Codeunit "Clear Probation Date";
                begin
                    ClearProbationDate.ClearCompletedProbationDates();
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        BookRentals: Codeunit "Book Rentals";
    begin
        // BookRentals.OpenPageUpdates();
    end;

    var
        OverdueLevels: Enum "Overdue Levels";

}
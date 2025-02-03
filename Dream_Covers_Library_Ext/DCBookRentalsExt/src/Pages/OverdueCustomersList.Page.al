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

                }
                field("Highest Overdue Level"; Rec."Highest Overdue Level")
                {

                }
                field("Rent Allowed"; Rec."Rent Allowed")
                {

                }
                field("Amount of Books"; Rec."Amount of Books")
                {

                }
                field("Book Limit"; Rec."Book Limit")
                {

                }
                field("Probation Date"; Rec."Probation Date")
                {

                }
                field(Address; Rec.Address)
                {

                }
                field("Phone No."; Rec."Phone No.")
                {

                }
                field("E-Mail"; Rec."E-Mail")
                {

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
        BookRentals.OpenPageUpdates();
    end;

    var
        OverdueLevels: Enum "Overdue Levels";

}
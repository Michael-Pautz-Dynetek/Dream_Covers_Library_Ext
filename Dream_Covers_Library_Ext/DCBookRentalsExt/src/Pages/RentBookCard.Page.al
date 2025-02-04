page 50402 "Rent Book Card"
{
    PageType = Card;
    Caption = 'Rent Book';
    SourceTable = Library;

    layout
    {
        area(Content)
        {
            group(BookDetails)
            {
                Caption = 'Book Details';

                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    Editable = false;
                }

                field(Author; Rec.Author)
                {
                    Caption = 'Author';
                    Editable = false;
                }
            }
            group(ClientDetails)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the customer number.';
                }
                field("Client Name"; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                    ToolTip = 'Enter the name of the renting customer.';
                    // trigger OnAssistEdit()
                    // var
                    //     Customer: Record Customer;
                    // begin
                    //     if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                    //         Rec."Customer No." := Customer."No.";
                    //         Rec."Customer Name" := Customer.Name;
                    //     end;
                    // end;
                }
                field("Date Rented"; Rec."Date Rented")
                {
                    Caption = 'Date Rented';
                    ToolTip = 'Specifies the date the book was rented';
                }
            }
        }
    }
}
pageextension 50518 "Book Card Ext" extends "Book Details Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(FactBoxes)
        {
            part(BookCoverPart; "Book Cover Part")
            {
                ApplicationArea = All;
                SubPageLink = "Book No." = field("Book No.");
            }
        }
    }
}
pageextension 50518 "Book Card Ext" extends "Book Details Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(FactBoxes)
        {
            part(ImagePart; "Image Part")
            {
                ApplicationArea = All;
                SubPageLink = "Book No." = field("Book No.");
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
page 50519 "Image Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Library;
    Caption = 'Book Cover';
    layout
    {
        area(Content)
        {
            field(Cover; Rec.Cover)
            {
                ShowCaption = false;
            }
        }
    }
}
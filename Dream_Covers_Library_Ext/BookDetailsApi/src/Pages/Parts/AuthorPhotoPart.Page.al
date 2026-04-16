page 50521 "Author Photo Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Authors;
    Caption = 'Author Picture';
    layout
    {
        area(Content)
        {
            field(Photo; Rec.Photo)
            {
                ShowCaption = false;
            }
        }
    }
}
page 50518 "Author Books Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = Library;

    layout
    {
        area(Content)
        {
            repeater("Books by Author")
            {
                field("Book No."; Rec."Book No.")
                {
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the title of the book.';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the genre of the book.';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the author of the book.';
                }
            }
        }
    }
}
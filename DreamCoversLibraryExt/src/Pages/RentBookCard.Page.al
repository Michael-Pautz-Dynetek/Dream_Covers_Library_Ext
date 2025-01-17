page 50207 "Rent Book Card"
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
                    ToolTip = 'Specifies the title of the book.';
                    Editable = false;
                }

                field(Author; Rec.Author)
                {
                    Caption = 'Author';
                    ToolTip = 'Specifies the author of the book';
                    Editable = false;
                }
            }
            group(ClientDetails)
            {
                field(ClientNameInput; Rec."Client Name")
                {
                    Caption = 'Client Name';
                    ToolTip = 'Enter the name of the renting client.';
                }
            }
        }
    }
}
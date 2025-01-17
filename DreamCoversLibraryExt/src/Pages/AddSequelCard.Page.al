page 50209 "Add Sequel Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Library;
    layout
    {
        area(Content)
        {
            group(SeriesInfo)
            {
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the author of the book.';
                    Editable = false;
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the series of the book.';
                    Editable = false;
                }

                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the prequel of the book.';
                    Editable = false;
                }
            }

            group(SequelInfo)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the book.';
                }

                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the genre of the book.';
                }

                field(Publisher; Rec.Publisher)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the publisher of the book.';
                }

                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of the book.';
                }

                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the publication date of the book.';
                }

                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of pages of the book.';
                }

                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sequel of the book.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    var
        Pages: Integer;
        Prequel, Title, Sequel, Author, Series, Genre, Publisher : Text;
        PublicationDate: Date;
        BookPrice: Decimal;
        AddSequel: Codeunit "Add Sequel";
}
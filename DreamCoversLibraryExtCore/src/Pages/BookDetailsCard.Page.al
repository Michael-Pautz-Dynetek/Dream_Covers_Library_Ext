page 50203 "Book Details Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = Library;
    Caption = 'Book Details Card';

    layout
    {
        area(Content)
        {
            group(Details)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the book.';
                }

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the author of the book.';
                }

                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies wether the book is currently rented.';
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the series of the book.';
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

                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the prequel of the book.';
                    Editable = false;
                }

                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sequel of the book.';
                    Editable = false;
                }

                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the client.';
                }

                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the client who rented the book.';
                }

                field("Amount Rented"; Rec."Amount Rented")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of times the book has been rented.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Sequel")
            {
                Caption = 'Add Sequel';
                Image = Add;
                trigger OnAction()
                var
                    AddSequel: Codeunit "Add Sequel";
                begin
                    AddSequel.InsertSequel(Rec);
                end;
            }
        }
    }
}
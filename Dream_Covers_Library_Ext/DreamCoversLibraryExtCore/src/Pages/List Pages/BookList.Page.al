page 50201 "Book List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Library;
    Caption = 'Book List';
    CardPageId = "Book Details Card";
    //InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Library)
            {
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the title of the book.';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the author of the book.';
                }
                field(Series; Rec.Series)
                {
                    ToolTip = 'Specifies the series of the book.';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the genre of the book.';
                }
                field("Book Price"; Rec."Book Price")
                {
                    ToolTip = 'Specifies the price of the book.';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ToolTip = 'Specifies the publication date of the book.';
                }
                field(Rented; Rec.Rented)
                {
                    ToolTip = 'Specifies wether the book is currently rented.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the customer who rented the book.';
                }
                field("Amount Rented"; Rec."Amount Rented")
                {
                    ToolTip = 'Specifies the amount of times the book has been rented.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("New Book")
            {
                Caption = 'Add Book';
                Image = Add;
                ToolTip = 'Add a new book to the library.';

                trigger OnAction()
                var
                    Library: Record Library;
                begin
                    BookMgt.BookManagementActions(Library, BookMgtOptions::AddBook);
                end;
            }
            action("View 3 Most Rented Books")
            {
                Caption = 'View 3 Most Rented Books';
                Image = Interaction;
                ToolTip = 'View the top 3 most rented books.';

                trigger OnAction()
                var
                    MostRented: Codeunit "Most Rented";
                begin
                    MostRented.Run();
                end;
            }

            action("Filter Published Date")
            {
                Caption = 'Published Last 2 Years';
                Image = Filter;
                ToolTip = 'View the books published in the last 2 years.';

                trigger OnAction()
                var
                    FilterPublishedDate: Codeunit "Filter Published Date";
                begin
                    FilterPublishedDate.FilterLast2Years(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        BookMgtOptions: Enum "Book Management Options";
        BookMgt: Codeunit "Book Management";
}
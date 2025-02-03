page 50201 "Book List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Library;
    Caption = 'Book List';
    CardPageId = "Book Details Card";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Library)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                }

                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }

                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                }

                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                }

                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }

                field("Amount Rented"; Rec."Amount Rented")
                {
                    ApplicationArea = All;
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
                Caption = 'Add New Book';
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
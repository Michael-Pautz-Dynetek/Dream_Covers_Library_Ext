page 50201 "Book List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Library;
    Caption = 'Book List';
    CardPageId = 50203;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the title of the book.';
                    Editable = false;
                }

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the author of the book.';
                    Editable = false;
                }

                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies wether the book is currently rented.';
                    Editable = false;
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the series of the book.';
                    Editable = false;
                }

                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the genre of the book.';
                    Editable = false;
                }

                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of the book.';
                    Editable = false;
                }

                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the publication date of the book.';
                    Editable = false;
                }

                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the client who rented the book.';
                    Editable = false;
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
            action("Most Rented")
            {
                Caption = 'Most Rented';
                Image = Interaction;

                trigger OnAction()
                var
                    MostRented: Codeunit "Most Rented";
                begin
                    MostRented.Run();
                end;
            }

            action("Filter Published Date")
            {
                Caption = 'Filter Published Date';
                Image = Filter;

                trigger OnAction()
                var
                    FilterPublishedDate: Codeunit "Filter Published Date";
                begin
                    FilterPublishedDate.FilterLast2Years(Rec);
                    CurrPage.Update();

                end;
            }

            action("Rent Book")
            {
                Caption = 'Rent Book';
                Image = Customer;

                trigger OnAction()
                var
                    RentBook: Codeunit RentBook;
                begin
                    RentBook."Rent Book"(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        InsertInitialRecords: Codeunit "Insert Initial Records";
    begin
        //InsertInitialRecords.Run();
    end;
}
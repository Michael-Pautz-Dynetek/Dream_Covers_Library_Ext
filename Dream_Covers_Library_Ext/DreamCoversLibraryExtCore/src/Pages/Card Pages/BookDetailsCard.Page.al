page 50203 "Book Details Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Library;
    Caption = 'Book Details Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Title';
                    ToolTip = 'Specifies the title of the book.';
                }

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    Caption = 'Author';
                    ToolTip = 'Specifies the author of the book.';
                }

                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Rented';
                    ToolTip = 'Specifies wether the book is currently rented.';
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                    Caption = 'Series';
                    ToolTip = 'Specifies the series of the book.';
                }

                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    Caption = 'Genre';
                    ToolTip = 'Specifies the genre of the book.';
                }

                field(Publisher; Rec.Publisher)
                {
                    ApplicationArea = All;
                    Caption = 'Publisher';
                    ToolTip = 'Specifies the publisher of the book.';
                }

                field("Book Price"; Rec."Book Price")
                {
                    ApplicationArea = All;
                    Caption = 'Book Price';
                    ToolTip = 'Specifies the price of the book.';
                }

                field("Publication Date"; Rec."Publication Date")
                {
                    ApplicationArea = All;
                    Caption = 'Publication Date';
                    ToolTip = 'Specifies the publication date of the book.';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Identification number of the renting customer.';
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                    ToolTip = 'Specifies the customer who rented the book.';
                }

                field("Amount Rented"; Rec."Amount Rented")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Amount Rented';
                    ToolTip = 'Specifies the amount of times the book has been rented.';
                }
            }
            group(Details)
            {
                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                    Caption = 'Pages';
                    ToolTip = 'Specifies the number of pages of the book.';
                }

                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Prequel';
                    ToolTip = 'Specifies the prequel of the book.';
                }

                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sequel';
                    ToolTip = 'Specifies the sequel of the book.';
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
                ToolTip = 'Adds a new book as a sequel to the current book series.';
                trigger OnAction()
                var
                    BookMgt: Codeunit "Book Management";
                    BookMgtOptions: Enum "Book Management Options";
                begin
                    BookMgt.BookManagementActions(Rec, BookMgtOptions::AddSequel);
                end;
            }
            /*action(Edit)
            {
                Caption = 'Edit Page';
                Image = Edit;

                trigger OnAction()
                var
                    Card: Page "Book Details Card";
                begin
                    CurrPage.Editable := true;
                    CurrPage.Update();
                end;
            }*/
        }
    }
    trigger OnOpenPage()
    begin
        OnOpenBookDetails(Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnOpenBookDetails(Library: Record Library)
    begin
    end;
}
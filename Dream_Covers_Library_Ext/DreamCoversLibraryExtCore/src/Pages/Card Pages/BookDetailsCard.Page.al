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
                }

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                }

                field(Rented; Rec.Rented)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                }

                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                }

                field(Publisher; Rec.Publisher)
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

                field("Customer No."; Rec."Customer No.")
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
                    Editable = false;
                }
            }
            group(Details)
            {
                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                }

                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Sequel; Rec.Sequel)
                {
                    ApplicationArea = All;
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
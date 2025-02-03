page 50302 "Book Reports List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Library;

    layout
    {
        area(Content)
        {
            group(Header)
            {
                Caption = 'Filter options';
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Publishing Date Filter.';
                    trigger OnValidate()
                    begin
                        SetFilters.CreateFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                        CurrPage.Update();
                    end;
                }
                field(PriceFilter; PriceFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Price Filter.';
                    trigger OnValidate()
                    begin
                        SetFilters.CreateFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                        CurrPage.Update();
                    end;
                }
                field(RentalFrequency; RentalFrequency)
                {
                    ApplicationArea = All;
                    Caption = 'Minimum Rental Amount.';
                    trigger OnValidate()
                    begin
                        SetFilters.CreateFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                        CurrPage.Update();
                    end;
                }
                field(FilterField; FieldNames)
                {
                    ApplicationArea = All;
                    Caption = 'Field To Filter.';
                    trigger OnValidate()
                    begin
                        SetFilters.CreateFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                        CurrPage.Update();
                    end;

                }
                field(InputText; InputText)
                {
                    ApplicationArea = All;
                    Caption = 'Text To Search.';
                    trigger OnValidate()
                    begin
                        SetFilters.CreateFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                        CurrPage.Update();
                    end;
                }
            }
            repeater(Group)
            {
                field("Book No."; Rec."Book No.")
                {
                    ToolTip = 'Specifies the value of the Title field.', Comment = '%';
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the title of the book.';
                    Editable = false;
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the author of the book.';
                    Editable = false;
                }
                field("Amount Rented"; Rec."Amount Rented")
                {
                    ToolTip = 'Specifies the amount of times the book has been rented.';
                    Editable = false;
                }
                field("Book Price"; Rec."Book Price")
                {
                    ToolTip = 'Specifies the price of the book.';
                    Editable = false;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ToolTip = 'Specifies the ID of the client.';
                    Editable = false;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ToolTip = 'Specifies the client who rented the book.';
                    Editable = false;
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'Specifies the genre of the book.';
                    Editable = false;
                }
                field(Pages; Rec.Pages)
                {
                    ToolTip = 'Specifies the number of pages of the book.';
                    Editable = false;
                }
                field(Prequel; Rec.Prequel)
                {
                    ToolTip = 'Specifies the prequel of the book.';
                    Editable = false;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    ToolTip = 'Specifies the publication date of the book.';
                    Editable = false;
                }
                field(Publisher; Rec.Publisher)
                {
                    ToolTip = 'Specifies the publisher of the book.';
                    Editable = false;
                }
                field(Rented; Rec.Rented)
                {
                    ToolTip = 'Specifies wether the book is currently rented.';
                    Editable = false;
                }
                field(Sequel; Rec.Sequel)
                {
                    ToolTip = 'Specifies the sequel of the book.';
                    Editable = false;
                }
                field(Series; Rec.Series)
                {
                    ToolTip = 'Specifies the series of the book.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clear Filters")
            {
                Caption = 'Clear Filters';
                ApplicationArea = All;
                Image = ClearFilter;

                trigger OnAction()
                begin
                    ClearFilters.ClearAllFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        FieldNames: Enum "Field Names";
        SetFilters: Codeunit "Set Filters";
        ClearFilters: Codeunit "Clear Filters";
        DateFilter, InputText, PriceFilter : Text;
        RentalFrequency: Integer;
}
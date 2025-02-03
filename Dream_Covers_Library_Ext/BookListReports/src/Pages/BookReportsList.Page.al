page 50302 "Book Reports List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Library;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Header)
            {
                Caption = 'General Filters';
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Publishing Date';
                    ToolTip = 'Enter filter logic for the Publication Date.';

                    trigger OnValidate()
                    begin
                        SetFilters.SetDateFilter(DateFilter, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Price Filter"; PriceFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Book Price';
                    ToolTip = 'Enter filter logic for the Book Price.';

                    trigger OnValidate()
                    begin
                        SetFilters.SetPriceFilter(PriceFilter, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Rental Frequency"; RentalFrequency)
                {
                    ApplicationArea = All;
                    Caption = 'Minimum Amount Rented';
                    ToolTip = 'Enter the minimum limit of the Amount Rented.';
                    trigger OnValidate()
                    begin
                        SetFilters.SetRentalFrequencyFilter(RentalFrequency, Rec);
                        CurrPage.Update();
                    end;
                }
                field("Filter Field"; FieldNames)
                {
                    ApplicationArea = All;
                    Caption = 'Search by';
                    ToolTip = 'Select the field you want to filter by text.';
                }
                field("Input Text"; InputText)
                {
                    ApplicationArea = All;
                    Caption = 'Search';
                    ToolTip = 'Enter a part of a text you want to search.';
                    trigger OnValidate()
                    begin
                        SetFilters.SetTextFilter(InputText, FieldNames, Rec);
                        CurrPage.Update();
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;
                field(Title; Rec.Title)
                {
                    Editable = false;
                }
                field(Author; Rec.Author)
                {
                    Editable = false;
                }
                field("Amount Rented"; Rec."Amount Rented")
                {
                    Editable = false;
                }
                field("Book Price"; Rec."Book Price")
                {
                    Editable = false;
                }
                field("Client ID"; Rec."Customer No.")
                {
                    Editable = false;
                }
                field("Client Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field(Genre; Rec.Genre)
                {
                    Editable = false;
                }
                field(Pages; Rec.Pages)
                {
                    Editable = false;
                }
                field(Prequel; Rec.Prequel)
                {
                    Editable = false;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Editable = false;
                }
                field(Publisher; Rec.Publisher)
                {
                    Editable = false;
                }
                field(Rented; Rec.Rented)
                {
                    Editable = false;
                }
                field(Sequel; Rec.Sequel)
                {
                    Editable = false;
                }
                field(Series; Rec.Series)
                {
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
                ToolTip = 'Clear all the filters and input fields on this page.';

                trigger OnAction()
                begin
                    ClearFilters.ClearAllFilters(Rec, DateFilter, PriceFilter, RentalFrequency, InputText, FieldNames);
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        SetFilters: Codeunit "Set Filters";
        ClearFilters: Codeunit "Clear Filters";
        FieldNames: Enum "Field Names";
        DateFilter, InputText, PriceFilter, RentalFrequency : Text;
}
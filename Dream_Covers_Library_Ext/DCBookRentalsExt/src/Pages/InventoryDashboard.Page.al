page 50423 "Inventory Dashboard"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Inventory Details";
    Caption = 'Library Inventory Dashboard';

    layout
    {
        area(Content)
        {
            group(FilterFields)
            {
                Caption = 'Filter Fields';
                field(AuthorFilter; AuthorFilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filter to set on the Author.';
                    Caption = 'Author';
                    trigger OnValidate()
                    begin
                        if AuthorFilter <> '' then
                            Rec.SetFilter("Author Filter", '@*' + AuthorFilter + '*')
                        else
                            Rec.SetFilter("Author Filter", '');
                        CurrPage.Update();
                    end;
                }
                field(GenreFilter; GenreFilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filter to set on the Genre.';
                    Caption = 'Genre';
                    trigger OnValidate()
                    begin
                        if GenreFilter <> "Book Genres"::" " then
                            Rec.SetRange("Genre Filter", GenreFilter)
                        else
                            Rec.SetFilter("Genre Filter", '');
                        CurrPage.Update()
                    end;
                }
                field(PublishingDateFilter; PublishingDateFilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filter to set on the Publishing Date.';
                    Caption = 'Publication Date';
                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Publishing Date Filter", PublishingDateFilter);
                        PublishingDateFilter := Rec.GetFilter("Publishing Date Filter");
                        CurrPage.Update();
                    end;
                }
                field(DateAddedFilter; DateAddedFilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filter to set on the Added Date.';
                    Caption = 'Date Added';
                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Date Added Filter", DateAddedFilter);
                        DateAddedFilter := Rec.GetFilter("Date Added Filter");
                        CurrPage.Update();
                    end;
                }
            }
            group(InventoryTotals)
            {
                Caption = 'Inventory Totals';
                field("Total Rented"; Rec."Total Rented")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of books rented.';
                    DrillDownPageId = "Book List";
                }
                field("Total Available"; Rec."Total Available")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of books available.';
                    DrillDownPageId = "Book List";
                }
            }
            group(OverdueLevelTotals)
            {
                Caption = 'Overdue Level Totals';
                field("Total Mild Overdue Levels"; Rec."Total Mild Overdue Levels")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of books with Mild overdue levels.';
                    DrillDownPageId = "Book List";
                }
                field("Total Medium Overdue Levels"; Rec."Total Medium Overdue Levels")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of books with Medium overdue levels.';
                    DrillDownPageId = "Book List";
                }
                field("Total High Overdue Levels"; Rec."Total High Overdue Levels")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of books with High overdue levels.';
                    DrillDownPageId = "Book List";
                }
                field("Total Extreme Overdue Levels"; Rec."Total Extreme Overdue Levels")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of books with Extreme overdue levels.';
                    DrillDownPageId = "Book List";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    var
        GenreFilter: Enum "Book Genres";
        PublishingDateFilter, DateAddedFilter, AuthorFilter : Text[250];
}
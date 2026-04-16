page 50502 "Search Book API"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Library;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group(Search)
            {
                Caption = 'Search';
                field(SearchText; SearchText)
                {
                    Caption = 'Book Title';
                    ToolTip = 'Book title to search from Open Library API.';
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        OpenLibraryAPI: Codeunit "Open Library API";
                    begin
                        if SearchText <> '' then begin
                            Rec.DeleteAll();
                            OpenLibraryAPI.SearchBookRequest(SearchText, Rec);
                            // if not OpenLibraryAPI.SearchBookRequest(SearchText, Rec) then
                            //     Error(GetLastErrorText());
                            if not Rec.FindFirst() then begin
                                Message('No books were found with this title.');
                                SearchText := '';
                            end;
                        end else
                            Rec.DeleteAll();
                    end;

                }
            }

            repeater(Books)
            {
                Editable = false;
                field(Title; Rec.Title)
                {

                }
                field("Open Library ID"; Rec."Open Library ID")
                {

                }
                // field(Description; Rec.Description)
                // {

                // }
                field("Author Codes"; Rec."Author Codes")
                {

                }
                field(Author; Rec.Author)
                {

                }
                field("Cover No."; Rec."Cover No.")
                {
                    //FieldPropertyName = FieldPropertyValue;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Save Books")
            {
                Caption = 'Save Book(s)';
                Image = Save;
                ApplicationArea = all;

                trigger OnAction()
                var
                    SaveBooks: Codeunit "Save Books";
                    SaveSuccessfulMessage: Label 'The following book(s) have been added to the library:\';
                    SavedTitles: Text;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            SaveBooks.InsertSelectedBooks(Rec, SavedTitles);
                        until Rec.Next() = 0;
                    Rec.Reset();
                    Message(SaveSuccessfulMessage + SavedTitles);
                end;
            }
            action("View Book List")
            {
                Caption = 'View Book List';
                Image = View;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Page.Run(Page::"Book List");
                end;
            }
            action("View Authors List")
            {
                Caption = 'View Authors List';
                Image = View;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Page.Run(Page::"Authors List");
                end;
            }
        }
    }

    var
        SearchText: Text;
}
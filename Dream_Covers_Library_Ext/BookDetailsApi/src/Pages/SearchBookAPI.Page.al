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
            group(Header)
            {
                field(SearchText; SearchText)
                {
                    trigger OnValidate()
                    var
                        OpenLibraryAPI: Codeunit "Open Library API";
                    begin
                        if SearchText <> '' then
                            OpenLibraryAPI.SearchBookRequest(SearchText, Rec)
                        else
                            Rec.DeleteAll();
                    end;

                }
            }

            repeater(Books)
            {
                field(Title; Rec.Title)
                {

                }
                field("Publication Date"; Rec."Publication Date")
                {

                }
                field("Open Library ID"; Rec."Open Library ID")
                {

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
                Caption = 'Save Books';
                Image = Save;
                trigger OnAction()
                var
                    SaveBooks: Codeunit "Save Books";
                    TempLibrary: Record Library;
                    SaveSuccessfulMessage: Label 'The selected book/s have been added to the library.';
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            SaveBooks.InsertSelectedBooks(Rec);
                        until Rec.Next() = 0;
                    Rec.Reset();
                    Message(SaveSuccessfulMessage);
                end;
            }
        }
    }

    var
        SearchText: Text;
}
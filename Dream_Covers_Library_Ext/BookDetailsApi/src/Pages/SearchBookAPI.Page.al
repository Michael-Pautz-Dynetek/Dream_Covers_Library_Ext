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
                        
                    end;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        SearchText: Text;
}
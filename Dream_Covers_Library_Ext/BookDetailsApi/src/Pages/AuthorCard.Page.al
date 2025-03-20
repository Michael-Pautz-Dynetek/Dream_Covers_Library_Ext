page 50524 "Author Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Authors;

    layout
    {
        area(Content)
        {
            group("Personal Details")
            {

                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Personal Name"; Rec."Personal Name")
                {
                    ToolTip = 'Specifies the value of the Personal Name field.', Comment = '%';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
                field(Bio; Rec.Bio)
                {
                    ToolTip = 'Specifies the value of the Bio field.', Comment = '%';
                }
            }
            group("Work Details")
            {

                field("Top Work"; Rec."Top Work")
                {
                    ToolTip = 'Specifies the value of the Top Work field.', Comment = '%';
                }
                field("Work Count"; Rec."Work Count")
                {
                    ToolTip = 'Specifies the value of the Work Count field.', Comment = '%';
                }

            }
            part(AuthorBooksPart; "Author Books Part")
            {
                //SubPageLink="Book No."=filter(SetBookListFilter(Rec."Author No."));SetBookListFilter(Rec."Author No."))
                SubPageLink = "Book No." = field(BookAuthorRelationFilter);

            }
        }
        area(FactBoxes)
        {
            part(AuthorPhotoPart; "Author Photo Part")
            {
                ApplicationArea = All;
                SubPageLink = "Author No." = field("Author No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Library: Record Library;
    begin
        SetBookListFilter(Rec."Author No.");
        //CurrPage.AuthorBooksPart.Page.SetTableView(Library);
        // CurrPage.AuthorBooksPart.Page.SetSelectionFilter();
    end;

    local procedure SetBookListFilter(AuthorNo: Code[20]): Text
    var
        BooksAuthors: Record BooksAuthors;
        ResultFilter: Text;
        Test: Code[20];
        IsFirst: Boolean;
    begin
        ResultFilter := '';
        IsFirst := true;
        BooksAuthors.SetRange("Author No.", AuthorNo);
        if BooksAuthors.FindFirst() then
            repeat
                if IsFirst <> true then
                    ResultFilter += '|' + BooksAuthors."Book No."
                else begin
                    ResultFilter += BooksAuthors."Book No.";
                    IsFirst := false;
                end;
            until BooksAuthors.Next() = 0;
        // exit(ResultFilter);
        if ResultFilter <> Rec.BookAuthorRelationFilter then begin
            Rec.SetFilter(BookAuthorRelationFilter, ResultFilter);
            Rec.Modify();
        end;

        // Library.SetFilter("Book No.", ResultFilter);
        // Test := 'B-0140';
        // ResultFilter := 'where("Book No."=filter(' + Test + '))';
        // Library.SetView(ResultFilter);
    end;

    var


}
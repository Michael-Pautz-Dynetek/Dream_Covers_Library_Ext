pageextension 50518 "Book Card Ext" extends "Book Details Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(Content)
        {
            part(BookAuthorsPart; "Book Authors Part")
            {
                ApplicationArea = all;
                SubPageLink = "Author No." = field("Author Filter");
            }
        }
        addlast(FactBoxes)
        {
            part(BookCoverPart; "Book Cover Part")
            {
                ApplicationArea = All;
                SubPageLink = "Book No." = field("Book No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.SetFilter("Author Filter", Rec."Author Codes".Replace(',', '|'));
        Rec.Modify();
    end;

    // local procedure SetAuthorListFilter(AuthorNo: Code[20]): Text
    // var
    //     BooksAuthors: Record BooksAuthors;
    //     ResultFilter: Text;
    //     Test: Code[20];
    //     IsFirst: Boolean;
    // begin
    //     ResultFilter := '';
    //     IsFirst := true;
    //     BooksAuthors.SetRange("Author No.", AuthorNo);
    //     if BooksAuthors.FindFirst() then
    //         repeat
    //             if IsFirst <> true then
    //                 ResultFilter += '|' + BooksAuthors."Book No."
    //             else begin
    //                 ResultFilter += BooksAuthors."Book No.";
    //                 IsFirst := false;
    //             end;
    //         until BooksAuthors.Next() = 0;
    //     // exit(ResultFilter);
    //     if ResultFilter <> Rec.BookAuthorRelationFilter then begin
    //         Rec.SetFilter(BookAuthorRelationFilter, ResultFilter);
    //         Rec.Modify();
    //     end;
    //end;
}
pageextension 50518 "Book Card Ext" extends "Book Details Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(Details)
        {
            field(DescriptionContent; DescriptionContent)
            {
                ApplicationArea = All;
                Caption = 'Description';
                MultiLine = true;
                Editable = false;
            }
            field(Subjects; Rec.Subjects)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subjects field.', Comment = '%';
                MultiLine = true;
            }
            field("Subject Places"; Rec."Subject Places")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subject Places field.', Comment = '%';
                MultiLine = true;
            }
            field("Subject People"; Rec."Subject People")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subject People field.', Comment = '%';
                MultiLine = true;
            }

        }
        addlast(Content)
        {
            group("Author Details")
            {
                part(BookAuthorsPart; "Book Authors Part")
                {
                    ApplicationArea = all;
                    SubPageLink = "Author No." = field("Author Filter");
                }
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

    actions
    {
        addlast(Processing)
        {
            action("Upload Cover")
            {
                Caption = 'Upload Book Cover';
                Image = Download;
                trigger OnAction()
                var
                    Instream: InStream;
                    FilePath: Text;
                begin
                    if not UploadIntoStream('Upload Image', '', '', FilePath, Instream) then
                        exit;
                    Rec.Cover.ImportStream(Instream, '');
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        InStream: InStream;
    begin
        Rec.CalcFields(Description);
        if Rec.Description.HasValue then begin
            Rec.Description.CreateInStream(InStream);
            InStream.ReadText(DescriptionContent);
        end;
        Rec.SetFilter("Author Filter", Rec."Author Codes".Replace(',', '|'));
        Rec.Modify();
        // SetAuthorListFilter(Rec."Book No.");
    end;

    var
        DescriptionContent: Text;

    local procedure SetAuthorListFilter(BookNo: Code[20]): Text
    var
        BooksAuthors: Record BooksAuthors;
        ResultFilter: Text;
        Test: Code[20];
        IsFirst: Boolean;
    begin
        ResultFilter := '';
        IsFirst := true;
        BooksAuthors.SetRange("Book No.", BookNo);
        if BooksAuthors.FindFirst() then
            repeat
                if IsFirst <> true then
                    ResultFilter += '|' + BooksAuthors."Author No."
                else begin
                    ResultFilter += BooksAuthors."Author No.";
                    IsFirst := false;
                end;
            until BooksAuthors.Next() = 0;
        // exit(ResultFilter);
        if ResultFilter <> Rec."Author Filter" then begin
            Rec.SetFilter("Author Filter", ResultFilter);
            Rec.Modify();
        end;
    end;
}
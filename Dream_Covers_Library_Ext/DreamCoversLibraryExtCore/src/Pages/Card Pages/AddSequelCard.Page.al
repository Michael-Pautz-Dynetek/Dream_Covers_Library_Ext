page 50209 "Add Sequel Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Library;
    layout
    {
        area(Content)
        {
            group(SeriesInfo)
            {
                Caption = 'Series Info';

                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Series; Rec.Series)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Genre; Rec.Genre)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Prequel; Rec.Prequel)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(SequelInfo)
            {
                Caption = 'Sequel Info';

                field(Title; Rec.Title)
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

                field(Pages; Rec.Pages)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
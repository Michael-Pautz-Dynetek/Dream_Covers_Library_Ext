page 50212 "Library Inventory Cues"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Library Cue";
    Caption = 'Library Inventory';

    layout
    {
        area(Content)
        {
            cuegroup("Library Details")
            {
                field("Book Added Past Month"; Rec."Books Added Past Month")
                {
                    Caption = 'Books Added the Past Month';
                    ToolTip = 'Specifies the number of books added in the past month.', Comment = '%';
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
        Rec.CalcFields("Books Added Past Month");
    end;
}
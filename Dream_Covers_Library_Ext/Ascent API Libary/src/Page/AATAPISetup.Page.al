/// <summary>
/// Page AAT API Setup (ID 80105).
/// </summary>
page 80105 "AAT API Setup"
{
    ApplicationArea = All;
    Caption = 'AAT API Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "AAT API Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Number Series")
            {
                Caption = 'Number Series';

                field(APINos; Rec."API Nos.")
                {
                    ToolTip = 'Number series used to assign ID to new API added to AAT API List';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

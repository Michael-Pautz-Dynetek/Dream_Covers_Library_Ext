page 50214 "General Page Setup"
{

    PageType = Card;
    SourceTable = "Library General Setup";
    Caption = 'General Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Mild Week Amount"; Rec."Mild Week Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mild Week Amount field.', Comment = '%';
                }
                field("Medium Week Amount"; Rec."Medium Week Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medium Week Amount field.', Comment = '%';
                }
                field("High Week Amount"; Rec."High Week Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the High Week Amount field.', Comment = '%';
                }
                field("Extreme Week Amount"; Rec."Extreme Week Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extreme Week Amount field.', Comment = '%';
                }
                field("Base Fine"; Rec."Base Fine")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Base Fine Amount field.', Comment = '%';
                }
                field("Extreme Fine"; Rec."Extreme Fine")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extreme Fine Amount field.', Comment = '%';
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Primary Key field.', Comment = '%';
                }
                field("Book Nos."; Rec."Book Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Book Nos. field.', Comment = '%';
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}

page 50508 "Authors List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Authors;
    ModifyAllowed = false;
    CardPageId = "Author Card";

    layout
    {
        area(Content)
        {
            repeater(Authors)
            {
                Editable = false;
                field("Author No."; Rec."Author No.")
                {
                    ToolTip = 'Specifies the value of the Author No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Personal Name"; Rec."Personal Name")
                {
                    ToolTip = 'Specifies the value of the Personal Name field.', Comment = '%';
                }
                field(Bio; Rec.Bio)
                {
                    ToolTip = 'Specifies the value of the Bio field.', Comment = '%';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
                field("Work Count"; Rec."Work Count")
                {
                    ToolTip = 'Specifies the value of the Work Count field.', Comment = '%';
                }
                field("Top Work"; Rec."Top Work")
                {
                    ToolTip = 'Specifies the value of the Top Work field.', Comment = '%';
                }
                field("Books Rented Amount"; Rec."Books Rented Amount")
                {
                    ToolTip = 'Specifies the amount of books by the author that has been rented.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Popular Authors")
            {
                Caption='Popular Authors';
                Image=View;
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }

}
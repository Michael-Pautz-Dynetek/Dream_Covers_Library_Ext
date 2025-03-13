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
                // part(AuthorBooks; "Author Books Part")
                // {
                //     SubPageLink=
                // }
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

}
page 50523 "Book Authors Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = Authors;

    layout
    {
        area(Content)
        {
            repeater("Book Authors")
            {

                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth Date field.', Comment = '%';
                }
                field("Top Work"; Rec."Top Work")
                {
                    ToolTip = 'Specifies the value of the Top Work field.', Comment = '%';
                }
            }
        }
    }
}
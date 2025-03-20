page 50517 "Link List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BooksAuthors;

    layout
    {
        area(Content)
        {
            repeater(Links)
            {
                field("Author Name"; Rec."Author Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.', Comment = '%';
                }
                field("Valid Link"; Rec."Valid Link")
                {
                    ToolTip = 'Specifies the value of the Valid Link field.', Comment = '%';
                }

                field("Author No."; Rec."Author No.")
                {
                    ToolTip = 'Specifies the value of the Author No. field.', Comment = '%';
                }
                field("Book No."; Rec."Book No.")
                {
                    ToolTip = 'Specifies the value of the Book No. field.', Comment = '%';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
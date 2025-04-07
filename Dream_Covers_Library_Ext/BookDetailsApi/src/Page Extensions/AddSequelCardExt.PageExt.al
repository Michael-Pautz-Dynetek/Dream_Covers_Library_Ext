pageextension 50530 "Add Sequel Card Ext" extends "Add Sequel Card"
{
    layout
    {
        // Add changes to page layout here
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
        // Add changes to page actions here
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
                    //Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        myInt: Integer;
}
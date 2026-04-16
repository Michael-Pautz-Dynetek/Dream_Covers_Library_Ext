pageextension 50530 "Add Sequel Card Ext" extends "Add Sequel Card"
{
    layout
    {
        // Add changes to page layout here
        // addlast(FactBoxes)
        // {
        //     part(BookCoverPart; "Book Cover Part")
        //     {
        //         ApplicationArea = All;
        //         SubPageLink = "Book No." = field("Book No.");
        //     }
        // }
        addlast(SequelInfo)
        {
            field("Image Preview"; Rec."Image Preview")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    Instream: InStream;
                begin
                    Rec."Image Preview".CreateInStream(Instream);
                    Rec.Cover.ImportStream(Instream, '');
                end;
            }
        }
    }

    // actions
    // {
    //     // Add changes to page actions here
    //     addlast(Processing)
    //     {
    //         action("Upload Cover")
    //         {
    //             Caption = 'Upload Book Cover';
    //             Image = Download;
    //             ApplicationArea = all;
    //             trigger OnAction()
    //             var
    //                 Instream: InStream;
    //                 FilePath: Text;
    //             begin
    //                 if not UploadIntoStream('Upload Image', '', '', FilePath, Instream) then
    //                     exit;
    //                 Rec.Cover.ImportStream(Instream, '');
    //                 // Rec.Modify(true);
    //                 CurrPage.Update(true);
    //             end;
    //         }
    //     }
    // }

    var
        ImagePreviewContent: Text;
}
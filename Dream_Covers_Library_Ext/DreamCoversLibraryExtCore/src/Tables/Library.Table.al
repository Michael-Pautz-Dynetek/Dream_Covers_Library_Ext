table 50200 Library
{
    DataClassification = CustomerContent;
    Caption = 'Library';

    fields
    {
        field(10; "Book No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Book No.';
            ToolTip = 'Identification number of the book.';
        }

        field(20; Title; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
            ToolTip = 'Specifies the title of the book.';
        }

        field(30; Author; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Author';
            ToolTip = 'Specifies the author of the book.';
        }

        field(40; Rented; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rented';
            ToolTip = 'Specifies wether the book is currently rented.';
        }

        field(50; Series; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Series';
            ToolTip = 'Specifies the series of the book.';
        }

        field(60; Genre; Enum "Book Genres")
        {
            DataClassification = CustomerContent;
            Caption = 'Genre';
            ToolTip = 'Specifies the genre of the book.';
        }

        field(70; Publisher; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Publisher';
            ToolTip = 'Specifies the publisher of the book.';
        }

        field(80; "Book Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Book Price';
            ToolTip = 'Specifies the price of the book.';
            DecimalPlaces = 2;
        }

        field(90; "Publication Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Publication Date';
            ToolTip = 'Specifies the publication date of the book.';
        }

        field(100; Pages; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pages';
            ToolTip = 'Specifies the number of pages of the book.';
        }

        field(110; Prequel; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Prequel';
            ToolTip = 'Specifies the prequel of the book.';
        }

        field(120; Sequel; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sequel';
            ToolTip = 'Specifies the sequel of the book.';
        }

        field(130; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            ToolTip = 'Identification number of the renting customer.';
        }

        field(140; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            ToolTip = 'Specifies the customer who rented the book.';
        }

        field(150; "Amount Rented"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Rented';
            ToolTip = 'Specifies the amount of times the book has been rented.';
        }

        field(160; "Prequel ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Prequel ID';
            ToolTip = 'ID of the prequel book.';
        }
    }

    keys
    {
        key(PK; "Book No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Book No." = '' then begin
            GeneralSetup.Get(2);
            GeneralSetup.TestField("Book Nos.");
            Validate("Book No.", NoSeriesMgt.GetNextNo(GeneralSetup."Book Nos."));
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        Library: Record Library;
    begin
        if Rec."Prequel ID" = 0 then
            exit
        else
            UpdateSequel(Library);
    end;

    trigger OnRename()
    begin

    end;

    local procedure UpdateSequel(Library: Record Library)
    begin
        Library.Get(Rec."Prequel ID");
        Library.Validate(Sequel, '');
        Library.Modify(true);
    end;

    var
        GeneralSetup: Record "Library General Setup";
        NoSeriesMgt: Codeunit "No. Series";

}
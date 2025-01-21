table 50200 Library
{
    DataClassification = CustomerContent;
    TableType = Normal;
    Caption = 'Library';


    fields
    {
        field(1; "Book No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
            AutoIncrement = true;
        }

        field(2; Title; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
            //InitValue = 'None';
        }

        field(3; Author; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Author';
            //InitValue = 'None';
        }

        field(4; Rented; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rented';
            //InitValue = false;
        }

        field(5; Series; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Series';
            //InitValue = 'None';
        }

        field(6; Genre; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Genre';
            //InitValue = 'None';
        }

        field(7; Publisher; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Publisher';
            //InitValue = 'None';
        }

        field(8; "Book Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Book Price';
            //InitValue = 0.00;
        }

        field(9; "Publication Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Publication Date';
            //InitValue = ;
        }

        field(10; Pages; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pages';
            //InitValue = 0;
        }

        field(11; Prequel; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Prequel';
            //InitValue = 'None';
        }

        field(12; Sequel; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sequel';
            //InitValue = 'None';
        }

        field(13; "Client ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(14; "Client Name"; Text[100])
        {
            Caption = 'Client Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Client ID")));
            //InitValue = 'None';
        }

        field(15; "Amount Rented"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Rented';

            //InitValue = 0;
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

    end;

    trigger OnModify()
    begin
        
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
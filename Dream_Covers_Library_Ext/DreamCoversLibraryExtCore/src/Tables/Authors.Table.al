table 50214 Authors
{
    DataClassification = CustomerContent;
    Caption='Authors';
    
    fields
    {
        field(1;"Author No."; Code[20])
        {
            DataClassification = CustomerContent;
            
        }
        field(10;"Birth Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Death Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30;Bio;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40;"Personal Name";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50;Name;Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60;"Work Count";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70;"Top Work";Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Author No.")
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
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
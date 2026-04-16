table 50210 "Library Cue"
{
    DataClassification = ToBeClassified;
    

    fields
    {
        field(1; PrimaryKey; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Books Added Past Month"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Library where("Date Added" = filter('t-1M..t')));
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}
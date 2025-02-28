table 50421 "Inventory Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(10; "Author Filter"; Text[250])
        {
            Caption = 'Author';
            FieldClass = FlowFilter;
        }
        field(20; "Genre Filter"; Enum "Book Genres")
        {
            Caption = 'Genre';
            FieldClass = FlowFilter;
        }
        field(30; "Publishing Date Filter"; Date)
        {
            Caption = 'Publishing Date';
            FieldClass = FlowFilter;
        }
        field(40; "Date Added Filter"; Date)
        {
            Caption = 'Date Added';
            FieldClass = FlowFilter;
        }
        field(50; "Total Rented"; Integer)
        {
            Caption = 'Rented';
            FieldClass = FlowField;
            CalcFormula = Count(Library where(Rented = const(true),
                                            Author = field("Author Filter"),
                                            Genre = field("Genre Filter"),
                                            "Publication Date" = field("Publishing Date Filter"),
                                            "Date Added" = field("Date Added Filter")));
        }
        field(60; "Total Mild Overdue Levels"; Integer)
        {
            Caption = 'Mild';
            FieldClass = FlowField;
            CalcFormula = Count(Library where("Overdue Level" = const("Overdue Levels"::Mild),
                                            Author = field("Author Filter"),
                                            Genre = field("Genre Filter"),
                                            "Publication Date" = field("Publishing Date Filter"),
                                            "Date Added" = field("Date Added Filter")));
        }
        field(70; "Total Medium Overdue Levels"; Integer)
        {
            Caption = 'Medium';
            FieldClass = FlowField;
            CalcFormula = Count(Library where("Overdue Level" = const("Overdue Levels"::Medium),
                                            Author = field("Author Filter"),
                                            Genre = field("Genre Filter"),
                                            "Publication Date" = field("Publishing Date Filter"),
                                            "Date Added" = field("Date Added Filter")));
        }
        field(80; "Total High Overdue Levels"; Integer)
        {
            Caption = 'High';
            FieldClass = FlowField;
            CalcFormula = count(Library where("Overdue Level" = const("Overdue Levels"::High),
                                            Author = field("Author Filter"),
                                            Genre = field("Genre Filter"),
                                            "Publication Date" = field("Publishing Date Filter"),
                                            "Date Added" = field("Date Added Filter")));
        }
        field(90; "Total Extreme Overdue Levels"; Integer)
        {
            Caption = 'Extreme';
            FieldClass = FlowField;
            CalcFormula = count(Library where("Overdue Level" = const("Overdue Levels"::Extreme),
                                            Author = field("Author Filter"),
                                            Genre = field("Genre Filter"),
                                            "Publication Date" = field("Publishing Date Filter"),
                                            "Date Added" = field("Date Added Filter")));
        }
        field(100; "Total Available"; Integer)
        {
            Caption = 'Available Books';
            FieldClass = FlowField;
            CalcFormula = count(Library where(Rented = const(false),
                                            Author = field("Author Filter"),
                                            Genre = field("Genre Filter"),
                                            "Publication Date" = field("Publishing Date Filter"),
                                            "Date Added" = field("Date Added Filter")));
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
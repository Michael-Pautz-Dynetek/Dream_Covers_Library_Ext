codeunit 50528 "Calculate Age"
{
    trigger OnRun()
    begin
        CalculateAge();
    end;

    local procedure CalculateAge()
    var
        Authors: Record Authors;
    begin
        //Authors.SetRange("Death Date", 0D);
        Authors.SetLoadFields("Birth Date", "Death Date", Age);
        if Authors.FindSet() then
            repeat
                if (Authors."Birth Date" <> 0D) and (Authors."Death Date" = 0D) then
                    Authors.Validate(Age, Today.Year() - Authors."Birth Date".Year())
                else if (Authors."Birth Date" <> 0D) and (Authors."Death Date" <> 0D) then
                    Authors.Validate(Age, Authors."Death Date".Year() - Authors."Birth Date".Year());
                Authors.Modify(true);
            until Authors.Next() = 0;

    end;

}
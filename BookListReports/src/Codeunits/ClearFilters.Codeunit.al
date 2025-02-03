codeunit 50304 "Clear Filters"
{
    trigger OnRun()
    begin

    end;

    procedure ClearAllFilters(var Library: Record Library; var DateFilter: Text; var PriceFilter: Text;
    var RentalFrequency: Integer; var InputText: Text; var FilterField: Enum "Field Names")
    begin
        Library.Reset();
        DateFilter := '';
        PriceFilter := '';
        RentalFrequency := 0;
        InputText := '';
        FilterField := FilterField::Default;
    end;
}
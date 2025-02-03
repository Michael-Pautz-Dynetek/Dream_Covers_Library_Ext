codeunit 50304 "Clear Filters"
{
    trigger OnRun()
    begin

    end;

    procedure ClearAllFilters(var Library: Record Library; var DateFilter: Text; var PriceFilter: Text;
    var RentalFrequency: Text; var InputText: Text; var FilterField: Enum "Field Names")
    var
        ConfirmClearFilterMessage: Label 'Do you want to clear all filters on this page?';
    begin
        if Confirm(ConfirmClearFilterMessage) then begin
            Library.Reset();
            DateFilter := '';
            PriceFilter := '';
            RentalFrequency := '';
            InputText := '';
            FilterField := FilterField::" ";
        end;
    end;
}
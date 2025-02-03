codeunit 50305 "Set Filters"
{
    trigger OnRun()
    begin

    end;

    procedure CreateFilters(var Library: Record Library; PublishingDate: Text; PriceFilter: Text; RentalFrequency: Integer;
    InputText: Text; FilterField: Enum "Field Names")
    begin
        SetDateFilter(PublishingDate, Library);
        SetPriceFilter(PriceFilter, Library);
        SetRentalFrequencyFilter(RentalFrequency, Library);
        SetTextFilter(InputText, FilterField, Library);
    end;

    local procedure SetDateFilter(PublishingDate: Text; var Library: Record Library)
    begin
        if PublishingDate <> '' then
            Library.SetFilter("Publication Date", PublishingDate);
    end;

    local procedure SetPriceFilter(PriceFilter: Text; var Library: Record Library)
    begin
        if PriceFilter <> '' then
            Library.SetFilter("Book Price", PriceFilter);
    end;

    local procedure SetRentalFrequencyFilter(RentalFrequency: Integer; var Library: Record Library)
    begin
        if RentalFrequency <> 0 then
            Library.SetFilter("Amount Rented", '>= %1', RentalFrequency);
    end;

    local procedure SetTextFilter(InputText: Text; FilterField: Enum "Field Names"; var Library: Record Library)
    var
        ErrorMessage: Label 'Select a field to apply this search on.';
    begin
        if InputText <> '' then begin
            case FilterField of
                FilterField::Author:
                    Library.SetFilter(Author, '@*' + InputText + '*');
                FilterField::Title:
                    Library.SetFilter(Title, '@*' + InputText + '*');
                FilterField::Genre:
                    Library.SetFilter(Genre, '@*' + InputText + '*');
                FilterField::Publisher:
                    Library.SetFilter(Publisher, '@*' + InputText + '*');
                FilterField::Default:
                    Error(ErrorMessage);
            end;
        end;
    end;
}
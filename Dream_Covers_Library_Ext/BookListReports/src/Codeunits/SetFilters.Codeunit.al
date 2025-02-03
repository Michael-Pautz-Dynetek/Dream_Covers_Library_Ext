codeunit 50305 "Set Filters"
{
    procedure SetDateFilter(var PublishingDate: Text; var Library: Record Library)
    begin
        if PublishingDate <> '' then
            Library.SetFilter("Publication Date", PublishingDate);
    end;

    procedure SetPriceFilter(var PriceFilter: Text; var Library: Record Library)
    begin
        if PriceFilter <> '' then
            Library.SetFilter("Book Price", PriceFilter);
    end;

    procedure SetRentalFrequencyFilter(var RentalFrequency: Text; var Library: Record Library)
    begin
        if RentalFrequency <> '' then
            Library.SetFilter("Amount Rented", RentalFrequency);
    end;

    procedure SetTextFilter(var InputText: Text; FilterField: Enum "Field Names"; var Library: Record Library)
    var
        SearchGenres: Codeunit "Search Genre Enum";
        ErrorMessage: Label 'Select a field to apply this search on.';
        GenreFilter: Text;
    begin
        if InputText <> '' then
            case FilterField of
                FilterField::Author:
                    Library.SetFilter(Author, '@*' + InputText + '*');
                FilterField::Title:
                    Library.SetFilter(Title, '@*' + InputText + '*');
                FilterField::Genre:
                    Library.SetFilter(Genre, SearchGenres.GetCaptions(InputText));
                FilterField::Publisher:
                    Library.SetFilter(Publisher, '@*' + InputText + '*');
                FilterField::" ":
                    Error(ErrorMessage);
            end;
    end;
}
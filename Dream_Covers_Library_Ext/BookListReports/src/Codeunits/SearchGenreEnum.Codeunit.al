codeunit 50310 "Search Genre Enum"
{
    trigger OnRun()
    begin

    end;

    procedure GetCaptions(Input: Text): Text
    var
        BookGenres: Enum "Book Genres";
        NotFoundMessage: Label 'No genres were found containing the text "%1"',Comment = 'Placeholder for input text.';
        CaptionsList: List of [Text];
        GenreName, FoundGenres : Text;
        IsFirst: Boolean;
    begin
        IsFirst := true;
        FoundGenres := '';
        CaptionsList := BookGenres.Names;
        foreach GenreName in CaptionsList do begin
            if GenreName.ToLower().Contains(Input.ToLower()) then begin
                if not IsFirst then
                    FoundGenres += '|' + GenreName
                else begin
                    FoundGenres += GenreName;
                    IsFirst := false;
                end;
            end;
        end;
        if IsFirst then begin
            FoundGenres := Format(BookGenres::" ");
            Message(NotFoundMessage, Input);
        end;
        exit(FoundGenres);
    end;
}
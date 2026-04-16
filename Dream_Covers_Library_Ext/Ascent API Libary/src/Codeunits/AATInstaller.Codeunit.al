codeunit 80104 "AAT Installer"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        RetenPolAllowedTables: Codeunit "Reten. Pol. Allowed Tables";
    begin
        RetenPolAllowedTables.AddAllowedTable(Database::"AAT API Request Log");
    end;

}

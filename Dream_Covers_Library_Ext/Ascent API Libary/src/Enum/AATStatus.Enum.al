/// <summary>
/// Enum AAT Status (ID 80100).
/// </summary>
enum 80100 "AAT Status"
{
    Extensible = true;

    value(0; Disabled) { Caption = 'Disabled'; }
    value(1; Development) { Caption = 'Development'; }
    value(2; Production) { Caption = 'Production'; }
}

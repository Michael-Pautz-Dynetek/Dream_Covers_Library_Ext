codeunit 50418 "Rent Return Log Actions"
{
    procedure FilterType(var RentReturnLogs: Record "Rent Return Log"; LogType: Text)
    begin
        RentReturnLogs.Reset();
        case LogType of
            'Rent':
                RentReturnLogs.SetRange(Type, 'Rent');
            'Return':
                RentReturnLogs.SetRange(Type, 'Return');
            else
                Error('The log type is not valid.');
        end;
    end;
}
reportextension 50210 "Standard Statement Ext." extends "Standard Statement"
{
    dataset
    {
        add(Customer)
        {
            column(Payment_Terms_Code; PaymentTermsDescription)
            { }
            column(Credit_Limit__LCY_; "Credit Limit (LCY)")
            { }
            column(Bank_Name; BankAccount.Name)
            {

            }
            column(Bank_Account_No_; BankAccount."Bank Account No.")
            {

            }
            column(Bank_Branch_No_; BankAccount."Bank Branch No.")
            {

            }
            column(Bank_Address; BankAccount.Address)
            {

            }
            column(Bank_Address_2; BankAccount."Address 2")
            {

            }
            column(Bank_SWIFT_Code; BankAccount."SWIFT Code")
            {

            }
            column(Bank_IBAN; BankAccount.IBAN)
            {

            }

        }
        modify(Customer)
        {
            trigger OnAfterAfterGetRecord()
            var
                PaymentTerms: Record "Payment Terms";
                BankAcc: Record "Bank Account";
            begin
                PaymentTerms.Get(Customer."Payment Terms Code");
                PaymentTermsDescription := PaymentTerms.Description;

                BankAcc.SetRange("Currency Code", Customer."Currency Code");
                BankAcc.SetRange("Use as Default for Currency", true);
                if BankAcc.FindFirst() then begin
                    BankAccount.Name := BankAcc.Name;
                    BankAccount."Bank Account No." := BankAcc."Bank Account No.";
                    BankAccount."Bank Branch No." := BankAcc."Bank Branch No.";
                    BankAccount.Address := BankAcc.Address;
                    BankAccount."Address 2" := BankAcc."Address 2";
                    BankAccount.IBAN := BankAcc.IBAN;
                    BankAccount."SWIFT Code" := BankAcc."SWIFT Code";
                end;

            end;

        }
    }
    var
        PaymentTermsDescription: Text;
        BankAccount: Record "Bank Account";

}

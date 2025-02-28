namespace Microsoft.Purchases.Document;

using Microsoft.CRM.Contact;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Segment;
using Microsoft.CRM.Team;
using Microsoft.Finance.Currency;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Location;
using Microsoft.Purchases.Posting;
using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Utilities;
using System.Email;
using System.Globalization;
using System.Utilities;

report 50413 "Custom Purchase Order Report"
{
    Caption = 'Custom Purchase Order Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './src/Reports/Report Layouts/Custom Purchase Order Report 2.docx';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(CompanyAddr1; CompanyAddr[1])
            {

            }
            column(CompanyAddr2; CompanyAddr[2])
            {

            }
            column(CompanyAddr3; CompanyAddr[3])
            {

            }
            column(CompanyAddr4; CompanyAddr[4])
            {

            }
            column(CompanyAddr5; CompanyAddr[5])
            {

            }
            column(CompanyAddr6; CompanyAddr[6])
            {

            }
            column(CompanyAddr7; CompanyAddr[7])
            {

            }
            column(CompanyAddr8; CompanyAddr[8])
            {

            }
            column(BuyFromAddr1; BuyFromAddr[1])
            {

            }
            column(BuyFromAddr2; BuyFromAddr[2])
            {

            }
            column(BuyFromAddr3; BuyFromAddr[3])
            {

            }
            column(BuyFromAddr4; BuyFromAddr[4])
            {

            }
            column(BuyFromAddr5; BuyFromAddr[5])
            {

            }
            column(BuyFromAddr6; BuyFromAddr[6])
            {

            }
            column(BuyFromAddr7; BuyFromAddr[7])
            {

            }
            column(BuyFromAddr8; BuyFromAddr[8])
            {

            }
            column(ShipToAddr1; ShipToAddr[1])
            {

            }
            column(ShipToAddr2; ShipToAddr[2])
            {

            }
            column(ShipToAddr3; ShipToAddr[3])
            {

            }
            column(ShipToAddr4; ShipToAddr[4])
            {

            }
            column(ShipToAddr5; ShipToAddr[5])
            {

            }
            column(ShipToAddr6; ShipToAddr[6])
            {

            }
            column(ShipToAddr7; ShipToAddr[7])
            {

            }
            column(ShipToAddr8; ShipToAddr[8])
            {

            }
            column(InvoiceDiscountAmount_PurchaseHeader; "Invoice Discount Amount")
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(DocumentDate_PurchaseHeader; Format("Document Date", 0, 4))
            {
            }
            dataitem("Buy-From Country/Region"; "Country/Region")
            {
                DataItemLink = "Code" = field("Buy-from Country/Region Code");
                column(BuyFromCountry; Name)
                {

                }
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2_PurchaseHeader; "Buy-from Vendor Name 2")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader; "Ship-to Name")
            {
            }
            column(ShiptoCounty_PurchaseHeader; "Ship-to County")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Ship-to Name 2")
            {
            }
            dataitem("Shipment Method"; "Shipment Method")
            {
                DataItemLink = "Code" = field("Shipment Method Code");
                column(ShipmentDescription; Description)
                {

                }
            }
            dataitem("Ship-to Country/Region"; "Country/Region")
            {
                DataItemLink = "Code" = field("Ship-to Country/Region Code");
                column(ShipToCountry; Name)
                {

                }
            }
            column(VATRegistrationNo_PurchaseHeader; "VAT Registration No.")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Payment Terms Code")
            {
            }
            dataitem("Payment Terms"; "Payment Terms")
            {
                DataItemLink = "Code" = field("Payment Terms Code");
                column(PaymentTermsDesc; "Description")
                {

                }
            }
            dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
            {
                DataItemLink = "Code" = field("Purchaser Code");
                column(PurchaserName; Name)
                {

                }
            }
            column(ExpectedReceiptDate_PurchaseHeader; Format("Expected Receipt Date", 0, 4))
            {
            }
            column(PricesIncludingVAT_PurchaseHeader; "Prices Including VAT")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_PurchaseHeader; "Vendor Order No.")
            {
            }
            column(DocumentNoLbl; DocumentNoLbl)
            {

            }
            column(PageLbl; PageLbl)
            {

            }
            column(ShipToLbl; ShipToLbl)
            {

            }
            column(PaymentTermsLbl; PaymentTermsLbl)
            {

            }
            column(BuyerLbl; BuyerLbl)
            {

            }
            column(ReceiveByLbl; ReceiveByLbl)
            {

            }
            column(ShipmentMethodLbl; ShipmentMethodLbl)
            {

            }
            column(PriceInclVatLbl; PriceInclVatLbl)
            {

            }
            column(VatRegNoLbl; VatRegNoLbl)
            {

            }
            column(GiroNoLbl; GiroNoLbl)
            {

            }
            column(VendorInvNoLbl; VendorInvNoLbl)
            {

            }
            column(VendorOrderNoLbl; VendorOrderNoLbl)
            {

            }
            column(LineNoLbl; LineNoLbl)
            {

            }
            column(LineDescriptionLbl; LineDescriptionLbl)
            {

            }
            column(QuantityLbl; QuantityLbl)
            {

            }
            column(UnitLbl; UnitLbl)
            {

            }
            column(UnitCostLbl; UnitCostLbl)
            {

            }
            column(VatAmountLbl; VatAmountLbl)
            {

            }
            column(LineAmountLbl; LineAmountLbl)
            {

            }
            column(VatPercentageLbl; VatPercentageLbl)
            {

            }
            column(TotalExclVatLbl; TotalExclVatLbl)
            {

            }
            column(TotalInclVatLbl; TotalInclVatLbl)
            {

            }
            column(TotalExclVat; TotalExclVat)
            {

            }
            column(VatAmount; VatAmount)
            {

            }
            column(TotalInclVat; TotalInclVat)
            {

            }
            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                column(No_PurchaseLine; "No.")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VAT_PurchaseLine; "VAT %")
                {
                }
                column(LineAmount_PurchaseLine; "Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVat_PurchaseHeader; "Line Amount" - "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
            }
            trigger OnAfterGetRecord()
            begin
                FormatAddressFields("Purchase Header");
                CalculateTotals("Purchase Header");
            end;
        }
        dataitem("Company Information"; "Company Information")
        {
            column(PostCode_CompanyInformation; "Post Code")
            {
            }
            column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
            {
            }
            column(Picture_CompanyInformation; Picture)
            {
            }
            column(GiroNo_CompanyInformation; "Giro No.")
            {
            }
            dataitem("Company Country/Region"; "Country/Region")
            {
                DataItemLink = "Code" = field("Ship-to Country/Region Code");
                column(CompanyCountry; Name)
                {

                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }

    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    var
        FormatAddr: Codeunit "Format Address";
        ResponsibilityCenter: Record "Responsibility Center";
    begin
        "Company Information".FindFirst();
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", ResponsibilityCenter, "Company Information", CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;

    local procedure CalculateTotals(var PurchaseHeader: Record "Purchase Header")
    var
        PurchLines: Record "Purchase Line";
    begin
        PurchLines.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLines.SetRange("Document No.", PurchaseHeader."No.");
        VatAmount := 0;
        TotalExclVat := 0;
        TotalInclVat := 0;
        if PurchLines.FindSet() then
            repeat
                TotalExclVat += PurchLines."Line Amount";
                VatAmount += (PurchLines."VAT %" / 100) * PurchLines."Line Amount";
            until PurchLines.Next() = 0;
        TotalInclVat := TotalExclVat + VatAmount;
    end;

    var
        BuyFromAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        DocumentNoLbl: Label 'Purchase Order';
        PageLbl: Label 'Page';
        ShipToLbl: Label 'Ship-to Address';
        PaymentTermsLbl: Label 'Payment Terms';
        BuyerLbl: Label 'Buyer';
        ReceiveByLbl: Label 'Receive By';
        ShipmentMethodLbl: Label 'Shipment Method';
        PriceInclVatLbl: Label 'Prices Including VAT';
        VatRegNoLbl: Label 'VAT Registration No.';
        GiroNoLbl: Label 'Giro No.';
        VendorInvNoLbl: Label 'Vendor Invoice No.';
        VendorOrderNoLbl: Label 'Vendor Order No.';
        LineNoLbl: Label 'No.';
        LineDescriptionLbl: Label 'Description';
        QuantityLbl: Label 'Quantity';
        UnitLbl: Label 'Unit';
        UnitCostLbl: Label 'Direct Unit Cost';
        VatPercentageLbl: Label 'Vat %';
        LineAmountLbl: Label 'Line Amount';
        TotalExclVatLbl: Label 'Total GBP Excl. VAT';
        TotalInclVatLbl: Label 'Total GBP Incl. VAT';
        VatAmountLbl: Label 'VAT Amount';
        TotalExclVat: Decimal;
        TotalInclVat: Decimal;
        VatAmount: Decimal;
}
codeunit 13062581 "Return Order Turnover Mgt.-Adl"
{
    var
        ADLCore: Codeunit "Adl Core-Adl";

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', true, false)]
    local procedure OnAfterSetFieldsBilltoCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer)
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT) then
            exit;
        if SalesHeader."Goods Return Type-Adl" <> '' then
            SalesHeader.Validate("Goods Return Type-Adl");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', true, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer);
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT) then
            exit;
        if SalesHeader."Goods Return Type-Adl" <> '' then
            SalesHeader.Validate("Goods Return Type-Adl");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Buy-from Vendor No.', true, false)]
    local procedure OnAfterValidateBuyFromVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT) then
            exit;
        if Rec."Goods Return Type-Adl" <> '' then
            Rec.Validate("Goods Return Type-Adl");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Pay-to Vendor No.', true, false)]
    local procedure OnAfterValidatePayToVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT) then
            exit;
        if Rec."Goods Return Type-Adl" <> '' then
            Rec.Validate("Goods Return Type-Adl");
    end;
}
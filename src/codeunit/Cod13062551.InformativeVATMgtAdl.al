codeunit 13062551 "Informative VAT Mgt.-Adl"
{
    var
        ADLCore: Codeunit "Adl Core-Adl";

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'VAT Prod. Posting Group', true, false)]
    local procedure OnBeforeValidateVatProsPostGroupInSalesLine(var Rec: Record "Sales Line")
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT) then exit;
        // <adl.13>
        with Rec do
            if VATPostingSetup.get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then
                "VAT % (informative)-Adl" := VATPostingSetup."VAT % (informative)-Adl"
            else
                "VAT % (informative)-Adl" := 0;
        // </adl.13>
    end;
}
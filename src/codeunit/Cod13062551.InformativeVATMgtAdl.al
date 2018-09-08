codeunit 13062551 "Informative VAT Mgt.-Adl"
{
    var
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'VAT Prod. Posting Group', true, false)]
    local procedure OnBeforeValidateVatProsPostGroupInSalesLine(var Rec: Record "Sales Line")
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;
        // <adl.13>
        with Rec do begin
            if VATPostingSetup.get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then
                "VAT % (informative)-Adl" := VATPostingSetup."VAT % (informative)-Adl"
            else
                "VAT % (informative)-Adl" := 0;
        end;
        // </adl.13>
    end;
}
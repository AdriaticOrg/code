codeunit 13062581 "Return Order Turnover Mgt.-Adl"
{
    var
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'VAT Prod. Posting Group', true, false)]
    local procedure OnBeforeValidateVatProsPostGroupInSalesLine(var Rec: Record "Sales Line")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;
        HandleSalesVATProdPostingSetup(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'VAT Prod. Posting Group', true, false)]
    local procedure OnBeforeValidateVatProsPostGroupInPurchLine(var Rec: Record "Purchase Line")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;
        HandlePurchVATProdPostingSetup(Rec);
    end;

    procedure HandleSalesVATProdPostingSetup(var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;
        with SalesLine do begin
            if "Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] then begin
                SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                "VAT Prod. Posting Group" := GetVATProdPostingGroup(
                    SalesHeader."Goods Return Type-Adl", "VAT Bus. Posting Group", "VAT Prod. Posting Group")
            end;
        end;
    end;

    procedure HandlePurchVATProdPostingSetup(var PurchLine: Record "Purchase Line")
    var
        PurchHeader: Record "Purchase Header";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;
        with PurchLine do begin
            if "Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"] then begin
                PurchHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
                "VAT Prod. Posting Group" := GetVATProdPostingGroup(
                    PurchHeader."Goods Return Type-Adl", "VAT Bus. Posting Group", "VAT Prod. Posting Group")
            end;
        end;
    end;

    procedure GetVATProdPostingGroup(GoodsReturnTypeCode: Code[10]; VATBusPostGr: Code[10]; VATProdPostGr: Code[10]): Code[10]
    var
        GoodsReturnType: Record "Goods Return Type-Adl";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;
        IF NOT GoodsReturnType.IsEmpty() then begin
            GoodsReturnType.SetRange("VAT Bus. Posting Group", VATBusPostGr);
            if GoodsReturnTypeCode <> '' then begin
                GoodsReturnType.SetRange("Code", GoodsReturnTypeCode);
                GoodsReturnType.SetRange("VAT Prod. Posting Group", VATProdPostGr);
                GoodsReturnType.FindFirst;
                exit(GoodsReturnType."New VAT Prod. Posting Group");
            end else begin
                GoodsReturnType.SetRange("Code");
                GoodsReturnType.SetRange("New VAT Prod. Posting Group", VATProdPostGr);
                IF GoodsReturnType.FindFirst THEN begin
                    GoodsReturnType.TestField("VAT Prod. Posting Group");
                    exit(GoodsReturnType."VAT Prod. Posting Group");
                end;
            end;
        end;
        exit(VATProdPostGr);
    end;
}
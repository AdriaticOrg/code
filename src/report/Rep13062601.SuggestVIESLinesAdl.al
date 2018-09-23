report 13062601 "Suggest VIES Lines-Adl"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest VIES Lines';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting ("Type");
            RequestFilterFields = "Type", "Posting Date", "Document No.";

            trigger OnPreDataItem()
            begin
                VIESRepHeader.Get(VIESRepDocNo);

                if DeleteExisting then begin
                    VIESRepLine.Reset();
                    VIESRepLine.SetRange("Document No.", VIESRepDocNo);
                    VIESRepLine.DeleteAll(true);
                end;

                if VIESRepLine.FindLast() then
                    NewLineNo := VIESRepLine."Line No";
            end;

            trigger OnPostDataItem()
            begin
                VIESRepHeader."Last Suggest on Date" := Today();
                VIESRepHeader."Last Suggest at Time" := Time();
                VIESRepHeader.Modify(true);
                Message(ProcessingCompleteMsg);
            end;

            trigger OnAfterGetRecord()
            var
                VATPstSetup: Record "VAT Posting Setup";
            begin
                if not VATPstSetup.get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then exit;
                if (not VATPstSetup."VIES Goods-Adl") and (not VATPstSetup."EU Service") then exit;

                TestField("Country/Region Code");

                if "VAT Correction Date-Adl" = 0D then
                    ProcessVATEntry("VAT Entry", OldViesRepHead, 0)
                else begin
                    // append new correction entry
                    OldViesRepHead.Reset();
                    OldViesRepHead.SetRange("VIES Country", VIESRepHeader."VIES Country");
                    OldViesRepHead.SetRange("VIES Type", VIESRepHeader."VIES Type");
                    OldViesRepHead.SetFilter("Period Start Date", '<=%1', "VAT Correction Date-Adl");
                    OldViesRepHead.SetFilter("Period End Date", '>=%1', "VAT Correction Date-Adl");
                    OldViesRepHead.FindSet();

                    ProcessVATEntry("VAT Entry", OldViesRepHead, 1);

                    // eppend all existing old entries
                    OldVATEntry.Reset();
                    OldVATEntry.SetCurrentKey(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date");
                    OldVATEntry.SetRange("Type", "Type");
                    OldVATEntry.Setfilter("Posting Date", '>=%1&<=%2', OldViesRepHead."Period Start Date", OldViesRepHead."Period End Date");
                    OldVATEntry.SetRange("Bill-to/Pay-to No.", "Bill-to/Pay-to No.");
                    if OldVATEntry.FindSet() then
                        repeat
                            ProcessVATEntry(OldVATEntry, OldViesRepHead, 1);
                        until OldVATEntry.Next() = 0
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(DeleteExisting; DeleteExisting)
                    {
                        Caption = 'Delete existing lines';
                        ApplicationArea = All;
                        ToolTip = 'Deletes existing lines in current document';
                    }
                }
            }
        }
    }

    var
        VIESRepLine: record "VIES Report Line-Adl";
        OldViesRepHead: Record "VIES Report Header-Adl";
        VIESRepHeader: Record "VIES Report Header-Adl";
        OldVATEntry: Record "VAT Entry";
        DeleteExisting: Boolean;
        VIESRepDocNo: Code[20];
        NewLineNo: Integer;


        ProcessingCompleteMsg: Label 'Processing complete';

    procedure SetVIESRepDocNo(VIESDocNoLcl: Code[20])
    begin
        VIESRepDocNo := VIESDocNoLcl;
    end;

    local procedure ProcessVATEntry(VATEntry: record "VAT Entry";
     OldRepHead: Record "VIES Report Header-Adl"; RepType: option "New","Correction")
    var
        VATSetup: Record "VAT Posting Setup";
        Cust: Record Customer;
        Vend: Record Vendor;
        IsSales: Boolean;
        VATRegNo: Text[20];
    begin
        if not VATSetup.get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") then exit;
        if (not VATSetup."VIES Goods-Adl") and (not VATSetup."EU Service") then exit;

        with VATEntry do begin

            case "Type" of
                "Type"::Sale:
                    begin
                        if not Cust.get("Bill-to/Pay-to No.") then exit;
                        Cust.TestField("VAT Registration No.");
                        VATRegNo := Cust."VAT Registration No.";
                    end;
                "Type"::Purchase:
                    begin
                        if not Vend.get("Bill-to/Pay-to No.") then exit;
                        Vend.TestField("VAT Registration No.");
                        VATRegNo := Vend."VAT Registration No.";
                    end;
            end;

            IsSales := true;
            if (VIESRepHeader."VIES Country" = VIESRepHeader."VIES Country"::Croatia) and
                (VIESRepHeader."VIES Type" = VIESRepHeader."VIES Type"::"PDV-S")
            then
                IsSales := false;

            VIESRepLine.Reset();

            if IsSales then
                VIESRepLine.SetRange("Source Type", VIESRepLine."Source Type"::Sales)
            else
                VIESRepLine.SetRange("Source Type", VIESRepLine."Source Type"::Purchases);

            VIESRepLine.SetRange(Type, RepType);
            if RepType = RepType::Correction then begin
                VIESRepLine.SetRange(Type, VIESRepLine.type::Correction);
                VIESRepLine.SetRange("Period Year", OldRepHead."Period Year");
                VIESRepLine.SetRange("Period Round", OldRepHead."Period Round");
                VIESRepLine.SetRange("Applies-to Report No.", OldRepHead."No.");
            end;

            VIESRepLine.SetRange("Document No.", VIESRepDocNo);
            VIESRepLine.SetRange("Country/Region Code", "Country/Region Code");
            VIESRepLine.SetRange("VAT Registration No.", VATRegNo);
            VIESRepLine.SetRange("EU 3-Party Trade", "EU 3-Party Trade");
            VIESRepLine.SetRange("EU Customs Procedure", "EU Customs Procedure-Adl");

            if VATSetup."VIES Goods-Adl" then
                VIESRepLine.SetRange("EU Sales Type", VIESRepLine."EU Sales Type"::Goods);

            if VATSetup."EU Service" then
                VIESRepLine.SetRange("EU Sales Type", VIESRepLine."EU Sales Type"::Services);

            if VIESRepLine.FindSet() then begin
                if IsSales then
                    VIESRepLine.Amount += (-Base)
                else
                    VIESRepLine.Amount += Base;
                VIESRepLine.Modify(true);
            end else begin
                NewLineNo += 10000;
                VIESRepLine.Init();
                VIESRepLine."Document No." := VIESRepDocNo;
                VIESRepLine."Line No" := NewLineNo;

                if IsSales then
                    VIESRepLine."Source Type" := VIESRepLine."Source Type"::Sales
                else
                    VIESRepLine."Source Type" := VIESRepLine."Source Type"::Purchases;

                VIESRepLine.Type := RepType;
                VIESRepLine."VAT Identifier" := "VAT Identifier-Adl";
                VIESRepLine."Country/Region Code" := "Country/Region Code";
                VIESRepLine."VAT Registration No." := VATRegNo;
                VIESRepLine."EU 3-Party Trade" := "EU 3-Party Trade";
                VIESRepLine."EU Customs Procedure" := "EU Customs Procedure-Adl";

                if VATSetup."VIES Goods-Adl" then
                    VIESRepLine."EU Sales Type" := VIESRepLine."EU Sales Type"::Goods;

                if VATSetup."EU Service" then
                    VIESRepLine."EU Sales Type" := VIESRepLine."EU Sales Type"::Services;

                if RepType = RepType::Correction then begin
                    VIESRepLine."Applies-to Report No." := OldRepHead."No.";
                    VIESRepLine."Period Year" := OldRepHead."Period Year";
                    VIESRepLine."Period Round" := OldRepHead."Period Round";
                end else begin
                    VIESRepLine."Period Year" := VIESRepHeader."Period Year";
                    VIESRepLine."Period Round" := VIESRepHeader."Period Round";
                end;

                if IsSales then
                    VIESRepLine.Amount := -(Base)
                else
                    VIESRepLine.Amount := Base;

                VIESRepLine.Insert(true);
            end;
        end;
    end;
}
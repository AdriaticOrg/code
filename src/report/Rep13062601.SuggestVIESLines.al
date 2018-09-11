report 13062601 "Suggest VIES Lines"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest VIES Lines';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting ("Type") where ("Type" = const (Sale));
            RequestFilterFields = "Posting Date", "Document No.";

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
                Cust: Record Customer;
                VATPstSetup: Record "VAT Posting Setup";
            begin
                if not VATPstSetup.get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then exit;
                if not VATPstSetup."VIES Goods Sales-Adl" or VATPstSetup."VIES Service Sales-Adl" then exit;
                if not Cust.get("Bill-to/Pay-to No.") then exit;

                Cust.TestField("VAT Registration No.");
                TestField("Country/Region Code");

                if "VAT Correction Date-Adl" = 0D then
                    ProcessVATEntry("VAT Entry", Cust, OldViesRepHead, 0)
                else begin
                    OldViesRepHead.Reset();
                    OldViesRepHead.SetFilter("Period Start Date", '<=%1', "VAT Correction Date-Adl");
                    OldViesRepHead.SetFilter("Period End Date", '>=%1', "VAT Correction Date-Adl");
                    OldViesRepHead.FindSet();

                    ProcessVATEntry("VAT Entry", Cust, OldViesRepHead, 1);

                    OldVATEntry.Reset();
                    OldVATEntry.SetCurrentKey(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date");
                    OldVATEntry.SetRange(Type, OldVATEntry.Type::Sale);
                    OldVATEntry.Setfilter("Posting Date", '>=%1&<=%2', OldViesRepHead."Period Start Date", OldViesRepHead."Period End Date");
                    OldVATEntry.SetRange("Bill-to/Pay-to No.", "Bill-to/Pay-to No.");
                    if OldVATEntry.FindSet() then
                        repeat
                            ProcessVATEntry(OldVATEntry, Cust, OldViesRepHead, 1);
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
                    }
                }
            }
        }
    }

    var
        VIESRepLine: record "VIES Report Line";
        OldViesRepHead: Record "VIES Report Header";
        VIESRepHeader: Record "VIES Report Header";
        OldVATEntry: Record "VAT Entry";
        DeleteExisting: Boolean;
        VIESRepDocNo: Code[20];
        NewLineNo: Integer;


        ProcessingCompleteMsg: Label 'Processing complete';

    procedure SetVIESRepDocNo(VIESDocNoLcl: Code[20])
    begin
        VIESRepDocNo := VIESDocNoLcl;
    end;

    local procedure ProcessVATEntry(VATEntry: record "VAT Entry"; Cust2: Record Customer;
     OldRepHead: Record "VIES Report Header"; RepType: option "New","Correction")
    var
        VATSetup: Record "VAT Posting Setup";
    begin
        if not VATSetup.get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") then exit;
        if not VATSetup."VIES Goods Sales-Adl" or VATSetup."VIES Service Sales-Adl" then exit;

        with VATEntry do begin
            VIESRepLine.Reset();

            VIESRepLine.SetRange(Type, RepType);
            if RepType = RepType::Correction then begin
                VIESRepLine.SetRange(Type, VIESRepLine.type::Correction);
                VIESRepLine.SetRange("Period Year", OldRepHead."Period Year");
                VIESRepLine.SetRange("Period Round", OldRepHead."Period Round");
                VIESRepLine.SetRange("Applies-to Report No.", OldRepHead."No.");
            end;

            VIESRepLine.SetRange("Document No.", VIESRepDocNo);
            VIESRepLine.SetRange("Country/Region Code", "Country/Region Code");
            VIESRepLine.SetRange("VAT Registration No.", Cust2."VAT Registration No.");
            VIESRepLine.SetRange("EU 3-Party Trade", "EU 3-Party Trade");
            VIESRepLine.SetRange("EU Customs Procedure", "EU Customs Procedure-Adl");

            if VATSetup."VIES Goods Sales-Adl" then
                VIESRepLine.SetRange("EU Sales Type", VIESRepLine."EU Sales Type"::Goods);

            if VATSetup."VIES Service Sales-Adl" then
                VIESRepLine.SetRange("EU Sales Type", VIESRepLine."EU Sales Type"::Services);

            if VIESRepLine.FindSet() then begin
                VIESRepLine.Amount += (-Base);
                VIESRepLine.Modify(true);
            end else begin
                NewLineNo += 10000;
                VIESRepLine.Init();
                VIESRepLine."Document No." := VIESRepDocNo;
                VIESRepLine."Line No" := NewLineNo;
                VIESRepLine.Type := RepType;
                VIESRepLine."Country/Region Code" := "Country/Region Code";
                VIESRepLine."VAT Registration No." := Cust2."VAT Registration No.";
                VIESRepLine."EU 3-Party Trade" := "EU 3-Party Trade";
                VIESRepLine."EU Customs Procedure" := "EU Customs Procedure-Adl";

                if VATSetup."VIES Goods Sales-Adl" then
                    VIESRepLine."EU Sales Type" := VIESRepLine."EU Sales Type"::Goods;

                if VATSetup."VIES Service Sales-Adl" then
                    VIESRepLine."EU Sales Type" := VIESRepLine."EU Sales Type"::Services;

                if RepType = RepType::Correction then begin
                    VIESRepLine."Applies-to Report No." := OldRepHead."No.";
                    VIESRepLine."Period Year" := OldRepHead."Period Year";
                    VIESRepLine."Period Round" := OldRepHead."Period Round";
                end else begin
                    VIESRepLine."Period Year" := VIESRepHeader."Period Year";
                    VIESRepLine."Period Round" := VIESRepHeader."Period Round";
                end;

                VIESRepLine.Amount := -(Base);
                VIESRepLine.Insert(true);
            end;
        end;
    end;
}
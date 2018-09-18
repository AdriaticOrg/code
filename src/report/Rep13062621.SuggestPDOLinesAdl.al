report 13062621 "Suggest PDO Lines-Adl"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest PDO Lines';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting ("Type") where ("Type" = const (Sale));
            RequestFilterFields = "Posting Date", "Document No.", "VAT Identifier-Adl";

            trigger OnPreDataItem()
            begin
                if DeleteExisting then begin
                    PDORepLine.Reset();
                    PDORepLine.SetRange("Document No.", PDORepDocNo);
                    PDORepLine.DeleteAll(true);
                end;

                if PDORepLine.FindLast() then
                    NewLineNo := PDORepLine."Line No";
            end;

            trigger OnPostDataItem()
            var
                PDORepHead: Record "PDO Report Header-Adl";
            begin
                PDORepHead.Get(PDORepDocNo);
                PDORepHead."Last Suggest on Date" := Today();
                PDORepHead."Last Suggest at Time" := Time();
                PDORepHead.Modify(true);
                Message(ProcessingCompleteMsg);
            end;

            trigger OnAfterGetRecord()
            var
                Cust: Record Customer;
                VATPstSetup: Record "VAT Posting Setup";
            begin
                if not VATPstSetup.get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then exit;
                if VATPstSetup."VAT % (informative)-Adl" = 0 then exit;
                if not Cust.get("Bill-to/Pay-to No.") then exit;

                Cust.TestField("VAT Registration No.");
                TestField("Country/Region Code");

                if "VAT Correction Date-Adl" = 0D then
                    ProcessVATEntry("VAT Entry", Cust, OldPDORepHead, 0)
                else begin
                    OldPDORepHead.Reset();
                    OldPDORepHead.SetFilter("Period Start Date", '<=%1', "VAT Correction Date-Adl");
                    OldPDORepHead.SetFilter("Period End Date", '>=%1', "VAT Correction Date-Adl");
                    OldPDORepHead.FindSet();

                    ProcessVATEntry("VAT Entry", Cust, OldPDORepHead, 1);

                    OldVATEntry.Reset();
                    OldVATEntry.SetCurrentKey(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date");
                    OldVATEntry.SetRange(Type, OldVATEntry.Type::Sale);
                    OldVATEntry.Setfilter("Posting Date", '>=%1&<=%2', OldPDORepHead."Period Start Date", OldPDORepHead."Period End Date");
                    OldVATEntry.SetRange("Bill-to/Pay-to No.", "Bill-to/Pay-to No.");
                    if OldVATEntry.FindSet() then
                        repeat
                            ProcessVATEntry(OldVATEntry, Cust, OldPDORepHead, 1);
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
        PDORepLine: record "PDO Report Line-Adl";
        OldPDORepHead: Record "PDO Report Header-Adl";
        OldVATEntry: Record "VAT Entry";

        DeleteExisting: Boolean;
        PDORepDocNo: Code[20];
        NewLineNo: Integer;

        ProcessingCompleteMsg: Label 'Processing complete';

    procedure SetPDORepDocNo(PDODocNoLcl: Code[20])
    begin
        PDORepDocNo := PDODocNoLcl;
    end;

    local procedure ProcessVATEntry(VATEntry: record "VAT Entry"; Cust2: Record Customer;
     OldRepHead: Record "PDO Report Header-Adl"; RepType: option "New","Correction")
    var
        VATSetup: Record "VAT Posting Setup";
    begin
        if not VATSetup.get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group") then exit;
        if VATSetup."VAT % (informative)-Adl" = 0 then exit;

        with VATEntry do begin
            PDORepLine.Reset();

            PDORepLine.SetRange(Type, RepType);
            if RepType = RepType::Correction then begin
                PDORepLine.SetRange(Type, PDORepLine.type::Correction);
                PDORepLine.SetRange("Period Year", OldRepHead."Period Year");
                PDORepLine.SetRange("Period Round", OldRepHead."Period Round");
                PDORepLine.SetRange("Applies-to Report No.", OldRepHead."No.");
            end;

            PDORepLine.SetRange("Document No.", PDORepDocNo);
            PDORepLine.SetRange("Country/Region Code", "Country/Region Code");
            PDORepLine.SetRange("VAT Registration No.", Cust2."VAT Registration No.");

            if PDORepLine.FindSet() then begin
                PDORepLine."Amount (LCY)" += (-Base);
                PDORepLine.Modify(true);
            end else begin
                NewLineNo += 10000;
                PDORepLine.Init();
                PDORepLine."Document No." := PDORepDocNo;
                PDORepLine."Line No" := NewLineNo;
                PDORepLine.Type := RepType;
                //PDORepLine."VAT Identifier" := "VAT Identifier-Adl";
                PDORepLine."Country/Region Code" := "Country/Region Code";
                PDORepLine."VAT Registration No." := Cust2."VAT Registration No.";

                if RepType = RepType::Correction then begin
                    PDORepLine."Applies-to Report No." := OldRepHead."No.";
                    PDORepLine."Period Year" := OldRepHead."Period Year";
                    PDORepLine."Period Round" := OldRepHead."Period Round";
                end;

                PDORepLine."Amount (LCY)" := -(Base);
                PDORepLine.Insert(true);
            end;
        end;
    end;
}
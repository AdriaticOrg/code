report 13062641 "Suggest FAS Lines"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest FAS Lines';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "G/L Account No.";

            trigger OnPreDataItem()
            begin
                if DeleteExisting then begin
                    FASRepLine.Reset();
                    FASRepLine.SetRange("Document No.", FASRepDocNo);
                    FASRepLine.DeleteAll(true);
                end;

                if FASRepLine.FindLast() then
                    NewLineNo := FASRepLine."Line No";

                InitialRep := FASRepHead."Previous Report No." = '';
            end;

            trigger OnPostDataItem()
            var
                FASRepHead: Record "FAS Report Header";
            begin
                FASRepHead.Get(FASRepDocNo);
                FASRepHead."Last Suggest on Date" := Today();
                FASRepHead."Last Suggest at Time" := Time();
                FASRepHead.Modify(true);
                Message(ProcessingCompleteMsg);
            end;

            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
            begin
                if GLAcc.get("G/L Account No.") and GLAcc."FAS Account-Adl" and ("FAS Type-Adl" <> "FAS Type-Adl"::" ") then begin
                    FASRepLine.SetRange("Document No.", FASRepDocNo);
                    FASRepLine.SetRange("Sector Code", "FAS Sector Code-Adl");
                    FASRepLine.SetRange("Instrument Code", "FAS Instrument Code-Adl");
                    FASRepLine.SetRange("FAS Type", "FAS Type-Adl");

                    if FASRepLine.FindSet() then begin
                        FASRepLine."Transactions Amt. in Period" += Amount;
                        FASRepLine."Changes Amt. in Period" += Amount;
                        FASRepLine."Period Closing Balance" += Amount;
                        FASRepLine.Modify(true);
                    end else begin
                        NewLineNo += 10000;
                        FASRepLine.Init();
                        FASRepLine."Document No." := FASRepDocNo;
                        FASRepLine."Line No" := NewLineNo;
                        FASRepLine."FAS Type" := "FAS Type-Adl";
                        FASRepLine.validate("Sector Code", "FAS Sector Code-Adl");
                        FASRepLine.validate("Instrument Code", "FAS Instrument Code-Adl");
                        FASRepLine."Transactions Amt. in Period" := Amount;
                        FASRepLine."Changes Amt. in Period" := Amount;
                        FASRepLine."Period Closing Balance" := GetOpeningBalance("FAS Sector Code-Adl", "FAS Instrument Code-Adl", "FAS Type-Adl") + Amount;
                        FASRepLine.Insert(true);
                    end;
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
        FASRepLine: record "FAS Report Line";
        FASRepHead: Record "FAS Report Header";
        DeleteExisting: Boolean;
        FASRepDocNo: Code[20];
        NewLineNo: Integer;
        InitialRep: Boolean;

        ProcessingCompleteMsg: Label 'Processing complete';

    procedure SetFASRepDocNo(FASDocNoLcl: Code[20])
    begin
        FASRepDocNo := FASDocNoLcl;
        FASRepHead.get(FASRepDocNo);
    end;

    local procedure GetOpeningBalance(SectorCode: code[10]; InstrumenteCode: Code[10]; FASType: Option " ",Assets,Liabilities): Decimal
    var
        OldGLE: Record "G/L Entry";
        OldFASRepLine: Record "FAS Report Line";
        OpeningBal: Decimal;
    begin
        if InitialRep then begin
            OldGLE.Reset();
            OldGLE.SetRange("FAS Sector Code-Adl", SectorCode);
            OldGLE.SetRange("FAS Instrument Code-Adl", InstrumenteCode);
            OldGLE.SetRange("FAS Type-Adl", FASType);
            OldGLE.SetFilter("Posting Date", '<=%1', FASREPHead."Period Start Date");
            if OldGLE.FindSet() then
                repeat
                    OpeningBal += OldGLE.Amount;
                until OldGLE.Next() = 0;
        end else begin
            OldFASRepLine.Reset();
            OldFASRepLine.SetRange("Document No.", FASRepHead."Previous Report No.");
            OldFASRepLine.SetRange("Sector Code", SectorCode);
            OldFASRepLine.SetRange("Instrument Code", InstrumenteCode);
            OldFASRepLine.SetRange("FAS Type", FASType);
            if OldFASRepLine.FindSet() then
                repeat
                    OpeningBal := OpeningBal + OldFASRepLine."Period Closing Balance";
                until OldFASRepLine.Next() = 0;
        end;

        exit(OpeningBal);

    end;
}
report 13062641 "Suggest FAS Lines"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest FAS Lines'; 
  
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date","Document No.","G/L Account No.";

            trigger OnPreDataItem()
            begin
                if DeleteExisting then begin
                    FASRepLine.Reset();
                    FASRepLine.SetRange("Document No.",FASRepDocNo);
                    FASRepLine.DeleteAll(true);
                end; 

                if FASRepLine.FindLast() then
                    NewLineNo := FASRepLine."Line No";

                InitialRep := FASRepHead."Previous Report No." = '';
                    
            end;

            trigger OnPostDataItem()
            var
                FASRepHead:Record "FAS Report Header";
            begin
                FASRepHead.Get(FASRepDocNo);
                FASRepHead."Last Suggest on Date" := Today;
                FASRepHead."Last Suggest at Time" := time;
                FASRepHead.Modify(true);
                Message(Msg01);
            end;
            
            trigger OnAfterGetRecord()  
            var
                GLAcc:Record "G/L Account";              
            begin
                if GLAcc.get("G/L Account No.") and GLAcc."FAS Account" then begin
                    TestField("FAS Type");
                    FASRepLine.SetRange("Document No.",FASRepDocNo);
                    FASRepLine.SetRange("Sector Code","FAS Sector Code");
                    FASRepLine.SetRange("Instrument Code","FAS Instrument Code");
                    FASRepLine.SetRange("FAS Type","FAS Type");
                    
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
                        FASRepLine.validate("Sector Code","FAS Sector Code");
                        FASRepLine.validate("Instrument Code","FAS Instrument Code");
                        FASRepLine."Transactions Amt. in Period" := Amount;
                        FASRepLine."Changes Amt. in Period" := Amount;
                        FASRepLine."Period Closing Balance" := GetOpeningBalance("FAS Sector Code","FAS Instrument Code","FAS Type") + Amount;
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
                    field(DeleteExisting;DeleteExisting)
                    {
                        Caption = 'Delete existing lines';
                        ApplicationArea = All;                        
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;                    
                }
            }
        }
    }
   
    var
    DeleteExisting:Boolean;
    FASRepDocNo:Code[20];
    NewLineNo:Integer;
    InitialRep:Boolean;
    FASRepLine:record "FAS Report Line";
    FASRepHead:Record "FAS Report Header";

    Msg01:Label 'Processing complete';

    procedure SetFASRepDocNo(FASDocNoLcl:Code[20]) 
    begin
        FASRepDocNo := FASDocNoLcl;   
        FASRepHead.get(FASRepDocNo);    
    end;   
 
    local procedure GetOpeningBalance(SectorCode:code[10];InstrumenteCode:Code[10];FASType:Option " ",Assets,Liabilities):Decimal
    var
        OldGLE:Record "G/L Entry";
        OldFASRepLine:Record "FAS Report Line";
        OpeningBal:Decimal;
    begin
        if InitialRep then begin
            OldGLE.Reset();
            OldGLE.SetRange("FAS Sector Code",SectorCode);
            OldGLE.SetRange("FAS Instrument Code",InstrumenteCode);
            OldGLE.SetRange("FAS Type",FASType);
            OldGLE.SetFilter("Posting Date",'<=%1',FASREPHead."Period Start Date");
            if OldGLE.FindSet() then begin
                repeat
                    OpeningBal += OldGLE.Amount;
                until OldGLE.Next() = 0;
            end;          
        end else begin
            OldFASRepLine.Reset();
            OldFASRepLine.SetRange("Document No.",FASRepHead."Previous Report No.");
            OldFASRepLine.SetRange("Sector Code",SectorCode);
            OldFASRepLine.SetRange("Instrument Code",InstrumenteCode);
            OldFASRepLine.SetRange("FAS Type",FASType);
            if OldFASRepLine.FindSet() then begin
                repeat
                    OpeningBal := OpeningBal + OldFASRepLine."Period Closing Balance";
                until OldFASRepLine.Next() = 0;
            end;
            
        end;

        exit(OpeningBal);

    end; 
}
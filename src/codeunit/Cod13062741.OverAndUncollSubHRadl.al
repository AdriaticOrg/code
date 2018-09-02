codeunit 13062741 "Cod13062741OverAndUncoll-adl"
{   
 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(VAR GenJournalLine : Record "Gen. Journal Line";PreviewMode : Boolean;CommitIsSuppressed : Boolean)
     var 
        GenPostLine: Codeunit "Gen. Jnl.-Post Line"; 
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
    begin
        GenJnlLine3.Copy(GenJournalLine);
        GenJnlLine3.FindFirst();

        with GenJnlLine3 do begin
            case "Account Type" OF
                "Account Type"::Customer: //, "Account Type"::Vendor:
                    begin   
                        //GenJnlLine2.Copy(GenJnlLine);
                        GenJnlLine2."Journal Template Name":= GenJnlLine3."Journal Template Name";
                        GenJnlLine2."Journal Batch Name":= GenJnlLine3."Journal Batch Name";
                        GenJnlLine2.SETRANGE("Journal Template Name",GenJnlLine3."Journal Template Name");
                        GenJnlLine2.SETRANGE("Journal Batch Name",GenJnlLine3."Journal Batch Name");   

                        GenJnlLine2.iNIT;   
                        GenJnlLine2."Line No.":= 10000;
                        GenJnlLine2."Posting Date":= GenJnlLine3."Posting Date";
                        GenJnlLine2."Document Date":= GenJnlLine3."Document Date";
                        GenJnlLine2."Document no.":= GenJnlLine3."Document No.";
                        GenJnlLine2."Document Type":= GenJnlLine3."Document Type"::Payment;                       
                        GenJnlLine2."Account Type":= GenJnlLine3."Account Type"::"G/L Account";
                        GenJnlLine2."Account No.":= '500100';
               
                        GenJnlLine2."Bal. Account Type":= GenJnlLine3."Bal. Account Type"::"G/L Account"; 
                        GenJnlLine2."Bal. Account No.":= '500050';

                        GenJnlLine2.Amount:= GenJnlLine3.Amount - GenJnlLine3."Original Document Amount (LCY)";
                        GenPostLine.RunWithCheck(GenJnlLine2);
                    end;
            end;
end;  
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterRunWithCheck', '', false, false)]
    local procedure OnAfterRunWithCheck(VAR GenJnlLine : Record "Gen. Journal Line")
    begin

    end;
 

}
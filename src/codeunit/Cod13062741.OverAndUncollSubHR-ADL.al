codeunit 13062741 "Cod13062741OverAndUncoll-adl"
{   
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(VAR GenJournalLine : Record "Gen. Journal Line";Balancing : Boolean)
    var
        GenJnlLine2 : Record "Gen. Journal Line";
    begin
        with GenJournalLine do
            case "Account Type" OF
                "Account Type"::Customer, "Account Type"::Vendor:
                begin
                    COPY(GenJnlLine2);
                    //GenJournalLine.
                end;
            end;
        end;      


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostVAT', '', false, false)]
    local procedure OnBeforePostVAT(GenJnlLine : Record "Gen. Journal Line";VAR GLEntry : Record "G/L Entry";VATPostingSetup : Record "VAT Posting Setup")
    begin
        
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostVAT', '', false, false)]
    local procedure OnAfterPostVAT(GenJnlLine : Record "Gen. Journal Line";VAR GLEntry : Record "G/L Entry";VATPostingSetup : Record "VAT Posting Setup")
    begin
        
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]
    local procedure OnAfterPostGLAcc()
    begin
        
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostCust', '', false, false)]
    local procedure OnAfterPostCust(var GenJournalLine : Record "Gen. Journal Line";Balancing : Boolean)
    var 
        CustomerLdgEntry : Record "Cust. Ledger Entry";
    begin

        //GenJournalLine."Original Document Amount (LCY)";
        //GenJournalLine."Original VAT Amount (LCY)";
        /*CustomerLdgEntry.RESET;
        CustomerLdgEntry.SETCURRENTKEY("Journal Template Name","Journal Batch Name","Line No.");
        CustomerLdgEntry.SETRANGE("Journal Template Name",GenJnlLine."Journal Template Name");
        CustomerLdgEntry.SETRANGE("Journal Batch Name",GenJnlLine."Journal Batch Name");
        CustomerLdgEntry.SETRANGE("Line No.",GenJnlLine."Line No.");
        CustomerLdgEntry.SETRANGE("Is Journal Line",TRUE);
        IF CustomerLdgEntry.FINDFIRST THEN BEGIN
            CustomerLdgEntry2.INIT;
            CustomerLdgEntry2."Entry No.":=CustLedgEntry."Entry No.";
            CustomerLdgEntry2."Is Journal Line":=FALSE;
            CustomerLdgEntry2."Original Document Amount (LCY)":=CustomerLdgEntry."Original Document Amount (LCY)";
            CustomerLdgEntry2."Original VAT Amount (LCY)":=CustomerLdgEntry."Original VAT Amount (LCY)";
            CustomerLdgEntry2."Open Amount (LCY) w/o Unreal.":=CustomerLdgEntry."Open Amount (LCY) w/o Unreal.";
            CustomerLdgEntry2.INSERT;
            CustomerLdgEntry.DELETE;
        */
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnAfterInitCustLedgEntry(var CustLedgerEntry : Record "Cust. Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    var
    begin

    end;

   [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
   local procedure OnAfterInitGLEntry(var GLEntry : Record "G/L Entry";GenJournalLine : Record "Gen. Journal Line")
   var
   begin

   end;


   [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertVAT', '', false, false)]
   local procedure OnAfterInsertVAT(var GenJournalLine : Record "Gen. Journal Line";VAR VATEntry : Record "VAT Entry";VAR UnrealizedVAT : Boolean;VAR AddCurrencyCode : Code[10])
   var 
   begin
       
   end;

}
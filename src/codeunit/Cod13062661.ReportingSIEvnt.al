codeunit 13062661 "Reporting SI Evnt."
{
    [EventSubscriber(ObjectType::Codeunit,12,'OnBeforeInsertGlobalGLEntry','',false,false)]
    local procedure GLEntryInsert(VAR GlobalGLEntry : Record "G/L Entry";GenJournalLine : Record "Gen. Journal Line")
    var
      GLAcc: Record "G/L Account";      
    begin
        if GLAcc.GET(GlobalGLEntry."G/L Account No.") then begin
          if GLAcc."FAS Account" then begin
            case GLAcc."FAS Instrument Posting" of
              GLAcc."FAS Instrument Posting"::" ":
                begin
                  GlobalGLEntry."FAS Instrument Code" := GenJournalLine."FAS Instrument Code";
                  GlobalGLEntry."FAS Sector Code" := GenJournalLine."FAS Sector Code";
                end;
              GLAcc."FAS Instrument Posting"::"Code Mandatory":
                begin
                  GenJournalLine.TestField("FAS Instrument Code");
                  GenJournalLine.TestField("FAS Sector Code");
                  GlobalGLEntry."FAS Instrument Code" := GenJournalLine."FAS Instrument Code";
                  GlobalGLEntry."FAS Sector Code" := GenJournalLine."FAS Sector Code";                  
                end;
              GLAcc."FAS Instrument Posting"::"Same Code":
                begin
                  GlobalGLEntry."FAS Instrument Code" := GLAcc."FAS Instrument Code";
                  GlobalGLEntry."FAS Sector Code" := GLAcc."FAS Sector Code";
                end;
              GLAcc."FAS Instrument Posting"::"No Code":
                begin
                  GenJournalLine.TestField("FAS Instrument Code",'');
                  GenJournalLine.TestField("FAS Sector Code",'');
                end;
            end;

            GlobalGLEntry."BST Code" := GLAcc."BST Code";
          end;
        end;      
    end;

    [EventSubscriber(ObjectType::Codeunit,12,'OnAfterInitCustLedgEntry','', false, false)]
    local procedure CustLedgEntryInsert(VAR CustLedgerEntry : Record "Cust. Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    var
      Cust:Record Customer;
      CustPstgGrp:Record "Customer Posting Group";

    begin
      if Cust.get(CustLedgerEntry."Customer No.") then begin
        CustLedgerEntry."KRD Country/Region Code" := Cust."Country/Region Code";
        CustLedgerEntry."FAS Sector Code" := Cust."FAS Sector Code";
        CustLedgerEntry."KRD Non-Residnet Sector Code" := Cust."KRD Non-Residnet Sector Code";
      end;

      if CustPstgGrp.get(CustLedgerEntry."Customer Posting Group") then begin
        CustLedgerEntry."KRD Instrument Type" := CustPstgGrp."KRD Instrument Type";
        CustLedgerEntry."KRD Affiliation Type" := CustPstgGrp."KRD Affiliation Type";
        CustLedgerEntry."KRD Claim/Liability" := CustPstgGrp."KRD Claim/Liability";
        CustLedgerEntry."KRD Maturity" := CustPstgGrp."KRD Maturity";
      end;
      
    end;

    [EventSubscriber(ObjectType::Codeunit,12,'OnAfterInitVendLedgEntry','', false, false)]
    local procedure VendLedgEntryInsert(VAR VendorLedgerEntry : Record "Vendor Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
    var
      Vend:Record Vendor;
      VendPstgGrp:Record "Vendor Posting Group";

    begin
      if Vend.get(VendorLedgerEntry."Vendor No.") then begin
        VendorLedgerEntry."KRD Country/Region Code" := Vend."Country/Region Code";
        VendorLedgerEntry."FAS Sector Code" := Vend."FAS Sector Code";
        VendorLedgerEntry."KRD Non-Residnet Sector Code" := Vend."FAS Non-Residnet Sector Code";
      end;

      if VendPstgGrp.get(VendorLedgerEntry."Vendor Posting Group") then begin
        VendorLedgerEntry."KRD Instrument Type" := VendPstgGrp."KRD Instrument Type";
        VendorLedgerEntry."KRD Affiliation Type" := VendPstgGrp."KRD Affiliation Type";
        VendorLedgerEntry."KRD Claim/Liability" := VendPstgGrp."KRD Claim/Liability";
        VendorLedgerEntry."KRD Maturity" := VendPstgGrp."KRD Maturity";
      end;
      
    end;    

    [EventSubscriber(ObjectType::Table,81,'OnAfterAccountNoOnValidateGetCustomerAccount','',false,false)]
    local procedure GETFASFromCust(VAR GenJournalLine : Record "Gen. Journal Line";VAR Customer : Record Customer)
    
    begin
      GenJournalLine."FAS Sector Code" := Customer."FAS Sector Code";
    end;

    [EventSubscriber(ObjectType::Table,81,'OnAfterAccountNoOnValidateGetVendorAccount','',false,false)]
    local procedure GETFASFromVend(VAR GenJournalLine : Record "Gen. Journal Line";VAR Vendor : Record Vendor)
    
    begin
      GenJournalLine."FAS Sector Code" := Vendor."FAS Sector Code";
    end;

    [EventSubscriber(ObjectType::Table,81,'OnAfterAccountNoOnValidateGetBankAccount','',false,false)]
    local procedure GETFASFromBank(VAR GenJournalLine : Record "Gen. Journal Line";VAR BankAccount : Record "Bank Account")
    
    begin
      GenJournalLine."FAS Sector Code" := BankAccount."FAS Sector Code";
    end;    

    
}
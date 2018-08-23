codeunit 50100 "Reporting SI Mgt."
{
    trigger OnRun()
    begin
    end;
  
    [EventSubscriber(ObjectType::Codeunit,12,'OnBeforeInsertGlobalGLEntry','',false,false)]
    local procedure PostFAS(VAR GlobalGLEntry : Record "G/L Entry";GenJournalLine : Record "Gen. Journal Line")
    var
      GLAcc: Record "G/L Account";      
    begin
        if GLAcc.GET(GenJournalLine."Account No.") then begin
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
          end;
        end;      
    end;
}
codeunit 13062571 "ForceCreditDebit-Adl"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    local procedure CheckDebitCredit(TempGLEntryBuf: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line");
    var
        GLAccount: Record "G/L Account";
    begin
        with GLAccount do begin
            Get(TempGLEntryBuf."G/L Account No.");
            if "Debit/Credit" = "Debit/Credit"::Both then
                exit;

            IF ClosingDate(TempGLEntryBuf."Posting Date") = TempGLEntryBuf."Posting Date" then
                case "Debit/Credit" OF
                    "Debit/Credit"::Debit : "Debit/Credit" := "Debit/Credit"::Credit;
                    "Debit/Credit"::Credit : "Debit/Credit" := "Debit/Credit"::Debit;
                end;

            case "Debit/Credit" OF
                "Debit/Credit"::Debit :
                    begin
                        TempGLEntryBuf."Debit Amount" := TempGLEntryBuf.Amount;
                        TempGLEntryBuf."Credit Amount" := 0;
                        TempGLEntryBuf."Add.-Currency Debit Amount" := TempGLEntryBuf."Additional-Currency Amount";
                        TempGLEntryBuf."Add.-Currency Credit Amount" := 0;
                    end;
                "Debit/Credit"::Credit :
                    begin
                        TempGLEntryBuf."Debit Amount" := 0;
                        TempGLEntryBuf."Credit Amount" := -TempGLEntryBuf.Amount;
                        TempGLEntryBuf."Add.-Currency Debit Amount" := 0;
                        TempGLEntryBuf."Add.-Currency Credit Amount" := -TempGLEntryBuf."Additional-Currency Amount";
                    end;
                end;
            end;
    end;
}
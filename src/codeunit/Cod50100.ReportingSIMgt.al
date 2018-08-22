codeunit 50100 "Reporting SI Mgt."
{

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInsertGlobalGLEntry', '', false, false)]
    local procedure PostFAS(var GLEntry: Record "G/L Entry")
    var
        GLAcc: Record "G/L Account";
    begin
        if GLAcc.GET(GLEntry."G/L Account No.") then begin
          if GLAcc."FAS Account" then begin
            case GLAcc."FAS Instrument Posting" of
              GLAcc."FAS Instrument Posting"::" ":
                begin
                end;
              GLAcc."FAS Instrument Posting"::"Code Mandatory":
                begin
                end;
              GLAcc."FAS Instrument Posting"::"Same Code":
                begin
                end;
              GLAcc."FAS Instrument Posting"::"Same Code":
                begin
                end;
            end;
          end;
        end;
    end;
}


codeunit 50100 "TextWriter-adl"
{

    procedure Open(FieldDelimiter: text; RecordDelimiter: text);
    begin

    end;

    procedure Field(Value: variant);
    begin
    end;

    procedure FixedField(Value: variant; Length: integer);
    begin
    end;

    procedure NewLine();
    begin

    end;
    procedure Close();
    begin
    end;

    procedure Download(LocalFileName: text);
    begin
    end;




    procedure MethodName();
    var
        Handled : Boolean;
    begin
        OnBeforeMethodName(Handled);

        DoMethodName(Handled);

        OnAfterMethodName();
    end;

    local procedure DoMethodName(var Handled: Boolean);
    begin
        if Handled then
            exit;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMethodName(var Handled : Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMethodName();
    begin
    end;
}
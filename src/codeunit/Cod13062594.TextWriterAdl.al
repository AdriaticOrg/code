codeunit 13062594 "TextWriter-Adl"
{
    trigger OnRun()
    begin
    end;

    procedure Create(var OutStr: OutStream);
    begin
        TmpBlobTemp.Blob.CreateOutStream(outStr, TextEncoding::Windows);
    end;

    procedure Field(var OutStr: OutStream; Value: variant; FieldDelimiter: Text[1]);
    begin
        if (FieldDelimiter <> '') then
            OutStr.WriteText(FORMAT(Value) + FieldDelimiter)
        else
            OutStr.WriteText(FORMAT(Value));

    end;

    procedure FixedField(var OutStr: OutStream; Value: variant; Length: integer; PadCharacter: Text[1]; Justification: Option Right,Left; FIeldDelimiter: Text[1]);
    var
        TextVal: Text;
    begin
        if (Value.IsDate()) then
            TextVal := Format(Value, 0, '<day,2><month,2><year,4>')
        else
            if (Value.IsDecimal()) then
                TextVal := Format(Value, 0, '<Precision,2><Standard Format,9>')
            else
                TextVal := Format(Value);

        TextVal :=
           CopyStr(StringConversionManagement.GetPaddedString(
                CopyStr(TextVal, 1, 250),
                Length,
                PadCharacter,
                Justification),
            1,
            Length);

        if (FieldDelimiter <> '') then
            TextVal += FIeldDelimiter;
        OutStr.WriteText(TextVal);
    end;

    procedure NewLine(var OutStr: OutStream);
    var
        CRLF: Text[2];
    begin
        CRLF[1] := 13;
        CRLF[2] := 10;
        OutStr.WRITE(CRLF[1]);
        OutStr.WRITE(CRLF[2]);
    end;

    procedure Close();
    begin
    end;

    procedure Download(DialogTitle: Text; ToFilter: Text; FileName: Text);
    var
        InStr: InStream;
    begin
        TmpBlobTemp.Blob.CreateInStream(InStr, TextEncoding::Windows);
        File.DownloadFromStream(InStr, DialogTitle, '', ToFilter, FileName);
    end;

    procedure GetTempBlob(var TmpBlobTemp2: Record TempBlob)
    begin
        TmpBlobTemp := TmpBlobTemp2;
    end;

    var
        TmpBlobTemp: Record TempBlob temporary;
        StringConversionManagement: Codeunit StringConversionManagement;
}
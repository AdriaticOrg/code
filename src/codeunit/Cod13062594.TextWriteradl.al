codeunit 13062594 "TextWriter-adl"
{
    trigger OnRun()
    var
        OutStr: OutStream;
        FileName: Text;
        ToFilter: Text;
        DialogTitle: Text;
        PadCharacter: Text[1];
    begin
        /*START Test GL Export*/
        ToFilter:= '*.txt|*.TXT';
        FileName:= 'IZPIS GLAVNE KNJIGE.TXT';
        PadCharacter:= ' ';
        FieldDelimiter:= ';';

        Create(OutStr);        
        FixedField(OutStr, 'Value1.1', 10, PadCharacter, 0, FieldDelimiter);
        FixedField(OutStr, 1000, 20, PadCharacter, 0, FieldDelimiter);
        FixedField(OutStr, 'Value1.3', 30, PadCharacter, 0, FieldDelimiter);
        NewLine(OutStr);
        
        FixedField(OutStr, 'Value2.1', 10, PadCharacter, 0, FieldDelimiter);
        FixedField(OutStr, 1000, 20, PadCharacter, 0, FieldDelimiter);
        FixedField(OutStr, 'Value2.3', 30, PadCharacter, 0, FieldDelimiter);
        NewLine(OutStr);

        Download(DialogTitle, ToFilter, FileName);
        /*END Test GL Export*/
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

    procedure FixedField(var OutStr: OutStream; Value: variant; Length: integer; PadCharacter: Text[1]; Justification: Option Right, Left; FIeldDelimiter: Text[1]);
    var 
        TextVal: Text[250];
    begin
        if (Value.IsDate()) then
            TextVal:= Format(Value,0, '<day,2><month,2><year,2>')
        else if (Value.IsDecimal()) then 
            TextVal:= Format(Value, 0, '<Precision,2><Standard Format,9>')
        else
            TextVal:= Format(Value);    

        TextVal:= 
            StringConversionManagement.GetPaddedString(
                TextVal,
                Length,
                PadCharacter,
                Justification); 

        if (FieldDelimiter <> '') then
            TextVal+= FIeldDelimiter;
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
        //TODO:: (if needed)
    end;

    procedure Download(DialogTitle: Text; ToFilter: Text; FileName: Text);
    var
        InStr: InStream;
        ExpOk: Boolean;
    begin
        TmpBlobTemp.Blob.CreateInStream(InStr, TextEncoding::Windows);
        File.DownloadFromStream(InStr, DialogTitle, '', ToFilter, FileName);
        IsDownloadedsucceed:= File.DownloadFromStream(InStr, DialogTitle, '', ToFilter, FileName);
        IF IsDownloadedsucceed then
            Message(Msg001, FileName);
    end;

    procedure GetTempBlob(var TmpBlobTemp2: Record TempBlob)
    begin
        TmpBlobTemp:= TmpBlobTemp2;
    end;


    var 
        TmpBlobTemp: Record TempBlob temporary;
        FileMgt:Codeunit "File Management";
        StringConversionManagement: Codeunit StringConversionManagement;
        IsDownloadedsucceed: Boolean;
        Msg001:Label 'File %1 was succesfully prepared.';
        FieldDelimiter: Text[1];

}
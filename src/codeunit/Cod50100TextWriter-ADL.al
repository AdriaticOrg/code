codeunit 50100 "TextWriter-adl"
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

        Create(OutStr);        
        FixedField(OutStr, 'Value1.1', 10, PadCharacter, 0);
        FixedField(OutStr, 1000, 20, PadCharacter, 0);
        FixedField(OutStr, 'Value1.3', 30, PadCharacter, 0);
        NewLine(OutStr);
        
        FixedField(OutStr, 'Value2.1', 10, PadCharacter, 0);
        FixedField(OutStr, 1000, 20, PadCharacter, 0);
        FixedField(OutStr, 'Value2.3', 30, PadCharacter, 0);
        NewLine(OutStr);

        Download(DialogTitle, ToFilter, FileName);
        /*END Test GL Export*/
    end;

    procedure Create(var OutStr: OutStream);
    begin 
        TmpBlobTemp.Blob.CreateOutStream(outStr, TextEncoding::Windows);
    end;

    procedure Field(var OutStr: OutStream; Value: variant);
    begin     
        OutStr.WriteText(FORMAT(Value)); 
    end;

    procedure FixedField(var OutStr: OutStream; Value: variant; Length: integer; PadCharacter: Text[1]; Justification: Option Right, Left);
    var 
        TextVal: Text[250];
    begin
        TextVal:= FORMAT(Value); 
        OutStr.WriteText(
            StringConversionManagement.GetPaddedString(
                TextVal,
                Length,
                PadCharacter,
                Justification)); 
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
        TmpBlobTemp.Blob.CreateInStream(InStr, TextEncoding::UTF8);
        File.DownloadFromStream(InStr, DialogTitle, '', ToFilter, FileName);
        ExpOk := File.DownloadFromStream(InStr, DialogTitle, '', ToFilter, FileName);
        IF ExpOk then
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
        ExpOk: Boolean;
        Msg001:Label 'Export to %1';

}
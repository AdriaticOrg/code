report 50102 "Export FAS"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Export FAS';
    
    dataset
    {
        dataitem("FAS Report Header"; "FAS Report Header")
        {
            RequestFilterFields = "No.";
            trigger OnPostDataItem()
            begin
                ExportFAS();                
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(ExpFile; ExpFile)
                    {
                        Caption = 'Export File';
                        ApplicationArea = All;                        
                    }
                    field(ExpFileName;ExpFileName) {
                        Caption = 'Export File Name';
                        ApplicationArea = All;
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }

    var
        ExpFile:Boolean;
        ExpFileName:Text[500];
        Msg001:TextConst ENU='Export to %1 done OK.';

    local procedure ExportFAS()
    var
        FileMgt:Codeunit "File Management";
        XmlDoc:XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: XmlElement;
        XmlElem2: XmlElement;                            
        OutStr:OutStream;
        InStr:InStream;
        TmpBlob:Record TempBlob temporary;
        FileName: Text; 
        ExpOk: Boolean;    
    begin
        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem := xmlElement.Create('root');
        XmlElem.SetAttribute('release', '2.1');

        XmlElem2 := XmlElement.Create('FirstNode');
        XmlElem2.Add(xmlText.Create('Max'));

        XmlElem.Add(xmlElem2);
        XmlDoc.Add(xmlElem);

        // Create an out stream from the blob, notice the encoding.
        TmpBlob.Blob.CreateOutStream(outStr, TextEncoding::UTF8);
        // Write the contents of the doc to the stream
        xmlDoc.WriteTo(outStr);
        // From the same blob, that now contains the xml document, create an instr
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);
    
        // Save the data of the InStream as a file.
        //ExpOk :=File.DownloadFromStream(InStr, 'Export To File', '', '*.xml|*.XML', FileName);   
        ExpOk := File.DownloadFromStream(InStr,'Save To File','','All Files (*.*)|*.*',FileName);   

        FileName := 'fajl.xml';
        Message(Msg001,FileName);

        /*TempFile.CREATETEMPFILE();  
        TempFile.WRITE('abc');  
        TempFile.CREATEINSTREAM(NewStream);  
        ToFileName := 'SampleFile.txt';  
        DOWNLOADFROMSTREAM(NewStream,'Export','','All Files (*.*)|*.*',ToFileName) 
        */

    end;

}
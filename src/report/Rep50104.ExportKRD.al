report 50104 "Export KRD"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Export KRD';
    
    dataset
    {
        dataitem("KRD Report Header"; "KRD Report Header")
        {
            RequestFilterFields = "No.";
            trigger OnPostDataItem()
            begin
                ExportKRD("KRD Report Header");                
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
                        Visible = false;                     
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
        Msg001:TextConst ENU='Export to %1 done OK.';

    local procedure ExportKRD(KRDRepHead:Record "KRD Report Header")
    var
        KRDRepLine:Record "KRD Report Line";
        CompanyInfo:Record "Company Information";
        XmlDoc:XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: array[10] of XmlElement;
        XmlAttr:XmlAttribute;
        OutStr:OutStream;
        InStr:InStream;
        TmpBlob:Record TempBlob temporary;
        FileName: Text; 
        ExpOk: Boolean;  
        xbsrns:Text; 
        CurrDT:DateTime;
        MsgId:Text;    
        SysVersion:Text[20]; 
    begin
        CompanyInfo.get();
        CompanyInfo.TestField("Registration No.");
        CompanyInfo.TestField("VAT Registration No.");

        CurrDT := CREATEDATETIME(TODAY,TIME);
        MsgId := CompanyInfo."VAT Registration No." + FORMAT(CurrDT,0,'<Year4><Month,2><Day,2><Hours24,2><Filler Character,0><Minutes,2><Seconds,2><Second dec>');

        xbsrns := 'http://www.bsi.si/2014/07/BSReport';
        SysVersion := '2.0.18.0'; 

        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create('BS_Report',xbsrns);
        XmlDoc.Add(xmlElem[1]);
        
        XmlElem[2] := XmlElement.Create('Header',xbsrns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('SenderMessageId',xbsrns);
        XmlElem[3].Add(XmlText.Create(MsgId));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('SendingDateTime',xbsrns);  
        XmlElem[3].Add(XmlText.Create(FORMAT(CurrDT,0,'<Year4>-<Month,2>-<Day,2>T<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')));      
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('SystemVersion',xbsrns);
        XmlElem[3].Add(XmlText.Create(SysVersion));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('ApplicationType',xbsrns);
        XmlElem[3].Add(XmlText.Create('P'));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('Sender',xbsrns);
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[4] := XmlElement.Create('CodeAJPES',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Registration No."));
        XmlElem[3].Add(XmlElem[4]);        

        XmlElem[4] := XmlElement.Create('TaxCode',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."VAT Registration No."));
        XmlElem[3].Add(XmlElem[4]);        


        //export file part
        TmpBlob.Blob.CreateOutStream(outStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(outStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);
    
        FileName := 'krd_' + format(KRDRepHead."No.") + '.xml'; 
        ExpOk := File.DownloadFromStream(InStr,'Save To File','','All Files (*.*)|*.*',FileName);   

        Message(Msg001,FileName);    

    end;
}
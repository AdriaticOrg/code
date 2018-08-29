report 13062642 "Export FAS"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Export FAS';
    
    dataset
    {
        dataitem("FAS Report Header"; "FAS Report Header")
        {
            RequestFilterFields = "No.";
            trigger OnPostDataItem()
            begin
                ExportFAS("FAS Report Header");                
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
        RepSISetup:Record "Reporting_SI Setup";
        CompanyInfo:Record "Company Information";
        RespUserSetup:Record "User Setup";
        MngUserSetup:Record "User Setup";
        Msg001:Label 'Export to %1 done OK.';
        Msg002:Label 'Sheet 1 and 2 must have positive amounts. FAS Reporting Line sum for AOP %1 (%2) is %3. Filters:\\%4';
        

    local procedure ExportFAS(FASRepHead:Record "FAS Report Header")
    var
        RepSIMgt:Codeunit "Reporting SI Mgt.";
        FinSect:Record "FAS Sector";
        FinInst:Record "FAS Instrument";
        FASRepLine:Record "FAS Report Line";
        XmlDoc:XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: array[10] of XmlElement;
        XmlAttr:XmlAttribute;
        OutStr:OutStream;
        InStr:InStream;
        TmpBlob:Record TempBlob temporary;
        FileName: Text; 
        ExpOk: Boolean; 
        i:Integer;   
        j:Integer;
        k:Integer;
        aop:Integer;
        curraop:Integer;
        FormNum:Integer;
        StatId:text[10];
        Values:array[700,23] of decimal;
        WarningStr:Text;

    begin
        FASRepHead.TestField("Period Year");
        FASRepHead.TestField("Period Round");        

        RespUserSetup.get(FASRepHead."Resp. User ID");
        RespUserSetup.TestField("Reporting_SI Name");
        RespUserSetup.TestField("Reporting_SI Email");
        RespUserSetup.TestField("Reporting_SI Phone");    

        RepSISetup.get;
        RepSISetup.TestField("Budget User Code");
        RepSISetup.TestField("Company Sector Code");

        MngUserSetup.get(RepSISetup."FAS Director User ID"); 
        MngUserSetup.TestField("Reporting_SI Name");       

        CompanyInfo.get;
        CompanyInfo.TestField("Registration No.");
        CompanyInfo.TestField("VAT Registration No.");
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField(Address);
        CompanyInfo.TestField(City);

        FASRepLine.SetRange("Document No.",FASRepHead."No.");
        for FormNum := 1 to 6 do begin
            FinInst.Reset();
            FinInst.SetFilter("AOP Code",'<>%1','');
            if FinInst.FindSet() then begin
                repeat
                    EVALUATE(curraop,FinInst."AOP Code");
                    IF (curraop < 100) OR (curraop > 127 ) THEN
                        FinInst.FieldError("AOP Code");            
                    curraop += (FormNum - 1) * 100;

                    FinSect.Reset();
                    FinSect.SetFilter("AOP Code",'<>%1','');
                    if FinSect.FindSet() then begin
                        repeat
                            IF FinInst.Type = FinInst.Type::Posting THEN
                            FASRepLine.SETRANGE("Instrument Code", FinInst.Code)
                            ELSE
                            FASRepLine.SETFILTER("Instrument Code", FinInst.Totaling);

                            IF FinSect.Type = FinSect.Type::Posting THEN
                            FASRepLine.SETRANGE("Sector Code", FinSect.Code)
                            ELSE
                            FASRepLine.SETFILTER("Sector Code", FinSect.Totaling);

                            FASRepLine.CALCSUMS(Amount);
                            IF FormNum IN [2, 4, 5, 6] THEN
                            FASRepLine.Amount *= -1;

                            EVALUATE(i, FinSect."AOP Code");
                            IF (i > 23) OR (i < 1) THEN
                            FinSect.FIELDERROR("AOP Code");

                            Values[currAOP][i] += FASRepLine.Amount;

                            IF (curraop >= 100) AND (curraop < 299) AND (FASRepLine.Amount < 0) THEN                                
                                WarningStr += StrSubstNo(Msg002, currAOP, i, FASRepLine.Amount, FASRepLine.GETFILTERS);                                                        
                            
                        until FinSect.Next() = 0;
                    end;

                until FinInst.Next() = 0;
            end;
        end;

        if WarningStr <> '' then
            Message(WarningStr);

        XmlDoc := xmlDocument.Create();
        //XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDec := XmlDeclaration.Create('1.0','WINDOWS-1250','');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create('AjpesDokument');
        XmlDoc.Add(xmlElem[1]);
        
        // find a way to add namespaced nodes, bellow code doesn't work!

        //XmlAttr := XmlAttribute.Create('xmlns','http://www.w3.org/2001/XMLSchema-instance');
        //XmlElem[1].Add(XmlAttr);
        //XmlElem[1].SetAttribute('xmlns','http://www.w3.org/2001/XMLSchema-instance');
        
        XmlElem[2] := XmlElement.Create('Ident');
        XmlElem[1].Add(xmlElem[2]);
        XmlAttr := XmlAttribute.Create('krog',format(FASRepHead."Period Round"));
        XmlElem[2].Add(XmlAttr);
        XmlAttr := XmlAttribute.Create('Vrsta','sfr_' + FORMAT(DATE2DMY(FASRepHead."Period End Date",3)));
        XmlElem[2].Add(XmlAttr);        

        XmlElem[3] := XmlElement.Create('Datum');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].Add(xmlText.Create(FORMAT(WORKDATE,0,9)));
        
        XmlElem[3] := XmlElement.Create('Ura');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(FORMAT(TIME, 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')));
                        
        XmlElem[2] := XmlElement.Create('OsnoviPodatki');
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('SifUpor');
        XmlElem[2].Add(XmlElem[3]);  
        XmlElem[3].add(XmlText.Create(RepSISetup."Budget User Code"));      

        XmlElem[3] := XmlElement.Create('MaticnaStevilka10');
        XmlElem[2].Add(XmlElem[3]); 
        XmlElem[3].add(XmlText.Create(PADSTR(CompanyInfo."Registration No.", 10, '0')));

        XmlElem[3] := XmlElement.Create('DavcnaStevilka');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(RepSIMgt.GetNumsFromStr(CompanyInfo."VAT Registration No.")));

        XmlElem[3] := XmlElement.Create('Sektor');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(RepSIMgt.GetNumsFromStr(RepSISetup."Company Sector Code")));                

        XmlElem[3] := XmlElement.Create('Ime');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(CompanyInfo.Name)); 

        XmlElem[3] := XmlElement.Create('Sedez');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(STRSUBSTNO('%1 %2 %3', CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo.City)));

        XmlElem[3] := XmlElement.Create('OdgovornaOseba');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(RespUserSetup."Reporting_SI Name")); 

        XmlElem[3] := XmlElement.Create('TelefonskaStevilka');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create( RespUserSetup."Reporting_SI Phone"));

        XmlElem[3] := XmlElement.Create('Email');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(RespUserSetup."Reporting_SI Email"));

        XmlElem[3] := XmlElement.Create('VodjaPodjetja');
        XmlElem[2].Add(XmlElem[3]);  
        XmlElem[3].add(XmlText.Create(MngUserSetup."Reporting_SI Name"));

        XmlElem[3] := XmlElement.Create('Datum');        
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(FORMAT(WORKDATE,0,9)));

        XmlElem[3] := XmlElement.Create('Kraj');
        XmlElem[2].Add(XmlElem[3]);   
        XmlElem[3].add(XmlText.Create(CompanyInfo.City));

        XmlElem[2] := XmlElement.Create('Obrazci');
        XmlElem[1].Add(xmlElem[2]);    

        for i := 1 to 6 do begin
            XmlElem[3] := XmlElement.Create('Obrazec');
            XmlElem[2].Add(XmlElem[3]);
            XmlAttr := XmlAttribute.Create('krog',format(FASRepHead."Period Round"));
            XmlElem[3].Add(XmlAttr); 

            case i of
                1: StatId := 'sfr';
                2: StatId := 'sob';
                3: StatId := 'trs';
                4: StatId := 'tob';
                5: StatId := 'vsfr';
                6: StatId := 'vsob';
            END;            
            XmlAttr := XmlAttribute.Create('id',StatId);
            XmlElem[3].Add(XmlAttr);  

            for j := 0 to 27 do begin
                aop := i * 100 + j;
                XmlElem[4] := XmlElement.Create('Aop');
                XmlElem[3].Add(XmlElem[4]);     
                XmlAttr := XmlAttribute.Create('id',Format(aop));
                XmlElem[4].Add(XmlAttr);

                for k := 1 to 22 do begin
                    XmlElem[5] := XmlElement.Create('P');
                    XmlElem[5].Add((XmlText.Create(FORMAT(Values[aop][k], 0, '<Precision,2:2><Standard Format,9>'))));
                    XmlElem[4].Add(XmlElem[5]);                    
                    XmlAttr := XmlAttribute.Create('s',Format(k));
                    XmlElem[5].Add(XmlAttr);
                end;
            end;                        
        end;         

        // Create an out stream from the blob, notice the encoding.
        TmpBlob.Blob.CreateOutStream(outStr, TextEncoding::UTF8);
        // Write the contents of the doc to the stream
        xmlDoc.WriteTo(outStr);
        // From the same blob, that now contains the xml document, create an instr
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);
    
        // Save the data of the InStream as a file.
        //ExpOk :=File.DownloadFromStream(InStr, 'Export To File', '', '*.xml|*.XML', FileName);  
        FileName := 'fas_' + format(FASRepHead."Period Year") + '_' + format(FASRepHead."Period Round") + '.xml'; 
        ExpOk := File.DownloadFromStream(InStr,'Save To File','','All Files (*.*)|*.*',FileName);   

        Message(Msg001,FileName);

        /*TempFile.CREATETEMPFILE();  
        TempFile.WRITE('abc');  
        TempFile.CREATEINSTREAM(NewStream);  
        ToFileName := 'SampleFile.txt';  
        DOWNLOADFROMSTREAM(NewStream,'Export','','All Files (*.*)|*.*',ToFileName) 
        */
    end;

}
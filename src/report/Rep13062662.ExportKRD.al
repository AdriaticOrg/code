report 13062662 "Export KRD"
{
    UsageCategory = Administration;
    RDLCLayout = './src/reportlayout/Rep13062662.ExportKRD.rdlc';
    Caption = 'Export KRD';
    
    dataset
    {
        dataitem(KRDReportHeader;"KRD Report Header")
        {
            RequestFilterFields = "No.";

            column(CompanyName;CompanyInfo.Name){}
            column(DocumentNo;KRDReportHeader."No."){
                IncludeCaption = true;
            }
            column(PeriodStart;KRDReportHeader."Period Start Date"){
                IncludeCaption = true;
            }
            column(PeriodEnd;KRDReportHeader."Period End Date"){
                IncludeCaption = true;
            }   

            dataitem(KRDReportLine;"KRD Report Line") {
                DataItemLink = "Document No." = field("No.");

                column(LineNo;KRDReportLine."Line No"){}
                column(ClaimLiability;format(KRDReportLine."Claim/Liability",0,'<Number>')){}
                column(InstrumentType;KRDReportLine."Instrument Type"){
                    IncludeCaption = true;
                }
                column(AffiliationType;KRDReportLine."Affiliation Type"){
                    IncludeCaption = true;
                }
                column(NonResidentSectorCode;KRDReportLine."Non-Residnet Sector Code"){
                    IncludeCaption = true;
                }
                column(Maturity;KRDReportLine.Maturity){
                    IncludeCaption = true;
                }
                column(CountryRegionCode;KRDReportLine."Country/Region Code"){
                    IncludeCaption = true;
                }
                column(CountryRegionNo;KRDReportLine."Country/Region No."){
                    IncludeCaption = true;
                }
                column(CurrencyCode;KRDReportLine."Currency Code"){
                    IncludeCaption = true;}
                column(CurrencyNo;KRDReportLine."Currency No."){
                    IncludeCaption = true;
                }
                column(OpeningBalance;KRDReportLine."Opening Balance"){
                    IncludeCaption = true;
                }
                column(IncreaseAmount;KRDReportLine."Increase Amount"){
                    IncludeCaption = true;
                }
                column(DecreaseAmount;KRDReportLine."Decrease Amount"){
                    IncludeCaption = true;
                }
                column(ClosingBalance;KRDReportLine."Closing Balance"){
                    IncludeCaption = true;
                }
                column(OtherChanges;KRDReportLine."Other Changes"){
                    IncludeCaption = true;
                }
            }

            trigger OnPostDataItem()
            begin
                if ExpFile then begin
                    ExportKRD(KRDReportHeader); 
                    KRDReportHeader.ReleaseReopen(0); 
                end;              
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
                        Visible = true;                     
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

    labels {
        LblReportTitle = 'KRD Report';
        LblPage = 'Page';
        LblFilters= 'Filters:';
        LblClaims= 'Claims';
        LblLiability='Liabilities';
        LblSectorCode='Sector Code';
        LblCountryCode='Country Code';

    }
    var
        ExpFile:Boolean;
        CompanyInfo:Record "Company Information";
        Msg001:Label 'Export to %1 done OK.';

    local procedure ExportKRD(KRDRepHead:Record "KRD Report Header")
    var
        RepSIMgt:Codeunit "Reporting SI Mgt.";
        KRDRepLine:Record "KRD Report Line";
        CompanyInfo:Record "Company Information";
        RespUser:Record "User Setup";
        MakerUser:Record "User Setup";
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
        Street:Text[200];
        HouseNo:Text[100];
        StatMonth:Integer;
        StatYear:Integer;  
        LineCntr:Integer;  
        ClaimLiabStr:Text[10]; 
        TxtPrec:Label '<Precision,2:2><Standard Format,9>';  
    begin
        CompanyInfo.get();
        CompanyInfo.TestField("Registration No.");
        CompanyInfo.TestField("VAT Registration No.");
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField(Address);
        CompanyInfo.TestField("Post Code");
        CompanyInfo.TestField(City);

        KRDRepHead.TestField("Period Start Date");

        RepSIMgt.GetUser(RespUser,KRDRepHead."Resp. User ID");
        RepSIMgt.GetUser(MakerUser,KRDRepHead."Prep. By User ID");

        RepSIMgt.SplitAddress(CompanyInfo.Address + CompanyInfo."Address 2",Street,HouseNo);

        StatMonth := DATE2DMY(KRDRepHead."Period Start Date",2);
        StatYear := DATE2DMY(KRDRepHead."Period Start Date",3);        

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

        XmlElem[4] := XmlElement.Create('CompanyName',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Name));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('Street',xbsrns);
        XmlElem[4].Add(XmlText.Create(Street));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('HouseNo',xbsrns);
        XmlElem[4].Add(XmlText.Create(HouseNo));
        XmlElem[3].Add(XmlElem[4]);   

        XmlElem[4] := XmlElement.Create('PostCode',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Post Code"));
        XmlElem[3].Add(XmlElem[4]);       

        XmlElem[4] := XmlElement.Create('City',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.City));
        XmlElem[3].Add(XmlElem[4]);    

        XmlElem[3] := XmlElement.Create('Reporter',xbsrns);
        XmlElem[2].Add(XmlElem[3]);  

        XmlElem[4] := XmlElement.Create('CodeAJPES',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Registration No."));
        XmlElem[3].Add(XmlElem[4]);        

        XmlElem[4] := XmlElement.Create('TaxCode',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."VAT Registration No."));
        XmlElem[3].Add(XmlElem[4]);        

        XmlElem[4] := XmlElement.Create('CompanyName',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Name));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('Street',xbsrns);
        XmlElem[4].Add(XmlText.Create(Street));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('HouseNo',xbsrns);
        XmlElem[4].Add(XmlText.Create(HouseNo));
        XmlElem[3].Add(XmlElem[4]);   

        XmlElem[4] := XmlElement.Create('PostCode',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Post Code"));
        XmlElem[3].Add(XmlElem[4]);       

        XmlElem[4] := XmlElement.Create('City',xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.City));
        XmlElem[3].Add(XmlElem[4]);  
        
        XmlElem[2] := XmlElement.Create('SMO',xbsrns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('KRD_Report',xbsrns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('ReportHeader',xbsrns);
        XmlElem[3].Add(xmlElem[4]);   

        XmlElem[5] := XmlElement.Create('Period',xbsrns);
        XmlElem[4].Add(xmlElem[5]);               

        XmlElem[6] := XmlElement.Create('Year',xbsrns);
        XmlElem[6].Add(XmlText.Create(format(StatYear)));
        XmlElem[5].Add(xmlElem[6]);  

        XmlElem[6] := XmlElement.Create('Month',xbsrns);
        XmlElem[6].Add(XmlText.Create(format(StatMonth)));
        XmlElem[5].Add(xmlElem[6]); 

        XmlElem[5] := XmlElement.Create('ResponsiblePerson',xbsrns);
        XmlElem[4].Add(xmlElem[5]);                   

        XmlElem[6] := XmlElement.Create('PersonalData',xbsrns);
        XmlElem[5].Add(xmlElem[6]);    

        XmlElem[7] := XmlElement.Create('Name',xbsrns);
        XmlElem[6].Add(xmlElem[7]);  
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Name"));

        XmlElem[7] := XmlElement.Create('Email',xbsrns);
        XmlElem[6].Add(xmlElem[7]);  
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Email")); 

        XmlElem[7] := XmlElement.Create('Telephon',xbsrns);
        XmlElem[6].Add(xmlElem[7]);  
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Phone"));  

        XmlElem[7] := XmlElement.Create('Position',xbsrns);
        XmlElem[6].Add(xmlElem[7]);  
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Position"));  

        XmlElem[5] := XmlElement.Create('ReportMaker',xbsrns);
        XmlElem[4].Add(xmlElem[5]);                             

        XmlElem[6] := XmlElement.Create('Name',xbsrns);
        XmlElem[5].Add(xmlElem[6]);  
        XmlElem[6].Add(XmlText.Create(RespUser."Reporting_SI Name"));

        XmlElem[6] := XmlElement.Create('Email',xbsrns);
        XmlElem[5].Add(xmlElem[6]);  
        XmlElem[6].Add(XmlText.Create(RespUser."Reporting_SI Email")); 

        XmlElem[6] := XmlElement.Create('Telephon',xbsrns);
        XmlElem[5].Add(xmlElem[6]);  
        XmlElem[6].Add(XmlText.Create(RespUser."Reporting_SI Phone")); 

        XmlElem[4] := XmlElement.Create('ReportSpecifications',xbsrns);
        XmlElem[3].Add(xmlElem[4]);      

        KRDReportLine.Reset();
        KRDReportLine.SetRange("Document No.",KRDRepHead."No.");
        if KRDReportLine.FindSet() then begin
            repeat
                LineCntr += 1;

                XmlElem[5] := XmlElement.Create('Specification',xbsrns);
                XmlElem[4].Add(xmlElem[5]);    

                XmlElem[6] := XmlElement.Create('SerialNo',xbsrns);
                XmlElem[5].Add(xmlElem[6]);    
                XmlElem[6].Add(XmlText.Create(Format(LineCntr)));       

                XmlElem[6] := XmlElement.Create('ClaimOrLiability',xbsrns);
                XmlElem[5].Add(xmlElem[6]);    
                case KRDReportLine."Claim/Liability" of
                    KRDReportLine."Claim/Liability"::Claim: ClaimLiabStr := 'T';
                    KRDReportLine."Claim/Liability"::Liability: ClaimLiabStr := 'O';
                end;
                XmlElem[6].Add(XmlText.Create(ClaimLiabStr));  

                XmlElem[6] := XmlElement.Create('InstrumentType',xbsrns);
                XmlElem[5].Add(xmlElem[6]);  
                XmlElem[6].Add(XmlText.Create(KRDReportLine."Instrument Type"));   

                XmlElem[6] := XmlElement.Create('AffiliationType',xbsrns);
                XmlElem[5].Add(xmlElem[6]);  
                XmlElem[6].Add(XmlText.Create(KRDReportLine."Affiliation Type"));    

                XmlElem[6] := XmlElement.Create('Sector',xbsrns);
                XmlElem[5].Add(xmlElem[6]);  
                XmlElem[6].Add(XmlText.Create(KRDReportLine."Non-Residnet Sector Code"));  

                XmlElem[6] := XmlElement.Create('Maturity',xbsrns);
                XmlElem[5].Add(xmlElem[6]);  
                XmlElem[6].Add(XmlText.Create(KRDReportLine.Maturity));       

                XmlElem[6] := XmlElement.Create('Country',xbsrns);
                XmlElem[5].Add(xmlElem[6]);  
                XmlElem[6].Add(XmlText.Create(format(KRDReportLine."Country/Region No."))); 

                XmlElem[6] := XmlElement.Create('Currency',xbsrns);
                XmlElem[5].Add(xmlElem[6]);  
                XmlElem[6].Add(XmlText.Create(KRDReportLine."Currency Code"));  

                XmlElem[6] := XmlElement.Create('Principal',xbsrns);
                XmlElem[5].Add(xmlElem[6]);    

                XmlElem[7] := XmlElement.Create('OpeningBalance',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(KRDReportLine."Opening Balance",0,TxtPrec))); 

                XmlElem[7] := XmlElement.Create('Increase',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(KRDReportLine."Increase Amount",0,TxtPrec)));  

                XmlElem[7] := XmlElement.Create('Decrease',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(KRDReportLine."Decrease Amount",0,TxtPrec))); 

                XmlElem[7] := XmlElement.Create('OtherChanges',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(KRDReportLine."Other Changes",0,TxtPrec)));                 

                XmlElem[7] := XmlElement.Create('ClosingBalance',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(KRDReportLine."Closing Balance",0,TxtPrec)));  

                XmlElem[7] := XmlElement.Create('ShortTermResidualMaturity',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(KRDReportLine."Closing Balance",0,TxtPrec))); 

                XmlElem[7] := XmlElement.Create('Arrears',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do

                XmlElem[6] := XmlElement.Create('InterestAndIncome',xbsrns);
                XmlElem[5].Add(xmlElem[6]);    

                XmlElem[7] := XmlElement.Create('OpeningBalance',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do         

                XmlElem[7] := XmlElement.Create('AccruedInterest',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do        

                XmlElem[7] := XmlElement.Create('PaidInterest',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do

                XmlElem[7] := XmlElement.Create('OtherChanges',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do 

                XmlElem[7] := XmlElement.Create('ClosingBalance',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do

                XmlElem[7] := XmlElement.Create('ShortTermResidualMaturity',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do 

                XmlElem[7] := XmlElement.Create('Arrears',xbsrns);
                XmlElem[6].Add(xmlElem[7]);  
                XmlElem[7].Add(XmlText.Create(Format(0,0,TxtPrec)));  //to do                                                                                                                                                                                                                                                                                                                                               

            until KRDReportLine.Next() = 0;
        end;         

        //export stream file part
        TmpBlob.Blob.CreateOutStream(outStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(outStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);
    
        FileName := 'krd_' + format(KRDRepHead."No.") + '.xml'; 
        ExpOk := File.DownloadFromStream(InStr,'Save To File','','All Files (*.*)|*.*',FileName);   

        Message(Msg001,FileName);    

    end;
  
}
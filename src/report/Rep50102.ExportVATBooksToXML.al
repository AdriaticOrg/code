/*
report 50102 "Export VAT Books To XML"
{
    CaptionML = ENU = 'Export VAT Books To XML',
                SRM = 'Izvoz PDV knjiga u XML';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Gen. Journal Batch"; "Gen. Journal Batch")
        {

        }
    }
    trigger OnPreReport();
    begin
        //IF DateFilter = '' THEN
        //    error(Text001);
       // VATBooksExporttoXML.ExportToXML(DateFilter, PPPDVDate, ResponsiblePerson);
    end;

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("Date Filter";DateFilter)
                    {
                        CaptionML = ENU = 'Date Filter',
                                    SRM = 'Filter datuma';
                        trigger OnValidate();
                        var
                            ApplicationManagement : Codeunit ApplicationManagement;
                        begin
                            ApplicationManagement.MakeDateFilter(DateFilter);    
                        end;
                    }
                    field("PPPDV Date"; PPPDVDate)
                    {
                       CaptionML = ENU = 'PPPDV Date',
                                   SRM = 'Datum prijave'; 
                    }
                    /*
                    field("Responsible Person"; ResponsiblePerson)
                    {
                        CaptionML = ENU = 'Responsible Person',
                                    SRM = 'Odgovorno lice';
                        tablerelation = "User Setup"
                    }
            }
        }
    }
    var
      PPPDVDate : Date;
      DateFilter : Text;
      Text001 : TextConst ENU='You must enter Date Filter',SRM='Morate uneti filter datuma';
      ResponsiblePerson : Text[250];
}

OBJECT Codeunit 49021068 VAT Books Export to XML
{
  OBJECT-PROPERTIES
  {
    Date=07.08.18;
    Time=16:00:52;
    Modified=Yes;
    Version List=NAVRS10.00;
  }
  PROPERTIES
  {
    OnRun=BEGIN
          END;

  }
  CODE
  {
    VAR
      XMLFile@49021040 : File;
      XMLOutStream@49021041 : OutStream;
      XMLInStream@49021042 : InStream;
      Text001@1035 : TextConst 'ENU=VAT Books;SRL=PDV knjige;SRM=PDV knjige';
      Text002@1034 : TextConst 'ENU="<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>"';
      ObracuniTag@1033 : TextConst 'ENU=obracuni';
      PPPDVTag@1032 : TextConst 'ENU=PPPDV;SRM=PPPDV';
      ComTxt@1031 : TextConst 'ENU=<!-- %1 -->;SRM=<!-- %1  -->';
      OJTag@1030 : TextConst 'ENU=OJ;SRM=OJ';
      PIBTag@1029 : TextConst 'ENU=PIB;SRM=PIB';
      FirmaTag@1028 : TextConst 'ENU=Firma;SRM=Firma';
      OpstinaTag@1027 : TextConst 'ENU=Opstina;SRM=Opstina';
      AdresaTag@1026 : TextConst 'ENU=Adresa;SRM=Adresa';
      Od_DatumTag@1025 : TextConst 'ENU=Od_Datum;SRM=Od_Datum';
      Do_DatumTag@1024 : TextConst 'ENU=Do_Datum;SRM=Do_Datum';
      ElektronskaPostaTag@1023 : TextConst 'ENU=ElektronskaPosta;SRM=ElektronskaPosta';
      PoreskiSavetnikTag@1022 : TextConst 'ENU=PoreskiSavetnik;SRM=PoreskiSavetnik';
      PIBPoreskiSavetnikTag@1021 : TextConst 'ENU=PIBPoreskiSavetnik;SRM=PIBPoreskiSavetnik';
      JMBGPoreskiSavetnikTag@1020 : TextConst 'ENU=JMBGPoreskiSavetnik;SRM=JMBGPoreskiSavetnik';
      MestoTag@1019 : TextConst 'ENU=Mesto;SRM=Mesto';
      Datum_PrijaveTag@1018 : TextConst 'ENU=Datum_Prijave;SRM=Datum_Prijave';
      OdgovornoLiceTag@1017 : TextConst 'ENU=OdgovornoLice;SRM=OdgovornoLice';
      PovracajDATag@1016 : TextConst 'ENU=PovracajDA;SRM=PovracajDA';
      PovracajNETag@1015 : TextConst 'ENU=PovracajNE;SRM=PovracajNE';
      PeriodPOBTag@1014 : TextConst 'ENU=PeriodPOB;SRM=PeriodPOB';
      TipPodnosiocaTag@1013 : TextConst 'ENU=TipPodnosioca;SRM=TipPodnosioca';
      IzmenaPrijaveTag@1012 : TextConst 'ENU=IzmenaPrijave;SRM=IzmenaPrijave';
      IdentifikacioniBrojPrijaveKojaSeMenjaTag@1011 : TextConst 'ENU=IdentifikacioniBrojPrijaveKojaSeMenja;SRM=IdentifikacioniBrojPrijaveKojaSeMenja';
      RootTagBegin@1010 : TextConst 'ENU="ns1:EPPPDV xmlns:ns1=""urn:poreskauprava.gov.rs/zim"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""";SRM="ns1:EPPPDV xmlns:ns1=""urn:poreskauprava.gov.rs/zim"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""';
      RootTagEnd@1009 : TextConst 'ENU=ns1:EPPPDV;SRM=ns1:EPPPDV';
      SadrzajTag@1008 : TextConst 'ENU=sadrzaj;SRL=sadrzaj';
      SignaturesTag@1007 : TextConst 'ENU=signatures;SRM=signatures';
      Envelopa@1006 : TextConst 'ENU=envelopa;SRM=envelopa';
      PriloziTag@1005 : TextConst 'ENU=prilozi';
      NacinPodnosenjaAttr@1004 : TextConst 'ENU="nacinPodnosenja=""elektronski""";SRM="nacinPodnosenja=""elektronski"""';
      TimestampAttr@1003 : TextConst 'ENU="timestamp=""%1""";SRM="timestamp=""%1"""';
      IdAttr@1002 : TextConst 'ENU="id=""""";SRM="id="""""';
      TipIdentifikatoraAttr@1001 : TextConst 'ENU="tipIdentifikatora=""JMBG""";SRM="tipIdentifikatora=""JMBG"""';
      VremePodnosenjaAttr@1000 : TextConst 'ENU="vremePodnosenja=""%1""";SRM="vremePodnosenja=""%1"""';
      Tag63@1000000000 : TextConst 'SRM=Iznos_63';
      Tag64@1000000001 : TextConst 'SRM=Iznos_64';

    LOCAL PROCEDURE XMLFileOpen@49021047();
    VAR
      Text001Loc@1100646003 : TextConst 'ENU="<?xml version=""1.0""?>";SRL="<?xml version=""1.0""?>"';
      Text002Loc@49021041 : TextConst 'ENU="<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>";SRL="<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>"';
      Encoding@1000000000 : TextEncoding;
    BEGIN
      XMLFile.CREATETEMPFILE(TEXTENCODING::UTF8);
      XMLFile.CREATEOUTSTREAM(XMLOutStream);
      XMLOutStream.WRITETEXT(Text002Loc);
      XMLOutStream.WRITETEXT();
    END;

    LOCAL PROCEDURE XMLFileClose@1103401007();
    VAR
      InStream@1001 : InStream;
      FileName@1000 : Text;
      DateTimeTxt@49021041 : Text;
      TempBlob@1000000000 : Record 99008535;
      Encoding@1000000001 : TextEncoding;
    BEGIN
      XMLFile.CREATEINSTREAM(InStream);
      DateTimeTxt := CONVERTSTR(FORMAT(CURRENTDATETIME),':','_');
      FileName := Text001 + '_' + CONVERTSTR(DateTimeTxt,' ','_');
      DOWNLOADFROMSTREAM(InStream,'Export','','XML Files (*.xml)|*.xml',FileName);
      XMLFile.CLOSE;
    END;

    LOCAL PROCEDURE XMLWrite@1103401008(Text@1100646000 : Text[250];Tag@1100646005 : Text[250];Indent@1100646001 : Integer;PrintTag@1100646004 : 'Both,Front,Back,None';LongTag@49021040 : Boolean);
    VAR
      i@1100646002 : Integer;
      Text102@1100646003 : TextConst 'ENU=Wrong XML indent writing text %1;SRL=Pogreçan XML indent za tekst %1';
      simbol@1100646006 : Char;
    BEGIN
      FOR i := 1 TO Indent DO
        XMLOutStream.WRITETEXT('  ');
      IF Indent < 0 THEN
        ERROR(Text102, Text);
      IF PrintTag IN [PrintTag::Both,PrintTag::Front] THEN BEGIN
        IF LongTag THEN
          XMLOutStream.WRITETEXT('<'+Tag+' />')
        ELSE
          XMLOutStream.WRITETEXT('<'+Tag+'>')
      END;
      XMLOutStream.WRITETEXT(Text);
      IF PrintTag IN [PrintTag::Both,PrintTag::Back] THEN BEGIN
        XMLOutStream.WRITETEXT('</'+Tag+'>')
      END;
      XMLOutStream.WRITETEXT();
    END;

    PROCEDURE ExportToXML@49021040(DateFilter@49021048 : Text;PPPDVDate@49021051 : Date;ResponsiblePerson@49021052 : Text[250]);
    VAR
      VATBook@49021040 : Record 49021073;
      VATBookGroup@49021041 : Record 49021075;
      VATBookViewLine@49021042 : Record 49021074;
      VATEntry@49021043 : Record 254;
      VATBookColumnName@49021047 : Record 49021072;
      CompanyInformation@49021050 : Record 79;
      User@49021053 : Record 2000000120;
      VATManagement@49021044 : Codeunit 49021065;
      ColumnAmt@49021046 : Decimal;
      ColumnAmt1@49021045 : Decimal;
      i@49021049 : Integer;
      FullUserName@49021054 : Text[250];
      TempDateFilter@49021055 : Text;
      VatBookTagName@1000 : Text;
      WriteTag@1001 : Boolean;
      FromDateText@1000000000 : Text;
      ToDateText@1000000001 : Text;
      FromDate@1000000002 : Date;
      ToDate@1000000003 : Date;
    BEGIN
      XMLFileOpen;
      XMLWrite('',RootTagBegin,0,1,FALSE);
      XMLWrite('',Envelopa + ' ' + IdAttr + ' ' + STRSUBSTNO(TimestampAttr,FORMAT(DT2DATE(CURRENTDATETIME),0,9) + 'T' + FORMAT(DT2TIME(CURRENTDATETIME),0,9)) + ' ' + NacinPodnosenjaAttr,0,1,FALSE);
      XMLWrite('',SadrzajTag,1,1,FALSE);
      IF CompanyInformation.GET THEN BEGIN
        XMLWrite(CompanyInformation.City,OJTag,2,0,FALSE);
        XMLWrite(CompanyInformation."VAT Registration No.",PIBTag,2,0,FALSE);
        XMLWrite(CompanyInformation.Name,FirmaTag,2,0,FALSE);
        XMLWrite(CompanyInformation.City,OpstinaTag,2,0,FALSE);
        XMLWrite(CompanyInformation.Address,AdresaTag,2,0,FALSE);
        FromDateText := COPYSTR(DateFilter, 1, 8);
        ToDateText := COPYSTR(DateFilter, 11, 8);
        EVALUATE(FromDate,FromDateText);
        EVALUATE(ToDate,ToDateText);
        XMLWrite(FORMAT(FromDate,0,9),Od_DatumTag,2,0,FALSE);
        XMLWrite(FORMAT(ToDate,0,9),Do_DatumTag,2,0,FALSE);
        XMLWrite(CompanyInformation."E-Mail",ElektronskaPostaTag,2,0,FALSE);
        //XMLWrite('',PoreskiSavetnikTag,2,0,FALSE);
        //XMLWrite('',PIBPoreskiSavetnikTag,2,0,FALSE);
        //XMLWrite('',JMBGPoreskiSavetnikTag,2,0,FALSE);
        XMLWrite(CompanyInformation.City,MestoTag,2,0,FALSE);
        XMLWrite(FORMAT(PPPDVDate,0,9),Datum_PrijaveTag,2,0,FALSE);
        User.SETRANGE("User Name",ResponsiblePerson);
        IF User.FINDFIRST THEN
          FullUserName := User."Full Name";
        XMLWrite(FullUserName,OdgovornoLiceTag,2,0,FALSE);

        VATBook.SETRANGE("Tag Name",'0');
        IF VATBook.FINDFIRST THEN
          VATBookGroup.SETRANGE("VAT Book Code",VATBook.Code);
          VATBookGroup.SETFILTER("Tag Name",'<>%1','');
          IF VATBookGroup.FINDSET THEN
            REPEAT
              VATBookColumnName.SETRANGE("VAT Book Code",VATBook.Code);
              VATBookColumnName.SETFILTER("Column No.",VATBookGroup."Include Columns");
              IF VATBookColumnName.FINDFIRST THEN BEGIN
                ColumnAmt := VATManagement.EvaluateExpression(VATBookGroup,VATBookColumnName."Column No.",DateFilter);
                XMLWrite(DELCHR(FORMAT(ROUND(ColumnAmt,1)),'<=>','.'),VATBookGroup."Tag Name",2,0,FALSE);
              END;
            UNTIL VATBookGroup.NEXT = 0;

        XMLWrite('0',PovracajDATag,2,0,FALSE);
        XMLWrite('0',PovracajNETag,2,0,FALSE);
        XMLWrite('1',PeriodPOBTag,2,0,FALSE);
        XMLWrite('1',TipPodnosiocaTag,2,0,FALSE);
        XMLWrite('0',IzmenaPrijaveTag,2,0,FALSE);
        XMLWrite('0',IdentifikacioniBrojPrijaveKojaSeMenjaTag,2,0,FALSE);
      END;
      XMLWrite('',SadrzajTag,1,2,FALSE);
      //XMLWrite('',PriloziTag,1,1,FALSE);
      //XMLWrite('',PriloziTag,1,2,FALSE);
      XMLWrite('',ObracuniTag,1,1,FALSE);
      VATBook.RESET;
      VATBook.SETCURRENTKEY("Sorting Appearance",Code);
      VATBook.SETRANGE("Include in XML",TRUE);
      IF VATBook.FINDSET THEN
        REPEAT
          IF VatBookTagName <> VATBook."Tag Name" THEN BEGIN
            IF VatBookTagName <> '' THEN
              XMLWrite('',VatBookTagName,1,2,FALSE);
            XMLWrite('',VATBook."Tag Name",1,1,FALSE);
            VatBookTagName := VATBook."Tag Name";
            WriteTag := TRUE;
          END ELSE
            WriteTag := FALSE;
          VATBookGroup.RESET;
          VATBookGroup.SETRANGE("VAT Book Code",VATBook.Code);
          VATBookGroup.SETFILTER("Tag Name",'<>%1','');
          IF VATBookGroup.FINDSET THEN BEGIN
            REPEAT
              i := 0;
              VATBookColumnName.RESET;
              VATBookColumnName.SETRANGE("VAT Book Code",VATBook.Code);
              IF VATBookColumnName.FINDSET THEN BEGIN
                IF VATBookColumnName.COUNT > 1 THEN
                  i := 1;
                REPEAT
                  ColumnAmt := VATManagement.EvaluateExpression(VATBookGroup,VATBookColumnName."Column No.",DateFilter);
                  IF i > 0 THEN BEGIN
                    IF ((STRPOS(VATBookGroup."Include Columns",FORMAT(VATBookColumnName."Column No.")) <> 0) OR (VATBookGroup."Include Columns" = '')) AND (ROUND(ColumnAmt,1) <> 0) THEN
                      IF (VATBookGroup."Tag Name" = Tag63) OR (VATBookGroup."Tag Name" = Tag64) THEN
                        XMLWrite(DELCHR(FORMAT(ROUND(ColumnAmt,1)),'<=>','.'),VATBookGroup."Tag Name",2,0,FALSE)
                      ELSE
                        XMLWrite(DELCHR(FORMAT(ROUND(ColumnAmt,1)),'<=>','.'),VATBookGroup."Tag Name"+FORMAT(i),2,0,FALSE);
                    i += 1;
                  END ELSE
                    IF ((STRPOS(VATBookGroup."Include Columns",FORMAT(VATBookColumnName."Column No.")) <> 0) OR (VATBookGroup."Include Columns" = '')) AND (ROUND(ColumnAmt,1) <> 0) THEN
                      XMLWrite(DELCHR(FORMAT(ROUND(ColumnAmt,1)),'<=>','.'),VATBookGroup."Tag Name",2,0,FALSE);
                UNTIL VATBookColumnName.NEXT = 0;
              END;
            UNTIL VATBookGroup.NEXT = 0;
          END;
        UNTIL VATBook.NEXT = 0;
        XMLWrite('',VATBook."Tag Name",1,2,FALSE);
      XMLWrite('',ObracuniTag,1,2,FALSE);
      XMLWrite('',Envelopa,0,2,FALSE);
      XMLWrite('',RootTagEnd,0,2,FALSE);
      XMLFileClose;
    END;

    BEGIN
    {
      NAVRS10.00
        VAT - Object created
    }
    END.
  }
}
*/
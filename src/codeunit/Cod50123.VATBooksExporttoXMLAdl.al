codeunit 50123 "VAT Books Export to XML-Adl"
{

    var

        TempBlob: Record TempBlob temporary;
        XMLOutStream: OutStream;
        XMLInStream: InStream;
        Title: Label 'VAT Books';
        ObracuniTag: Label 'obracuni';
        PPPDVTag: Label 'PPPDV';
        ComTxt: Label '<!-- %1 -->';
        OJTag: Label 'OJ';
        PIBTag: Label 'PIB';
        FirmaTag: Label 'Firma';
        OpstinaTag: Label 'Opstina';
        AdresaTag: Label 'Adresa';
        Od_DatumTag: Label 'Od_Datum';
        Do_DatumTag: Label 'Do_Datum';
        ElektronskaPostaTag: Label 'ElektronskaPosta';
        PoreskiSavetnikTag: Label 'PoreskiSavetnik';
        PIBPoreskiSavetnikTag: Label 'PIBPoreskiSavetnik';
        JMBGPoreskiSavetnikTag: Label 'JMBGPoreskiSavetnik';
        MestoTag: Label 'Mesto';
        Datum_PrijaveTag: Label 'Datum_Prijave';
        OdgovornoLiceTag: Label 'OdgovornoLice';
        PovracajDATag: Label 'PovracajDA';
        PovracajNETag: Label 'PovracajNE';
        PeriodPOBTag: Label 'PeriodPOB';
        TipPodnosiocaTag: Label 'TipPodnosioca';
        IzmenaPrijaveTag: Label 'IzmenaPrijave';
        IdentifikacioniBrojPrijaveKojaSeMenjaTag: Label 'IdentifikacioniBrojPrijaveKojaSeMenja';
        RootTagbegin: Label '"ns1:EPPPDV xmlns:ns1=""urn:poreskauprava.gov.rs/zim"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""';
        RootTagEnd: Label 'ns1:EPPPDV';
        SadrzajTag: Label 'sadrzaj';
        SignaturesTag: Label 'signatures';
        Envelopa: Label 'envelopa';
        PriloziTag: Label 'prilozi';
        NacinPodnosenjaAttr: Label '"nacinPodnosenja=""elektronski"""';
        TimestampAttr: Label '"timestamp=""%1"""';
        IdAttr: Label '"id="""""';
        TipIdentifikatoraAttr: Label '"tipIdentifikatora=""JMBG"""';
        VremePodnosenjaAttr: Label '"vremePodnosenja=""%1"""';
        Tag63: Label 'Iznos_63';
        Tag64: Label 'Iznos_64';

    local procedure XMLFileOpen();
    var
        Text001Loc: Label '"<?xml version=""1.0""?>"';
        XMLVarsionLoc: Label '"<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>"';
        Encoding: TextEncoding;
    begin
        TempBlob.DeleteAll();
        Clear(TempBlob);
        TempBlob.Init();
        TempBlob.Blob.CreateOutStream(XMLOutStream);
        XMLOutStream.WriteText(XMLVarsionLoc);
        XMLOutStream.WriteText();
    end;

    local procedure XMLFileClose();
    var
        InStream: InStream;
        FileName: Text;
        DateTimeTxt: Text;
        Encoding: TextEncoding;
    begin
        Tempblob.Insert();
        Tempblob.CalcFields(Blob);
        TempBlob.Blob.CreateInStream(InStream);
        DateTimeTxt := ConvertStr(Format(CURRENTDATETIME), ':', '_');
        FileName := Title + '_' + ConvertStr(DateTimeTxt, ' ', '_');
        DownloadFromStream(InStream, 'Export', '', 'XML Files (*.xml)|*.xml', FileName);
    end;

    local procedure XMLWrite(Text: Text[250]; Tag: Text[250]; Indent: Integer; PrintTag: Option Both, Front, Back, None; LongTag: Boolean);
    var
        i: Integer;
        Text102: Label 'Wrong XML indent writing text %1';
        simbol: Char;
    begin
        for i := 1 to Indent do
            XMLOutStream.WriteText('  ');
            if Indent < 0 then
                ERRor(Text102, Text);
            if PrintTag in [PrintTag::Both, PrintTag::Front] then begin
                if LongTag then
                    XMLOutStream.WriteText('<' + Tag + ' />')
                else
                    XMLOutStream.WriteText('<' + Tag + '>')
        end;
        XMLOutStream.WriteText(Text);
        if PrintTag in [PrintTag::Both, PrintTag::Back] then begin
            XMLOutStream.WriteText('</' + Tag + '>')
        end;
        XMLOutStream.WriteText();
    end;

    procedure ExportToXML(DateFilter: Text; PPPDVDate: Date; ResponsiblePerson: Text[250]);
    var
        VATBook: Record "VAT Book-Adl";
        VATBookGroup: Record "VAT Book Group-Adl";
        VATBookViewFormula: Record "VAT Book View Formula-Adl";
        VATEntry: Record "VAT Entry";
        VATBookColumnName: Record "VAT Book Column Name-Adl";
        CompanyInFormation: Record "Company InFormation";
        User: Record User;
        VATManagement: Codeunit "VAT Management-Adl";
        ColumnAmt: Decimal;
        ColumnAmt1: Decimal;
        i: Integer;
        FullUserName: Text[250];
        TempDateFilter: Text;
        VatBookTagName: Text;
        WriteTag: Boolean;
        FromDateText: Text;
        ToDateText: Text;
        FromDate: Date;
        ToDate: Date;
    begin
        XMLFileOpen;
        XMLWrite('', RootTagbegin, 0, 1, false);
        XMLWrite('', Envelopa + ' ' + IdAttr + ' ' + STRSUBSTNO(TimestampAttr, Format(DT2DATE(CURRENTDATETIME), 0, 9) + 'T' + Format(DT2TIME(CURRENTDATETIME), 0, 9)) + ' ' + NacinPodnosenjaAttr, 0, 1, false);
        XMLWrite('', SadrzajTag, 1, 1, false);
        if CompanyInFormation.GET then begin
            XMLWrite(CompanyInFormation.City, OJTag, 2, 0, false);
            XMLWrite(CompanyInFormation."VAT Registration No.", PIBTag, 2, 0, false);
            XMLWrite(CompanyInFormation.Name, FirmaTag, 2, 0, false);
            XMLWrite(CompanyInFormation.City, OpstinaTag, 2, 0, false);
            XMLWrite(CompanyInFormation.Address, AdresaTag, 2, 0, false);
            FromDateText := COPYSTR(DateFilter, 1, 8);
            ToDateText := COPYSTR(DateFilter, 11, 8);
            EVALUATE(FromDate, FromDateText);
            EVALUATE(ToDate, ToDateText);
            XMLWrite(Format(FromDate, 0, 9), Od_DatumTag, 2, 0, false);
            XMLWrite(Format(ToDate, 0, 9), Do_DatumTag, 2, 0, false);
            XMLWrite(CompanyInFormation."E-Mail", ElektronskaPostaTag, 2, 0, false);
            XMLWrite(CompanyInFormation.City, MestoTag, 2, 0, false);
            XMLWrite(Format(PPPDVDate, 0, 9), Datum_PrijaveTag, 2, 0, false);
            User.SetRange("User Name", ResponsiblePerson);
            if User.FindFirst then
                FullUserName := User."Full Name";
            XMLWrite(FullUserName, OdgovornoLiceTag, 2, 0, false);

            VATBook.SetRange("Tag Name", '0');
            if VATBook.FindFirst then
                VATBookGroup.SetRange("VAT Book Code", VATBook.Code);
            VATBookGroup.SetFilter("Tag Name", '<>%1', '');
            if VATBookGroup.FindSet then
                repeat
                    VATBookColumnName.SetRange("VAT Book Code", VATBook.Code);
                    VATBookColumnName.SetFilter("Column No.", VATBookGroup."Include Columns");
                    if VATBookColumnName.FindFirst then begin
                        ColumnAmt := VATManagement.EvaluateExpression(VATBookGroup, VATBookColumnName."Column No.", DateFilter);  //GRMtoAdd
                        XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name", 2, 0, false);
                    end;
                until VATBookGroup.Next = 0;

            XMLWrite('0', PovracajDATag, 2, 0, false);
            XMLWrite('0', PovracajNETag, 2, 0, false);
            XMLWrite('1', PeriodPOBTag, 2, 0, false);
            XMLWrite('1', TipPodnosiocaTag, 2, 0, false);
            XMLWrite('0', IzmenaPrijaveTag, 2, 0, false);
            XMLWrite('0', IdentifikacioniBrojPrijaveKojaSeMenjaTag, 2, 0, false);
        end;
        XMLWrite('', SadrzajTag, 1, 2, false);
        XMLWrite('', ObracuniTag, 1, 1, false);
        VATBook.Reset;
        VATBook.SETCURRENTKEY("Sorting Appearance", Code);
        VATBook.SetRange("Include in XML", true);
        if VATBook.FindSet then
            repeat
                if VatBookTagName <> VATBook."Tag Name" then begin
                    if VatBookTagName <> '' then
                        XMLWrite('', VatBookTagName, 1, 2, false);
                    XMLWrite('', VATBook."Tag Name", 1, 1, false);
                    VatBookTagName := VATBook."Tag Name";
                    WriteTag := true;
                end else
                    WriteTag := false;
                VATBookGroup.Reset;
                VATBookGroup.SetRange("VAT Book Code", VATBook.Code);
                VATBookGroup.SetFilter("Tag Name", '<>%1', '');
                if VATBookGroup.FindSet then begin
                    repeat
                        i := 0;
                        VATBookColumnName.Reset;
                        VATBookColumnName.SetRange("VAT Book Code", VATBook.Code);
                        if VATBookColumnName.FindSet then begin
                            if VATBookColumnName.Count > 1 then
                                i := 1;
                            repeat
                                ColumnAmt := VATManagement.EvaluateExpression(VATBookGroup, VATBookColumnName."Column No.", DateFilter);
                                if i > 0 then begin
                                    if((StrPos(VATBookGroup."Include Columns", Format(VATBookColumnName."Column No.")) <> 0) 
                                        or (VATBookGroup."Include Columns" = '')) 
                                        and (Round(ColumnAmt, 1) <> 0) 
                                    then
                                        if(VATBookGroup."Tag Name" = Tag63) 
                                           or (VATBookGroup."Tag Name" = Tag64) 
                                        then
                                            XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name", 2, 0, false)
                                        else
                                            XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name" + Format(i), 2, 0, false);
                                    i += 1;
                                end else 
                                    if((StrPos(VATBookGroup."Include Columns", Format(VATBookColumnName."Column No.")) <> 0) 
                                       or(VATBookGroup."Include Columns" = '')) 
                                       and(Round(ColumnAmt, 1) <> 0) 
                                    then
                                        XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name", 2, 0, false);
                            until VATBookColumnName.Next = 0;
                        end;
                    until VATBookGroup.Next = 0;
                end;
            until VATBook.Next = 0;
        XMLWrite('', VATBook."Tag Name", 1, 2, false);
        XMLWrite('', ObracuniTag, 1, 2, false);
        XMLWrite('', Envelopa, 0, 2, false);
        XMLWrite('', RootTagEnd, 0, 2, false);
        XMLFileClose;
    end;
}
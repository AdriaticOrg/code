codeunit 13062593 "VAT Books Export to XML-Adl"
{

    var

        TempBlob: Record TempBlob temporary;
        XMLOutStream: OutStream;
        XMLInStream: InStream;
        Title: Label 'VAT Books';
        CalculationsTag: Label 'obracuni';
        PPPDVTag: Label 'PPPDV';
        ComTxt: Label '<!-- %1 -->';
        OJTag: Label 'OJ';
        RegNoTag: Label 'PIB';
        CompanyTag: Label 'Firma';
        MunicipalityTag: Label 'Opstina';
        AdresaTag: Label 'Adresa';
        From_Date_Tag: Label 'Od_Datum';
        To_Date_Tag: Label 'Do_Datum';
        EmailTag: Label 'ElektronskaPosta';
        TaxAdviserIDTag: Label 'JMBGPoreskiSavetnik';
        PlaceTag: Label 'Mesto';
        ApplicationDateTag: Label 'Datum_Prijave';
        ResponsiblePersonTag: Label 'OdgovornoLice';
        ReturnYesTag: Label 'PovracajDA';
        ReturnNoTag: Label 'PovracajNE';
        PeriodPOBTag: Label 'PeriodPOB';
        ApplierTypeTag: Label 'TipPodnosioca';
        ApplicatonChangeTag: Label 'IzmenaPrijave';
        ApplicationNoForChangeTag: Label 'IdentifikacioniBrojPrijaveKojaSeMenja';
        RootTagbegin: Label '"ns1:EPPPDV xmlns:ns1=""urn:poreskauprava.gov.rs/zim"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""';
        RootTagEnd: Label 'ns1:EPPPDV';
        ContentTag: Label 'sadrzaj';
        SignaturesTag: Label 'signatures';
        Envelopa: Label 'envelopa';
        AttachmentTab: Label 'prilozi';
        ApplyMethodAttr: Label '"nacinPodnosenja=""elektronski"""';
        TimestampAttr: Label '"timestamp=""%1"""';
        IdAttr: Label '"id="""""';
        IndentyfierTypeAttr: Label '"tipIdentifikatora=""JMBG"""';
        ApplyTimeAttr: Label '"vremePodnosenja=""%1"""';
        Tag63: Label 'Iznos_63';
        Tag64: Label 'Iznos_64';

    local procedure XMLFileOpen();
    var
        Text001Loc: Label '"<?xml version=""1.0""?>"';
        XMLVarsionLoc: Label '"<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>"';
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
    begin
        Tempblob.Insert();
        Tempblob.CalcFields(Blob);
        TempBlob.Blob.CreateInStream(InStream);
        DateTimeTxt := ConvertStr(Format(CurrentDateTime()), ':', '_');
        FileName := Title + '_' + ConvertStr(DateTimeTxt, ' ', '_');
        DownloadFromStream(InStream, 'Export', '', 'XML Files (*.xml)|*.xml', FileName);
    end;

    local procedure XMLWrite(Text: Text[250]; Tag: Text[250]; Indent: Integer; PrintTag: Option Both,Front,Back,None; LongTag: Boolean);
    var
        i: Integer;
        WrongXMLIndentErr: Label 'Wrong XML indent writing text %1';
    begin
        for i := 1 to Indent do
            XMLOutStream.WriteText('  ');
        if Indent < 0 then
            ERROR(WrongXMLIndentErr, Text);
        if PrintTag in [PrintTag::Both, PrintTag::Front] then
            if LongTag then
                XMLOutStream.WriteText('<' + Tag + ' />')
            else
                XMLOutStream.WriteText('<' + Tag + '>');

        XMLOutStream.WriteText(Text);
        if PrintTag in [PrintTag::Both, PrintTag::Back] then
            XMLOutStream.WriteText('</' + Tag + '>');

        XMLOutStream.WriteText();
    end;

    procedure ExportToXML(DateFilter: Text; PPPDVDate: Date; ResponsiblePerson: Text[250]);
    var
        VATBook: Record "VAT Book-Adl";
        VATBookGroup: Record "VAT Book Group-Adl";
        VATBookColumnName: Record "VAT Book Column Name-Adl";
        CompanyInFormation: Record "Company InFormation";
        User: Record User;
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        ColumnAmt: Decimal;
        i: Integer;
        FullUserName: Text[250];
        VatBookTagName: Text;
        WriteTag: Boolean;
        FromDateText: Text;
        ToDateText: Text;
        FromDate: Date;
        ToDate: Date;
    begin
        XMLFileOpen();
        XMLWrite('', RootTagbegin, 0, 1, false);
        XMLWrite('', Envelopa + ' ' + IdAttr + ' ' + StrSubstNo(TimestampAttr, Format(DT2DATE(CurrentDateTime()), 0, 9) + 'T' + Format(DT2TIME(CurrentDateTime()), 0, 9)) + ' ' + ApplyMethodAttr, 0, 1, false);
        XMLWrite('', ContentTag, 1, 1, false);
        if CompanyInFormation.get() then begin
            XMLWrite(CompanyInFormation.City, OJTag, 2, 0, false);
            XMLWrite(CompanyInFormation."VAT Registration No.", RegNoTag, 2, 0, false);
            XMLWrite(CompanyInFormation.Name, CompanyTag, 2, 0, false);
            XMLWrite(CompanyInFormation.City, MunicipalityTag, 2, 0, false);
            XMLWrite(CompanyInFormation.Address, AdresaTag, 2, 0, false);
            FromDateText := COPYSTR(DateFilter, 1, 8);
            ToDateText := COPYSTR(DateFilter, 11, 8);
            Evaluate(FromDate, FromDateText);
            Evaluate(ToDate, ToDateText);
            XMLWrite(Format(FromDate, 0, 9), From_Date_Tag, 2, 0, false);
            XMLWrite(Format(ToDate, 0, 9), To_Date_Tag, 2, 0, false);
            XMLWrite(CompanyInFormation."E-Mail", EmailTag, 2, 0, false);
            XMLWrite(CompanyInFormation.City, PlaceTag, 2, 0, false);
            XMLWrite(Format(PPPDVDate, 0, 9), ApplicationDateTag, 2, 0, false);
            User.SetRange("User Name", ResponsiblePerson);
            if User.FindFirst() then
                FullUserName := User."Full Name";
            XMLWrite(FullUserName, ResponsiblePersonTag, 2, 0, false);

            VATBook.SetRange("Tag Name", '0');
            if VATBook.FindFirst() then
                VATBookGroup.SetRange("VAT Book Code", VATBook.Code);
            VATBookGroup.SetFilter("Tag Name", '<>%1', '');
            if VATBookGroup.FindSet() then
                repeat
                    VATBookColumnName.SetRange("VAT Book Code", VATBook.Code);
                    VATBookColumnName.SetFilter("Column No.", VATBookGroup."Include Columns");
                    if VATBookColumnName.FindFirst() then begin
                        ColumnAmt := VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnName."Column No.", DateFilter);  //GRMtoAdd
                        XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name", 2, 0, false);
                    end;
                until VATBookGroup.Next() = 0;

            XMLWrite('0', ReturnYesTag, 2, 0, false);
            XMLWrite('0', ReturnNoTag, 2, 0, false);
            XMLWrite('1', PeriodPOBTag, 2, 0, false);
            XMLWrite('1', ApplierTypeTag, 2, 0, false);
            XMLWrite('0', ApplicatonChangeTag, 2, 0, false);
            XMLWrite('0', ApplicationNoForChangeTag, 2, 0, false);
        end;
        XMLWrite('', ContentTag, 1, 2, false);
        XMLWrite('', CalculationsTag, 1, 1, false);
        VATBook.Reset();
        VATBook.SETCURRENTKEY("Sorting Appearance", Code);
        VATBook.SetRange("Include in XML", true);
        if VATBook.FindSet() then
            repeat
                if VatBookTagName <> VATBook."Tag Name" then begin
                    if VatBookTagName <> '' then
                        XMLWrite('', VatBookTagName, 1, 2, false);
                    XMLWrite('', VATBook."Tag Name", 1, 1, false);
                    VatBookTagName := VATBook."Tag Name";
                    WriteTag := true;
                end else
                    WriteTag := false;
                VATBookGroup.Reset();
                VATBookGroup.SetRange("VAT Book Code", VATBook.Code);
                VATBookGroup.SetFilter("Tag Name", '<>%1', '');

                if VATBookGroup.FindSet() then
                    repeat
                        i := 0;
                        VATBookColumnName.Reset();
                        VATBookColumnName.SetRange("VAT Book Code", VATBook.Code);
                        if VATBookColumnName.FindSet() then begin
                            if VATBookColumnName.Count() > 1 then
                                i := 1;
                            repeat
                                ColumnAmt := VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnName."Column No.", DateFilter);
                                if i > 0 then begin
                                    if ((StrPos(VATBookGroup."Include Columns", Format(VATBookColumnName."Column No.")) <> 0)
                                        or (VATBookGroup."Include Columns" = ''))
                                        and (Round(ColumnAmt, 1) <> 0)
                                    then
                                        if (VATBookGroup."Tag Name" = Tag63)
                                           or (VATBookGroup."Tag Name" = Tag64)
                                        then
                                            XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name", 2, 0, false)
                                        else
                                            XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name" + Format(i), 2, 0, false);
                                    i += 1;
                                end else
                                    if ((StrPos(VATBookGroup."Include Columns", Format(VATBookColumnName."Column No.")) <> 0)
                                       or (VATBookGroup."Include Columns" = ''))
                                       and (Round(ColumnAmt, 1) <> 0)
                                    then
                                        XMLWrite(DelChr(Format(Round(ColumnAmt, 1)), '<=>', '.'), VATBookGroup."Tag Name", 2, 0, false);
                            until VATBookColumnName.Next() = 0;
                        end;
                    until VATBookGroup.Next() = 0;
            until VATBook.Next() = 0;
        XMLWrite('', VATBook."Tag Name", 1, 2, false);
        XMLWrite('', CalculationsTag, 1, 2, false);
        XMLWrite('', Envelopa, 0, 2, false);
        XMLWrite('', RootTagEnd, 0, 2, false);
        XMLFileClose();
    end;
}
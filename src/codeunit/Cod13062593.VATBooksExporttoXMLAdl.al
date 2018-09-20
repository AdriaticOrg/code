codeunit 13062593 "VAT Books Export to XML-Adl"
{

    var

        TempBlob: Record TempBlob temporary;
        XMLOutStream: OutStream;
        TitleLbl: Label 'VAT Books';
        XMLVarsionLbl: Label '"<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?>"', Locked = true;
        CalculationsTagLbl: Label 'obracuni', Locked = true;
        OJTagLbl: Label 'OJ', Locked = true;
        RegNoTagLbl: Label 'PIB', Locked = true;
        CompanyTagLbl: Label 'Firma', Locked = true;
        MunicipalityTagLbl: Label 'Opstina', Locked = true;
        AdresaTagLbl: Label 'Adresa', Locked = true;
        From_Date_TagLbl: Label 'Od_Datum', Locked = true;
        To_Date_TagLbl: Label 'Do_Datum', Locked = true;
        EmailTagLbl: Label 'ElektronskaPosta', Locked = true;
        PlaceTagLbl: Label 'Mesto', Locked = true;
        ApplicationDateTagLbl: Label 'Datum_Prijave', Locked = true;
        ResponsiblePersonTagLbl: Label 'OdgovornoLice', Locked = true;
        ReturnYesTagLbl: Label 'PovracajDA', Locked = true;
        ReturnNoTagLbl: Label 'PovracajNE', Locked = true;
        PeriodPOBTagLbl: Label 'PeriodPOB', Locked = true;
        ApplierTypeTagLbl: Label 'TipPodnosioca', Locked = true;
        ApplicatonChangeTagLbl: Label 'IzmenaPrijave', Locked = true;
        ApplicationNoForChangeTagLbl: Label 'IdentifikacioniBrojPrijaveKojaSeMenja', Locked = true;
        RootTagbeginLbl: Label '"ns1:EPPPDV xmlns:ns1=""urn:poreskauprava.gov.rs/zim"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""', Locked = true;
        RootTagEndLbl: Label 'ns1:EPPPDV', Locked = true;
        ContentTagLbl: Label 'sadrzaj', Locked = true;
        EnvelopaLbl: Label 'envelopa', Locked = true;
        ApplyMethodAttrLbl: Label '"nacinPodnosenja=""elektronski"""', Locked = true;
        TimestampAttrLbl: Label '"timestamp=""%1"""', Locked = true;
        IdAttrLbl: Label '"id="""""', Locked = true;
        Tag63Lbl: Label 'Iznos_63', Locked = true;
        Tag64Lbl: Label 'Iznos_64', Locked = true;

    local procedure XMLFileOpen();
    begin
        TempBlob.DeleteAll();
        Clear(TempBlob);
        TempBlob.Init();
        TempBlob.Blob.CreateOutStream(XMLOutStream);
        XMLOutStream.WriteText(XMLVarsionLbl);
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
        FileName := TitleLbl + '_' + ConvertStr(DateTimeTxt, ' ', '_');
        DownloadFromStream(InStream, 'Export', '', 'XML Files (*.xml)|*.xml', FileName);
    end;

    local procedure XMLWrite(Text: Text; Tag: Text; Indent: Integer; PrintTag: Option Both,Front,Back,None; LongTag: Boolean);
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
        XMLWrite('', RootTagbeginLbl, 0, 1, false);
        XMLWrite('', EnvelopaLbl + ' ' + IdAttrLbl + ' ' + StrSubstNo(TimestampAttrLbl, Format(DT2DATE(CurrentDateTime()), 0, 9) + 'T' + Format(DT2TIME(CurrentDateTime()), 0, 9)) + ' ' + ApplyMethodAttrLbl, 0, 1, false);
        XMLWrite('', ContentTagLbl, 1, 1, false);
        if CompanyInFormation.get() then begin
            XMLWrite(CompanyInFormation.City, OJTagLbl, 2, 0, false);
            XMLWrite(CompanyInFormation."VAT Registration No.", RegNoTagLbl, 2, 0, false);
            XMLWrite(CompanyInFormation.Name, CompanyTagLbl, 2, 0, false);
            XMLWrite(CompanyInFormation.City, MunicipalityTagLbl, 2, 0, false);
            XMLWrite(CompanyInFormation.Address, AdresaTagLbl, 2, 0, false);
            FromDateText := COPYSTR(DateFilter, 1, 8);
            ToDateText := COPYSTR(DateFilter, 11, 8);
            Evaluate(FromDate, FromDateText);
            Evaluate(ToDate, ToDateText);
            XMLWrite(Format(FromDate, 0, 9), From_Date_TagLbl, 2, 0, false);
            XMLWrite(Format(ToDate, 0, 9), To_Date_TagLbl, 2, 0, false);
            XMLWrite(CompanyInFormation."E-Mail", EmailTagLbl, 2, 0, false);
            XMLWrite(CompanyInFormation.City, PlaceTagLbl, 2, 0, false);
            XMLWrite(Format(PPPDVDate, 0, 9), ApplicationDateTagLbl, 2, 0, false);
            User.SetRange("User Name", ResponsiblePerson);
            if User.FindFirst() then
                FullUserName := User."Full Name";
            XMLWrite(FullUserName, ResponsiblePersonTagLbl, 2, 0, false);

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

            XMLWrite('0', ReturnYesTagLbl, 2, 0, false);
            XMLWrite('0', ReturnNoTagLbl, 2, 0, false);
            XMLWrite('1', PeriodPOBTagLbl, 2, 0, false);
            XMLWrite('1', ApplierTypeTagLbl, 2, 0, false);
            XMLWrite('0', ApplicatonChangeTagLbl, 2, 0, false);
            XMLWrite('0', ApplicationNoForChangeTagLbl, 2, 0, false);
        end;
        XMLWrite('', ContentTagLbl, 1, 2, false);
        XMLWrite('', CalculationsTagLbl, 1, 1, false);
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
                                        if (VATBookGroup."Tag Name" = Tag63Lbl)
                                           or (VATBookGroup."Tag Name" = Tag64Lbl)
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
        XMLWrite('', CalculationsTagLbl, 1, 2, false);
        XMLWrite('', EnvelopaLbl, 0, 2, false);
        XMLWrite('', RootTagEndLbl, 0, 2, false);
        XMLFileClose();
    end;
}
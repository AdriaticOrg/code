codeunit 13062817 "Wizard Management-Adl"
{
    procedure ReadFromHttp(url: Text): Text
    var
        TempBlob: Record TempBlob temporary;
        httpResponse: HttpResponseMessage;
        httpCli: HttpClient;
        InputStr: InStream;
        OutputStream: OutStream;
        index: Integer;
    begin
        If url = '' then
            ShowError();

        if (not httpCli.Get(url, httpResponse)) then
            Error(Text001Err);

        if (not httpResponse.IsSuccessStatusCode()) then
            Error(Text001Err);

        httpResponse.Content().ReadAs(InputStr);
        TempBlob.Blob.CreateOutStream(OutputStream);

        index := url.LASTINDEXOF('/');
        if index = 0 then
            ShowError();

        FileName := CopyStr(url, index + 1, StrLen(Url));
        DownloadFromStream(InputStr, 'Save rapid start file', '', 'Rapidstart Files(*.rapidstart)|*rapidstart', FileName);
    end;

    procedure ReadFromHttp(ConfigSetup: record "Config. Setup"; PackageType: Option "Basic","Master")
    var
        TempBlob: Record TempBlob temporary;
        httpResponse: HttpResponseMessage;
        InputStr: InStream;
        OutputStream: OutStream;
        Url: Text;
        PackageName: Text;
    begin
        case ConfigSetup."Country/Region Code" of
            'SI':
                if PackageType = PackageType::Basic then
                    PackageName := 'BASIC%20SETUP_SI'
                else
                    PackageName := 'MASTER%20DATA_SI';
            'HR':
                if PackageType = PackageType::Basic then
                    PackageName := 'BASIC%20SETUP_HR'
                else
                    PackageName := 'MASTER%20DATA_HR';
            'RS':
                if PackageType = PackageType::Basic then
                    PackageName := 'BASIC%20SETUP_SR'
                else
                    PackageName := 'MASTER%20DATA_SR';

            else begin
                    Message(PackageMissingErr);
                    Error('');
                end;
        end;
        Url := 'https://github.com/AdriaticOrg/setup/blob/master/' + PackageName + '.rapidstart';

        if (not Client.Get(Url, httpResponse)) then
            Error(HttpGetRequestErr);

        if (not httpResponse.IsSuccessStatusCode()) then
            Error(HttpReadResponseErr);

        httpResponse.Content().ReadAs(InputStr);
        TempBlob.Blob.CreateOutStream(OutputStream);

        //FileName :=  '.rapidstart';
        DownloadFromStream(InputStr, 'Save rapid start file', '', 'Rapidstart Files(*.rapidstart)|*rapidstart', FileName);
    end;

    local procedure ShowError()
    begin
        Message(MissingUrlErr);
        Error('');
    end;

    procedure LoadConfigurationPackages(var TempBlob: Record TempBlob)
    var
        ConfigSetupTemp: Record "Config. Setup" temporary;
        ApplyingError: Integer;
    begin
        ImportRapidStartPackageStream(TempBlob, ConfigSetupTemp);
        ApplyingError := ConfigSetupTemp.ApplyPackages();
    end;

    procedure ImportRapidStartPackageStream(VAR TempBlob: Record TempBlob; VAR TempConfigSetup: Record "Config. Setup" temporary)
    var
        TempBlobUncompressed: Record TempBlob;
        InStream: InStream;
    begin
        IF TempConfigSetup.Get('ImportRS') THEN
            TempConfigSetup.Delete();

        TempConfigSetup.Init();
        TempConfigSetup."Primary Key" := 'ImportRS';
        TempConfigSetup."Package File Name" := 'ImportRapidStartPackageFromStream';
        TempConfigSetup.Insert();
        TempConfigSetup.DecompressPackageToBlob(TempBlob, TempBlobUncompressed);
        TempConfigSetup."Package File" := TempBlobUncompressed.Blob;
        TempConfigSetup."Package File".CREATEINSTREAM(InStream);

        TempConfigSetup.CalcFields("Package File");
        TempConfigSetup.SetHideDialog(true);
        TempConfigSetup.ReadPackageHeaderFromStream(InStream);
        TempConfigSetup.ImportPackageFromStream(InStream);
    end;

    procedure OpenRapidStartPackageStream(var ConfigSetup: Record "Config. Setup"): Boolean
    var
        TempBlob: Record TempBlob temporary;
        TempBlobUncompressed: Record TempBlob temporary;
        FileMgmt: Codeunit "File Management";
        ConfigXMLExchange: Codeunit "Config. XML Exchange";
        PackageFileName: Text;
        SelectPackageTxt: Label 'Select a package file.';
        InStream: InStream;
    begin
        PackageFileName := FileMgmt.BLOBImportWithFilter(
                                TempBlob, SelectPackageTxt, '', ConfigXMLExchange.GetFileDialogFilter(), 'rapidstart');
        ConfigSetup."Package File Name" := CopyStr(
                                                PackageFileName, 1, MaxStrLen(ConfigSetup."Package File Name"));
        if ConfigSetup."Package File Name" <> '' then begin
            ConfigSetup.DecompressPackageToBlob(TempBlob, TempBlobUncompressed);
            ConfigSetup."Package File" := TempBlobUncompressed.Blob;
            TempBlobUncompressed.Blob.CreateInStream(InStream);
            ConfigSetup.ReadPackageHeaderFromStream(InStream);
            exit(true);
        end else
            exit(false);
    end;

    procedure CompleteWizard(var ConfigSetup: Record "Config. Setup"; var TempBlob: record TempBlob): Boolean
    var
        InStream: InStream;
    begin
        ConfigSetup.TestField("Package File Name");
        ConfigSetup.TestField("Package Code");
        ConfigSetup.TestField("Package Name");

        ConfigSetup."Package File".CREATEINSTREAM(InStream);
        ConfigSetup.CalcFields("Package File");
        ConfigSetup.SetHideDialog(true);
        ConfigSetup.ReadPackageHeaderFromStream(InStream);
        ConfigSetup.ImportPackageFromStream(InStream);
        ConfigSetup.ApplyPackages();
        exit(true);
    end;

    var

        Client: HttpClient;
        FileName: Text;
        HttpGetRequestErr: Label 'Failed to contact the address endpoint.';
        HttpReadResponseErr: Label 'Failed to read response.';
        PackageIsBeingDownloadedTxt: Label 'Downloading rapidstart from web...';
        PackageMissingErr: Label 'There is no package available for download for selected country.';
        Text001Err: Label 'Failed to contact the address endpoint.';
        MissingUrlErr: Label 'Please enter valid url address';

}

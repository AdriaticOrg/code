codeunit 13062817 "Wizard Management-Adl"
{
    procedure ReadFromHttp(url: Text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        httpResponse: HttpResponseMessage;
        httpClient: HttpClient;
        InputStr: InStream;
        OutputStream: OutStream;
        index: Integer;
    begin
        If url = '' then
            ShowError();

        if (not httpClient.Get(url, httpResponse)) then
            Error(Text001Err);

        if (not httpResponse.IsSuccessStatusCode()) then
            Error(Text001Err);

        httpResponse.Content().ReadAs(InputStr);
        TempBlob.CreateOutStream(OutputStream);

        index := url.LASTINDEXOF('/');
        if index = 0 then
            ShowError();

        FileName := CopyStr(url, index + 1, StrLen(Url));
        DownloadFromStream(InputStr, 'Save rapid start file', '', 'Rapidstart Files(*.rapidstart)|*rapidstart', FileName);
    end;

    local procedure ShowError()
    begin
        Message(MissingUrlErr);
        Error('');
    end;

    procedure LoadConfigurationPackages(var TempBlob: Codeunit "Temp Blob")
    var
        ConfigSetupTemp: Record "Config. Setup" temporary;
        ApplyingError: Integer;
    begin
        ImportRapidStartPackageStream(TempBlob, ConfigSetupTemp);
        ApplyingError := ConfigSetupTemp.ApplyPackages();
    end;

    procedure ImportRapidStartPackageStream(VAR TempBlob: Codeunit "Temp Blob"; VAR TempConfigSetup: Record "Config. Setup" temporary)
    var
        TempBlobUncompressed: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
    begin
        IF TempConfigSetup.Get('ImportRS') THEN
            TempConfigSetup.Delete();

        TempConfigSetup.Init();
        TempConfigSetup."Primary Key" := 'ImportRS';
        TempConfigSetup."Package File Name" := 'ImportRapidStartPackageFromStream';
        TempConfigSetup.Insert();
        TempConfigSetup.DecompressPackageToBlob(TempBlob, TempBlobUncompressed);
        TempBlobUncompressed.CreateInStream(InStream);
        TempConfigSetup."Package File".CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
        Clear(InStream);
        TempConfigSetup."Package File".CREATEINSTREAM(InStream);

        TempConfigSetup.CalcFields("Package File");
        TempConfigSetup.SetHideDialog(true);
        TempConfigSetup.ReadPackageHeaderFromStream(InStream);
        TempConfigSetup.ImportPackageFromStream(InStream);
    end;

    procedure OpenRapidStartPackageStream(var ConfigSetup: Record "Config. Setup"): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
        TempBlobUncompressed: Codeunit "Temp Blob";
        FileMgmt: Codeunit "File Management";
        ConfigXMLExchange: Codeunit "Config. XML Exchange";
        PackageFileName: Text;
        SelectPackageTxt: Label 'Select a package file.';
        InStream: InStream;
        OutStream: OutStream;
    begin
        PackageFileName := FileMgmt.BLOBImportWithFilter(
                                TempBlob, SelectPackageTxt, '', ConfigXMLExchange.GetFileDialogFilter(), 'rapidstart');
        ConfigSetup."Package File Name" := CopyStr(
                                                PackageFileName, 1, MaxStrLen(ConfigSetup."Package File Name"));
        if ConfigSetup."Package File Name" <> '' then begin
            ConfigSetup.DecompressPackageToBlob(TempBlob, TempBlobUncompressed);
            TempBlobUncompressed.CreateInStream(InStream);
            ConfigSetup."Package File".CreateOutStream(OutStream);
            CopyStream(OutStream, InStream);
            Clear(InStream);
            ConfigSetup.ReadPackageHeaderFromStream(InStream);
            exit(true);
        end else
            exit(false);
    end;

    procedure CompleteWizard(var ConfigSetup: Record "Config. Setup"; var TempBlob: Codeunit "Temp Blob"): Boolean
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
        FileName: Text;
        Text001Err: Label 'Failed to contact the address endpoint.';
        MissingUrlErr: Label 'Please enter valid url address';

}

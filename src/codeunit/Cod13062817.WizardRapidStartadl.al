codeunit 13062817 "Wizard RapidStart-adl"
{
    trigger OnRun()
    begin
        Message(ReadFromHttp('https://github.com/AdriaticOrg/setup/raw/master/PackageAPP%20SETUP%20-%20SI.rapidstart'));
    end;

    procedure ReadFromHttp(url: Text): Text
    var
        httpCli: HttpClient;
        httpResponse: HttpResponseMessage;
        ResponseString: text;
    begin
        if (not httpCli.Get(url, httpResponse)) then
            Error('Failed to contact the address endpoint.');

        if (not httpResponse.IsSuccessStatusCode()) then
            Error('Failed to read response.');

        httpResponse.Content().ReadAs(ResponseString);
        exit(ResponseString);
    end;

    procedure ReadFromHttp(ConfigSetup: record "Config. Setup")
    var
        TempBlob: Record TempBlob temporary;
        httpResponse: HttpResponseMessage;
        InputStr: InStream;
        OutputStream: OutStream;
        Window: Dialog;
        FileName: Text;
        Url: Text;
        PackageName: Text;
    begin
        case ConfigSetup."Country/Region Code" of
            'SI':
                PackageName := 'BASIC%20SETUP_SI';
            'HR':
                PackageName := 'BASIC%20SETUP_HR';
            'RS':
                PackageName := 'BASIC%20SETUP_RS';
            else begin
                    Message(PackageMissingErr);
                    Error('');
                end;
        end;
        Url := 'https://github.com/AdriaticOrg/setup/blob/master/' + PackageName + '.rapidstart';
        Url := 'https://raw.githubusercontent.com/AdriaticOrg/setup/master/README.md';
        Message(Url);

        if (not Client.Get(Url, httpResponse)) then
            Error(HttpGetRequestErr);

        if (not httpResponse.IsSuccessStatusCode()) then
            Error(HttpReadResponseErr);

        Window.Open(PackageIsBeingDownloadedTxt);
        httpResponse.Content().ReadAs(InputStr);
        TempBlob.Blob.CreateOutStream(OutputStream);
        Window.Close();

        //CopyStream(OutputStream, InputStr);
        //DownloadFromStream(InputStr, '', 'C:\', '', FileName);
        //UploadIntoStream('', 'c:\', '', FileName, InputStr);
        LoadConfigurationPackages(TempBlob);
    end;

    procedure LoadFromFile()
    var
        TempBlob: Record TempBlob temporary;
        FileMgmt: Codeunit "File Management";
    begin
        FileMgmt.BLOBImportWithFilter(TempBlob, 'import rapidstart file', '', 'Rapidstart Files(*.rapidstart)|*.rapidstart', 'rapidstart');
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

    //------- GO -----------//
    procedure FillCompanyData()
    var
    begin

    end;


    var
        ZipStream: Codeunit "Zip Stream Wrapper";
        Client: HttpClient;
        Content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        FileName: Text;
        FileUrl: Text;
        HttpGetRequestErr: Label 'Failed to contact the address endpoint.';
        HttpReadResponseErr: Label 'Failed to read response.';
        PackageIsBeingDownloadedTxt: Label 'Downloading rapidstart from web...';
        PackageMissingErr: Label 'There is no package available for download for selected country.';
}

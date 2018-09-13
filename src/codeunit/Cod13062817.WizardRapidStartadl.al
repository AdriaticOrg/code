codeunit 13062817 "Wizard RapidStart-adl"
{
    trigger OnRun()
    begin
        //FileName := 'BASIC%20SETUP_HR';
        FileName := 'BASIC%20SETUP_SI';
        FileUrl := 'https://github.com/AdriaticOrg/setup/blob/master/' + format(FileName) + '.rapidstart';
        ReadFromHttp(FileUrl);
    end;

    procedure ReadFromHttp(url: Text)
    var
        httpResponse: HttpResponseMessage;
        InputStr: InStream;
        OutputStream: OutStream;
        FileExt: text;
    begin
        if (not Client.Get(url, httpResponse)) then
            Error(HttpGetRequestErr);

        if (not httpResponse.IsSuccessStatusCode()) then
            Error(HttpReadResponseErr);

        httpResponse.Content().ReadAs(InputStr);
        TempBlob.Blob.CreateOutStream(OutputStream);
        CopyStream(OutputStream, InputStr);
        TempBlob.Insert();

        //DownloadFromStream(InputStr, '', 'C:\', '', FileName);
        //UploadIntoStream('', 'c:\', '', FileName, InputStr);
        LoadConfigurationPackages(TempBlob);
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
        // TempBlob contains the compressed .rapidstart file
        // Decompress the file and put into the TempBlobUncompressed blob
        TempConfigSetup.DecompressPackageToBlob(TempBlob, TempBlobUncompressed);

        TempConfigSetup."Package File" := TempBlobUncompressed.Blob;
        TempConfigSetup."Package File".CREATEINSTREAM(InStream);
        TempConfigSetup.CalcFields("Package File");
        TempConfigSetup.SetHideDialog(true);
        TempConfigSetup.ReadPackageHeaderFromStream(InStream);
        TempConfigSetup.ImportPackageFromStream(InStream);

    end;


    var
        TempBlob: Record TempBlob temporary;
        ZipStream: Codeunit "Zip Stream Wrapper";
        Client: HttpClient;
        Content: HttpContent;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        FileName: Text;
        FileUrl: Text;
        HttpGetRequestErr: Label 'Failed to contact the address endpoint.';
        HttpReadResponseErr: Label 'Failed to read response.';
}

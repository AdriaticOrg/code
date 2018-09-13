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
        TempBlob.Blob.CREATEOUTSTREAM(OutputStream);
        COPYSTREAM(OutputStream, InputStr);
        LoadConfigurationPackages(TempBlob);
    end;

    procedure LoadConfigurationPackages(var TempBlob: Record TempBlob)
    var
        ConfigSetupTemp: Record "Config. Setup" temporary;
        ConfigPackageImport: Codeunit "Config. Package - Import";
        ApplyingError: Integer;
    begin
        ConfigPackageImport.ImportRapidStartPackageStream(TempBlob, ConfigSetupTemp);
        ApplyingError := ConfigSetupTemp.ApplyPackages();
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

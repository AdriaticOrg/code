codeunit 13062817 "Wizard RapidStart-adl"
{
    trigger OnRun()
    begin
        Message(ReadFromHttp('https://raw.githubusercontent.com/AdriaticOrg/setup/master/README.md'));
    end;

    procedure ReadFromHttp(url: Text): Text
    var
        httpClient: HttpClient;
        httpResponse: HttpResponseMessage;
        ResponseString: text;
    begin
        if (not httpClient.Get(url, httpResponse)) then
            Error(HttpGetRequestErr);

        if (not httpResponse.IsSuccessStatusCode()) then
            Error(HttpReadResponseErr);

        httpResponse.Content().ReadAs(ResponseString);

        exit(ResponseString);
    end;

    var
        HttpGetRequestErr: Label 'Failed to contact the address endpoint.';
        HttpReadResponseErr: Label 'Failed to read response.';
}

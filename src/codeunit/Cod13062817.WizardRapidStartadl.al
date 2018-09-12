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
        if (not httpClient.Get(url, httpResponse)) then begin
            Error('Failed to contact the address endpoint.');
        end;

        if (not httpResponse.IsSuccessStatusCode) then begin
            Error('Failed to read response.');
        end;

        httpResponse.Content().ReadAs(ResponseString);

        exit(ResponseString);
    end;
}

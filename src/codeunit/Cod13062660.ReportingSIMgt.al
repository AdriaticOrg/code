codeunit 13062660 "Reporting SI Mgt."
{
    procedure GetNumsFromStr(Str: Text): text
    var
        i: Integer;
        retstr: Text;
        chr: Text[1];
    begin

        FOR i := 1 TO STRLEN(Str) DO BEGIN
            chr := CopyStr(Str, i, 1);
            IF chr IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] THEN
                retstr += chr;
        END;

        exit(retstr);
    end;

    procedure SplitAddress(OrgAddress: Text[200]; VAR Street: Text[200]; VAR House: Text[100])
    var
        SpaceFound: Boolean;
        Cntr: Integer;
        Len: Integer;
        Chr: char;
        ChrStr: Text[1];

    begin
        Len := STRLEN(OrgAddress);
        Cntr := Len;
        WHILE ((NOT SpaceFound) AND (Cntr > 0)) DO BEGIN
            ChrStr := COPYSTR(OrgAddress, Cntr, 1);
            EVALUATE(Chr, ChrStr);

            IF Chr = 32 THEN BEGIN
                Street := COPYSTR(OrgAddress, 1, Cntr - 1);
                House := COPYSTR(OrgAddress, Cntr + 1);
                SpaceFound := TRUE;
            END;
            Cntr -= 1;
        end;
    END;

    procedure SplitUserName(SrcName: Text[200]; var Name: text[200]; var SurName: Text[200])
    var
        SpaceFound: Boolean;
        Cntr: Integer;
        Len: Integer;
        Chr: char;
        ChrStr: Text[1];
    begin
        Len := STRLEN(SrcName);
        Cntr := 1;
        WHILE ((NOT SpaceFound) AND (Cntr < Len)) DO BEGIN
            ChrStr := COPYSTR(SrcName, Cntr, 1);
            EVALUATE(Chr, ChrStr);

            IF Chr = 32 THEN BEGIN
                Name := COPYSTR(SrcName, 1, Cntr - 1);
                SurName := COPYSTR(SrcName, Cntr + 1);
                SpaceFound := TRUE;
            end;
            Cntr += 1;
        end;
    end;

    procedure GetUser(var UserSetup: Record "User Setup"; UserID: Code[59])
    begin
        UserSetup.get(UserID);
        UserSetup.TestField("Reporting_SI Name-Adl");
        UserSetup.TestField("Reporting_SI Email-Adl");
        UserSetup.TestField("Reporting_SI Phone-Adl");
        UserSetup.TestField("Reporting_SI Position-Adl");
    end;
}

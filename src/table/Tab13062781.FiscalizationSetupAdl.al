table 13062781 "Fiscalization Setup-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; code[10])
        {
            DataClassification = SystemMetadata;

        }
        field(2; Active; Boolean)
        {
            DataClassification = SystemMetadata;
        }

        field(3; "Start Date"; Date)
        {
            DataClassification = SystemMetadata;

        }
        field(4; "End Date"; Date)
        {
            DataClassification = SystemMetadata;

        }
        field(5; "Default Fiscalization Location"; code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Fiscalization Location-Adl";
        }
        field(6; "Default Fiscalization Terminal"; Text[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Fiscalization Terminal-Adl";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure IsActive() Active: Boolean;
    begin
        IF READPERMISSION() THEN
            IF GET() THEN
                EXIT(Active);
    end;

    procedure IsVisible() Active: Boolean;
    begin
        IF READPERMISSION() THEN
            IF NOT GET() THEN
                EXIT(FALSE)
            ELSE
                EXIT(Active)
        ELSE
            EXIT(FALSE);
    end;

    procedure GetCountryCode() Code: Code[10];
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.GET();
        CompanyInformation.TESTFIELD("Country/Region Code");
        EXIT(CompanyInformation."Country/Region Code");
    end;

    procedure CountryCodeSI() Boolean: Boolean;
    begin
        EXIT(GetCountryCode() = 'SI');
    end;

    procedure CountryCodeHR() Boolean: Boolean;
    begin
        EXIT(GetCountryCode() = 'HR');
    end;

    procedure CountryCodeRS() Boolean: Boolean;
    begin
        EXIT(GetCountryCode() = 'RS');
    end;
    // </adl.20>
}
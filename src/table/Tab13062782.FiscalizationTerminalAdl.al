table 13062782 "Fiscalization Terminal-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Terminal';
    DataClassification = SystemMetadata;
    fields
    {
        field(1; "Fisc. Terminal Code"; Text[30])
        {
            Caption = 'Fisc. Terminal Code';
            NotBlank = True;
            Description = 'Terminal Code';
            DataClassification = SystemMetadata;
        }

        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }

        field(3; "Fisc. No. Series"; code[20])
        {
            Caption = 'Fisc. No. Series';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            trigger Onvalidate()
            var
                FiscTerminal: Record "Fiscalization Terminal-Adl";
                Err001Txt: Label 'Serial No. %1 is already used for Room %2 and Cash Desk %3.';
            begin
                FiscTerminal.SETFILTER("Fisc. Terminal Code", '<>%1', "Fisc. Terminal Code");
                FiscTerminal.SETRANGE("Fisc. No. Series", "Fisc. No. Series");
                IF FiscTerminal.FINDFIRST() THEN
                    ERROR(Err001Txt, "Fisc. No. Series", FiscTerminal."Fisc. Location Code", FiscTerminal."Fisc. Terminal Code");
            end;
        }
        field(4; "Fisc. Location Code"; code[10])
        {
            Caption = 'Fisc. Location Code';
            TableRelation = "Fiscalization Location-Adl";
            DataClassification = SystemMetadata;
        }
        field(5; "User ID"; code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        field(7; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = False;
            DataClassification = SystemMetadata;
        }
        field(8; "Creation Time"; Time)
        {
            Caption = 'Creation Time';
            Editable = False;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Fisc. Terminal Code", "Fisc. Location Code", "User ID")
        {
            Clustered = true;
        }
        key(SK; Name)
        {

        }
    }

    var
        FiscalizationSetup: Record "Fiscalization Setup-Adl";

    trigger OnInsert()
    begin
        "Creation Date" := TODAY();
        "Creation Time" := Time();
    end;

    trigger OnModify()
    var
        AdlCore: Codeunit "Adl Core-Adl";
    begin
        "Creation Date" := TODAY();
        "Creation Time" := TIME();
        FiscalizationSetup.Get();
        CASE TRUE OF
            // HR
            FiscalizationSetup.CountryCodeHR():
                "User ID" := AdlCore.TrimmedUserID50();
        END;
    end;
    // </adl.20>
}
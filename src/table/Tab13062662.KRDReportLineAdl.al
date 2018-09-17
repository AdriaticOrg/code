table 13062662 "KRD Report Line-Adl"
{
    Caption = 'KRD Report Line';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "KRD Report Header-Adl"."No.";
            DataClassification = SystemMetadata;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = SystemMetadata;
        }
        field(5; "Description"; Text[120])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(10; "Affiliation Type"; Code[10])
        {
            Caption = 'Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Affiliation Type"));
        }
        field(11; "Instrument Type"; Code[10])
        {
            Caption = 'Instrument Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Instrument Type"));
        }
        field(12; "Maturity"; Code[10])
        {
            Caption = 'Maturity';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const (Maturity));
        }
        field(13; "Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'Claim/Liability';
            DataClassification = SystemMetadata;
        }
        field(14; "Non-Residnet Sector Code"; Code[10])
        {
            Caption = 'Non-Resident Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Sector-Adl" where ("Type" = const (Posting));
        }
        field(15; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                if Country.get("Country/Region Code") then
                    "Country/Region No." := Country."Numeric Code-Adl"
                else
                    clear("Country/Region No.");
            end;
        }
        field(16; "Country/Region No."; code[10])
        {
            Caption = 'Country/Region No.';
            DataClassification = SystemMetadata;
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                Currency: Record Currency;
            begin
                if Currency.get("Currency Code") then
                    "Currency No." := Currency."Numeric Code-Adl"
                else
                    Clear("Currency No.");
            end;
        }
        field(18; "Currency No."; Code[10])
        {
            Caption = 'Currency No.';
            DataClassification = SystemMetadata;
        }
        field(20; "Other Changes"; Decimal)
        {
            Caption = 'Other Changes';
            DataClassification = SystemMetadata;
        }
        field(30; "Opening Balance"; Decimal)
        {
            Caption = 'Opening Balance';
            DataClassification = SystemMetadata;
        }
        field(31; "Increase Amount"; Decimal)
        {
            Caption = 'Increase Amount';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                ValidateClosingBal();
            end;
        }
        field(32; "Decrease Amount"; Decimal)
        {
            Caption = 'Decrease Amount';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                ValidateClosingBal();
            end;
        }
        field(33; "Closing Balance"; Decimal)
        {
            Caption = 'Closing Balance';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestHeadStatusOpen();
    end;

    trigger OnModify()
    begin
        TestHeadStatusOpen();
    end;

    trigger OnDelete()
    begin
        TestHeadStatusOpen();
    end;

    local procedure TestHeadStatusOpen()
    var
        KRDRepHead: Record "KRD Report Header-Adl";
    begin
        KRDRepHead.TestStatusOpen("Document No.");
    end;

    var
    local procedure ValidateClosingBal()
    begin
        "Closing Balance" := "Opening Balance" + "Increase Amount" - "Decrease Amount";
    end;

}
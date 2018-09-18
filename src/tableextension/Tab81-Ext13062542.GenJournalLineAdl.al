tableextension 13062542 "Gen. Journal Line-Adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            Editable = False;
            DataClassification = SystemMetadata;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            DataClassification = SystemMetadata;
        }
        // </adl.10>
        //<adl.11>
        field(13062527; "VAT % (retrograde)-Adl"; Decimal)
        {
            Caption = 'VAT % (retrograde)';
            DataClassification = SystemMetadata;
        }
        //</adl.11>
        // <adl.24>
        field(13062641; "FAS Instrument Code-Adl"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Instrument-Adl";
        }
        field(13062642; "FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector-Adl";
        }
        field(13062643; "Bal. FAS Instrument Code-Adl"; Code[10])
        {
            Caption = 'Bal. FAS Instrument Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Instrument-Adl";
        }
        field(13062644; "Bal. FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'Bal. FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector-Adl";
        }
        field(13062645; "FAS Type-Adl"; Option)
        {
            Caption = 'FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = SystemMetadata;
        }
        field(13062646; "Bal. FAS Type-Adl"; Option)
        {
            Caption = 'Bal. FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = SystemMetadata;
        }
        // </adl.24>
        // <adl.22>
        field(13062601; "VAT Correction Date-Adl"; Date)
        {
            Caption = 'VAT Correction Date';
            DataClassification = SystemMetadata;
        }
        field(13062602; "EU Customs Procedure-Adl"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = SystemMetadata;
        }
        // </adl.22>     	 
    }
    // <adl.24>
    procedure CopyFASFields(Customer: Record Customer; AccType: Option Account,"Bal. Account")
    begin
        if AccType = AccType::Account then
            "FAS Sector Code-Adl" := Customer."FAS Sector Code-Adl"
        ELSE
            "Bal. FAS Sector Code-Adl" := Customer."FAS Sector Code-Adl";
    end;

    procedure CopyFASFields(Vendor: Record Vendor; AccType: Option Account,"Bal. Account")
    begin
        IF AccType = AccType::Account then
            "FAS Sector Code-Adl" := Vendor."FAS Sector Code-Adl"
        else
            "Bal. FAS Sector Code-Adl" := Vendor."FAS Sector Code-Adl";
    end;

    procedure CopyFASFields(GLAccount: Record "G/L Account"; AccType: Option Account,"Bal. Account")
    begin
        if AccType = AccType::"Bal. Account" then begin
            "FAS Sector Code-Adl" := GLAccount."FAS Sector Code-Adl";
            "FAS Instrument Code-Adl" := GLAccount."FAS Instrument Code-Adl";
        end else begin
            "Bal. FAS Sector Code-Adl" := GLAccount."FAS Sector Code-Adl";
            "Bal. FAS Instrument Code-Adl" := GLAccount."FAS Instrument Code-Adl";
        end;
    end;

    procedure CopyFASFields(BankAccount: Record "Bank Account"; AccType: Option Account,"Bal. Account")
    begin
        if AccType then begin
            "FAS Sector Code-Adl" := BankAccount."FAS Sector Code-Adl";
            "FAS Instrument Code-Adl" := BankAccount."FAS Instrument Code-Adl";
        end else begin
            "Bal. FAS Sector Code-Adl" := BankAccount."FAS Sector Code-Adl";
            "Bal. FAS Instrument Code-Adl" := BankAccount."FAS Instrument Code-Adl";
        end;
    end;
    // </adl.24>
    // <adl.22>
    procedure CopyVIESFields(SalesHeader: Record "Sales Header")
    begin
        "VAT Correction Date-Adl" := SalesHeader."VAT Correction Date-Adl";
        "EU Customs Procedure-Adl" := SalesHeader."EU Customs Procedure-Adl";
    end;
    // </adl.22>
    // <adl.26>
    procedure CopyBSTFields(Customer: Record Customer)
    begin
        "Country/Region Code" := Customer."Country/Region Code";
    end;

    procedure CopyBSTFields(Vendor: Record Vendor)
    begin
        "Country/Region Code" := Vendor."Country/Region Code";
    end;

    procedure CopyBSTFields(BankAccount: Record "Bank Account")
    begin
        "Country/Region Code" := BankAccount."Country/Region Code";
    end;
    // </adl.26>    
}
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

        // <adl.20>    
        field(13062781; "Full Fisc. Doc. No.-Adl"; Code[20])
        {
            Caption = 'Full Fisc. Doc. No.';
            DataClassification = SystemMetadata;
        }
        // </adl.20>       	 
    }
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
    // <adl.24>
    procedure CopyFASFields(Customer: Record Customer)
    begin
        if ("Account Type" = "Account Type"::Customer) and ("Account No." = Customer."No.") then
            "FAS Sector Code-Adl" := Customer."FAS Sector Code-Adl";
        if ("Bal. Account Type" = "Bal. Account Type"::Customer) and ("Bal. Account No." = Customer."No.") then
            "Bal. FAS Sector Code-Adl" := Customer."FAS Sector Code-Adl";
    end;

    procedure CopyFASFields(Vendor: Record Vendor)
    begin
        if ("Account Type" = "Account Type"::Vendor) and ("Account No." = Vendor."No.") then
            "FAS Sector Code-Adl" := Vendor."FAS Sector Code-Adl";
        if ("Bal. Account Type" = "Bal. Account Type"::Vendor) and ("Bal. Account No." = Vendor."No.") then
            "Bal. FAS Sector Code-Adl" := Vendor."FAS Sector Code-Adl";
    end;

    procedure CopyFASFields(GLAccount: Record "G/L Account")
    begin
        if ("Account Type" = "Account Type"::"G/L Account") and ("Account No." = GLAccount."No.") then begin
            "FAS Sector Code-Adl" := GLAccount."FAS Sector Code-Adl";
            "FAS Instrument Code-Adl" := GLAccount."FAS Instrument Code-Adl";
        end;
        if ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") and ("Bal. Account No." = GLAccount."No.") then begin
            "Bal. FAS Sector Code-Adl" := GLAccount."FAS Sector Code-Adl";
            "Bal. FAS Instrument Code-Adl" := GLAccount."FAS Instrument Code-Adl";
        end;
    end;

    procedure CopyFASFields(BankAccount: Record "Bank Account")
    begin
        if ("Account Type" = "Account Type"::"Bank Account") and ("Account No." = BankAccount."No.") then begin
            "FAS Sector Code-Adl" := BankAccount."FAS Sector Code-Adl";
            "FAS Instrument Code-Adl" := BankAccount."FAS Instrument Code-Adl";
        end;
        if ("Bal. Account Type" = "Bal. Account Type"::"Bank Account") and ("Bal. Account No." = BankAccount."No.") then begin
            "Bal. FAS Sector Code-Adl" := BankAccount."FAS Sector Code-Adl";
            "Bal. FAS Instrument Code-Adl" := BankAccount."FAS Instrument Code-Adl";
        end;
    end;
    // </adl.24>
}
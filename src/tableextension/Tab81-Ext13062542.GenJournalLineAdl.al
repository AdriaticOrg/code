tableextension 13062542 "GenJournalLine-Adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            DataClassification = ToBeClassified;
        }
        // </adl.10>
        //<adl.11>
        field(13062527; "VAT % (retrograde)-Adl"; Decimal)
        {
            Caption = 'VAT % (retrograde)';
            DataClassification = ToBeClassified;
        }
        //</adl.11>
        // <adl.24>
        field(13062641; "FAS Instrument Code"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(13062642; "FAS Sector Code"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062643; "Bal. FAS Instrument Code"; Code[10])
        {
            Caption = 'Bal. FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(13062644; "Bal. FAS Sector Code"; Code[10])
        {
            Caption = 'Bal. FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062645; "FAS Type"; Option)
        {
            Caption = 'FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = ToBeClassified;
        }
        field(13062646; "Bal. FAS Type"; Option)
        {
            Caption = 'Bal. FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = ToBeClassified;
        }
        // </adl.24>
        // <adl.22>
        field(13062601; "VAT Correction Date"; Date)
        {
            Caption = 'VAT Correction Date';
            DataClassification = ToBeClassified;
        }
        field(13062602; "EU Customs Procedure"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = ToBeClassified;
        }
        // </adl.22>     	 
    }
    // <adl.24>
    procedure CopyFASFields(Customer: Record Customer)
    begin
        "FAS Sector Code" := Customer."FAS Sector Code";
    end;

    procedure CopyFASFields(Vendor: Record Vendor)
    begin
        "FAS Sector Code" := Vendor."FAS Sector Code";
    end;

    procedure CopyFASFields(GLAccount: Record "G/L Account")
    begin
        "FAS Sector Code" := GLAccount."FAS Sector Code";
        "FAS Instrument Code" := GLAccount."FAS Instrument Code";
    end;

    procedure CopyFASFields(BankAccount: Record "Bank Account")
    begin
        "FAS Sector Code" := BankAccount."FAS Sector Code";
        "FAS Instrument Code" := BankAccount."FAS Instrument Code";
    end;
    // </adl.24>
    // <adl.22>
    procedure CopyVIESFields(SalesHeader: Record "Sales Header")
    begin
        "VAT Correction Date" := SalesHeader."VAT Correction Date";
        "EU Customs Procedure" := SalesHeader."EU Customs Procedure";
    end;
    // </adl.22>
}
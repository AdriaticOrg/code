table 13062813 "Extended Setup-Adl"
{
    Caption = 'Adriatic Extended Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        // <adl.6>
        field(13062525; "VAT Enabled"; Boolean)
        {
            Caption = 'Enable Adriatic VAT Extension';
            DataClassification = SystemMetadata;
        }
        field(13062526; "Use VAT Output Date"; Boolean)
        {
            Caption = 'Use VAT Output Date';
            DataClassification = SystemMetadata;
        }
        // </adl.6>

        // <adl.16>
        field(13062571; "Forced Credit/Debit Enabled"; Boolean)
        {
            Caption = 'Forced Credit/Debit Enabled';
            DataClassification = SystemMetadata;
        }
        // </adl.16>

        // <adl.28>
        field(13062741; "Unpaid Receivables Enabled"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062742; "Ext. Data Start Bal. Date"; Date)
        {
            Caption = 'Extended Data Start Balance Date';
            DataClassification = SystemMetadata;
        }
        // </adl.28>
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        AdlCore: Codeunit "Adl Core-Adl";
    begin
        with SalesReceivablesSetup do begin
            if not Get() then Insert();
            "Ext. Data Start Bal. Date-Adl" := Rec."Ext. Data Start Bal. Date";
            Modify();
        end;

        with AdlCore do begin
            EnableOrDisableFeature("ADLFeatures-Adl"::VAT, Rec."VAT Enabled");
            EnableOrDisableFeature("ADLFeatures-Adl"::UnpaidReceivables, Rec."Unpaid Receivables Enabled");
        end;
    end;

    procedure ModifyExtDataStartBalDate(ExtDataStartBalDate: Date)
    begin
        if not Get() then Insert();
        "Ext. Data Start Bal. Date" := ExtDataStartBalDate;
        Modify();
    end;
}
table 13062743 "Unpaid Receivables Setup-Adl"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        // <adl.13>
        field(13062741; "Ext. Data Start Bal. Date-Adl"; Date)
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

    trigger OnInsert()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.EnableFeature(CoreSetup."ADL Features"::VIES);
    end;

    trigger OnDelete()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.DisableFeature(CoreSetup."ADL Features"::VIES);
    end;

    trigger OnModify()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        with SalesReceivablesSetup do begin
            if not Get() then Insert();
            "Ext. Data Start Bal. Date-Adl" := Rec."Ext. Data Start Bal. Date-Adl";
            Modify();
        end;
    end;

    procedure ModifyExtDataStartBalDate(ExtDataStartBalDate: Date)
    begin
        if not Get() then Insert();
        "Ext. Data Start Bal. Date-Adl" := ExtDataStartBalDate;
        Modify();
    end;
}
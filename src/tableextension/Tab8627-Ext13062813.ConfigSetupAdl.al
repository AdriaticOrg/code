tableextension 13062813 "Config. Setup-Adl" extends "Config. Setup" //8627
{
    fields
    {
        field(13062811; "ADL Enabled-Adl"; Boolean)
        {
            Caption = 'ADL Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062812; "VAT Enabled-Adl"; Boolean)
        {
            Caption = 'VAT Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062816; "FAS Enabled-Adl"; Boolean)
        {
            Caption = 'FAS Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062817; "KRD Enabled-Adl"; Boolean)
        {
            Caption = 'KRD Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062818; "BST Enabled-Adl"; Boolean)
        {
            Caption = 'BST Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062819; "VIES Enabled-Adl"; Boolean)
        {
            Caption = 'VIES Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062820; "Unpaid Receivables Enabled-Adl"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062821; "PDO Enabled-Adl"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
            ObsoleteState = Removed;
            ObsoleteReason = 'redesign';
        }
        field(13062822; "Forced Credit/Debit Enabled-Adl"; Boolean)
        {
            Caption = 'Force Credit/Debit';
            DataClassification = SystemMetadata;
            //ObsoleteState = Removed;
            //osoleteReason = 'redesign';
        }

        /* VAT */
        field(13062823; "Use VAT Output Date-Adl"; Boolean)
        {
            Caption = 'Use VAT Output Date';
            DataClassification = SystemMetadata;
        }

        /* VIES */
        field(13062824; "VIES Report No. Series-Adl"; Code[20])
        {
            Caption = 'VIES Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(13062825; "VIES Resp. User ID-Adl"; Text[100])
        {
            Caption = 'VIES Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062826; "Default VIES Country-Adl"; Option)
        {
            Caption = 'Default VIES Country';
            OptionMembers = " ",Slovenia,Croatia;
            OptionCaption = ' ,Slovenia,Croatia';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                clear("Default VIES Type-Adl");
            end;
        }
        field(13062827; "Default VIES Type-Adl"; Option)
        {
            OptionMembers = " ",ZP,"PDV-S";
            OptionCaption = ' ,ZP,PDV-S';
            Caption = 'Default VIES Type';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Default VIES Type-Adl" <> "Default VIES Type-Adl"::" " then
                    TestField("Default VIES Country-Adl", "Default VIES Country-Adl"::Croatia);
            end;
        }
        field(13062828; "VIES Prep. By User ID-Adl"; Text[100])
        {
            Caption = 'VIES Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062829; "VIES Company Branch Code-Adl"; Text[30])
        {
            Caption = 'VIES Company Branch Code';
            DataClassification = SystemMetadata;
        }

        /* PDO */
        field(13062830; "PDO Report No. Series-Adl"; Code[20])
        {
            Caption = 'PDO Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(13062831; "PDO Resp. User ID-Adl"; Text[100])
        {
            Caption = 'PDO Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062832; "PDO VAT Ident. Filter Code-Adl"; Code[100])
        {
            Caption = 'PDO VAT Ident. Filter Code ';
            DataClassification = SystemMetadata;
            TableRelation = "VAT Identifier-Adl";
            ValidateTableRelation = false;
        }
        field(13062833; "PDO Prep. By User ID-Adl"; Text[100])
        {
            Caption = 'PDO Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        /* FAS */
        field(13062834; "FAS Report No. Series-Adl"; Code[20])
        {
            Caption = 'FAS Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(13062835; "FAS Resp. User ID-Adl"; Text[100])
        {
            Caption = 'FAS Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062836; "FAS Prep. By User ID-Adl"; Text[100])
        {
            Caption = 'FAS Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062837; "FAS Budget User Code-Adl"; Code[10])
        {
            Caption = 'Budget User Code';
            DataClassification = SystemMetadata;
        }
        field(13062838; "FAS Company Sector Code-Adl"; Code[10])
        {
            Caption = 'Company Sector Code';
            TableRelation = "FAS Sector-Adl" where ("Type" = const (Posting));
            DataClassification = SystemMetadata;
        }
        field(13062839; "FAS Director User ID-Adl"; Text[100])
        {
            Caption = 'FAS Director User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        /* KRD */
        field(13062840; "KRD Report No. Series-Adl"; Code[20])
        {
            Caption = 'KRD Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(13062841; "Default KRD Affiliation Type-Adl"; Code[10])
        {
            Caption = 'Default KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Affiliation Type"));
        }
        field(13062842; "KRD Resp. User ID-Adl"; Text[100])
        {
            Caption = 'KRD Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062843; "KRD Blank LCY Code-Adl"; Code[20])
        {
            Caption = 'KRD Blank LCY Code';
            DataClassification = SystemMetadata;
        }
        field(13062844; "KRD Blank LCY Num.-Adl"; Text[10])
        {
            Caption = 'KRD Blank LCY Num.';
            DataClassification = SystemMetadata;
        }

        field(13062845; "KRD Prep. By User ID-Adl"; Text[100])
        {
            Caption = 'KRD Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        /* BST */
        field(13062846; "BST Report No. Series-Adl"; Code[20])
        {
            Caption = 'BST Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(13062847; "BST Resp. User ID-Adl"; Text[100])
        {
            Caption = 'BST Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(13062848; "BST Prep. By User ID-Adl"; Text[100])
        {
            Caption = 'BST Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        /* Unpaid Receivables*/
        field(13062849; "UP Ext. Data Start Bal. Date-Adl"; Date)
        {
            Caption = 'Extended Data Start Balance Date';
            DataClassification = SystemMetadata;
        }

        /* Fiscalization */
        field(13062850; "Fiscal. Active-Adl"; Boolean)
        {
            Caption = 'Active';
            DataClassification = SystemMetadata;
        }

        field(13062851; "Fiscal. Start Date-Adl"; Date)
        {
            Caption = 'Start Date';
            DataClassification = SystemMetadata;

        }
        field(13062852; "Fiscal. End Date-Adl"; Date)
        {
            Caption = 'End Date';
            DataClassification = SystemMetadata;

        }
        field(13062853; "Fiscal. Default Fiscalization Location-Adl"; code[10])
        {
            Caption = 'Default Location';
            DataClassification = SystemMetadata;
            TableRelation = "Fiscalization Location-Adl";
        }
        field(13062854; "Fiscal. Default Fiscalization Terminal-Adl"; Text[30])
        {
            Caption = 'Default Terminal';
            DataClassification = SystemMetadata;
            TableRelation = "Fiscalization Terminal-Adl";
        }
    }

    procedure CopySetupData()
    var
        VATSetup: Record "VAT Setup-Adl";
        VIESSetup: Record "VIES Setup-Adl";
        PDOSetup: Record "PDO Setup-Adl";
        FASSetup: Record "FAS Setup-Adl";
        KRDSetup: Record "KRD Setup-Adl";
        BSTSetup: Record "BST Setup-Adl";
        UnpaidRecSetup: Record "Unpaid Receivables Setup-Adl";
        FiscalSetup: Record "Fiscalization Setup-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        CoreEnabled: Boolean;
    begin
        if not VATSetup.get() then
            VATSetup.Insert(true);
        VATSetup."Use VAT Output Date-Adl" := "Use VAT Output Date-Adl";
        VATSetup.Modify();

        if not VIESSetup.get() then
            CoreEnabled := VIESSetup.Insert(true);
        VIESSetup."Default VIES Country" := "Default VIES Country-Adl";
        VIESSetup."Default VIES Type" := "Default VIES Type-Adl";
        VIESSetup."VIES Company Branch Code" := "VIES Company Branch Code-Adl";
        VIESSetup."VIES Prep. By User ID" := "VIES Prep. By User ID-Adl";
        VIESSetup."VIES Report No. Series" := "VIES Report No. Series-Adl";
        VIESSetup."VIES Resp. User ID" := "VIES Resp. User ID-Adl";
        VIESSetup.Modify();

        if not PDOSetup.get() then
            CoreEnabled := PDOSetup.Insert(true);
        PDOSetup."PDO Prep. By User ID" := "PDO Prep. By User ID-Adl";
        PDOSetup."PDO Report No. Series" := "PDO Report No. Series-Adl";
        PDOSetup."PDO Resp. User ID" := "PDO Resp. User ID-Adl";
        PDOSetup."PDO VAT Ident. Filter Code" := "PDO VAT Ident. Filter Code-Adl";
        PDOSetup.Modify();

        if not FASSetup.get() then
            CoreEnabled := FASSetup.Insert(true);
        FASSetup."FAS Prep. By User ID" := "FAS Prep. By User ID-Adl";
        FASSetup."FAS Report No. Series" := "FAS Report No. Series-Adl";
        FASSetup."FAS Resp. User ID" := "FAS Resp. User ID-Adl";
        FASSetup."Budget User Code" := "FAS Budget User Code-Adl";
        FASSetup."Company Sector Code" := "FAS Company Sector Code-Adl";
        FASSetup."FAS Director User ID" := "FAS Director User ID-Adl";
        FASSetup.Modify();

        if not KRDSetup.get() then
            CoreEnabled := KRDSetup.Insert(true);
        KRDSetup."KRD Prep. By User ID" := "KRD Prep. By User ID-Adl";
        KRDSetup."KRD Report No. Series" := "KRD Report No. Series-Adl";
        KRDSetup."KRD Resp. User ID" := "KRD Resp. User ID-Adl";
        KRDSetup."Default KRD Affiliation Type" := "Default KRD Affiliation Type-Adl";
        KRDSetup."KRD Blank LCY Code" := "KRD Blank LCY Code-Adl";
        KRDSetup."KRD Blank LCY Num." := "KRD Blank LCY Num.-Adl";
        KRDSetup.Modify();

        if not BSTSetup.get() then
            CoreEnabled := BSTSetup.Insert(true);
        BSTSetup."BST Prep. By User ID" := "BST Prep. By User ID-Adl";
        BSTSetup."BST Report No. Series" := "BST Report No. Series-Adl";
        BSTSetup."BST Resp. User ID" := "BST Resp. User ID-Adl";
        BSTSetup.Modify();

        if not UnpaidRecSetup.get() then
            CoreEnabled := UnpaidRecSetup.Insert(true);
        UnpaidRecSetup."Ext. Data Start Bal. Date-Adl" := "UP Ext. Data Start Bal. Date-Adl";
        UnpaidRecSetup.Modify();

        if not FiscalSetup.get() then
            CoreEnabled := FiscalSetup.Insert(true);
        FiscalSetup.Active := "Fiscal. Active-Adl";
        FiscalSetup."Default Fiscalization Location" := "Fiscal. Default Fiscalization Location-Adl";
        FiscalSetup."Default Fiscalization Terminal" := "Fiscal. Default Fiscalization Terminal-Adl";
        FiscalSetup."Start Date" := "Fiscal. Start Date-Adl";
        FiscalSetup."End Date" := "Fiscal. End Date-Adl";
        FiscalSetup.Modify();

        if not CoreEnabled then
            If "ADL Enabled-Adl" then
                CoreSetup."ADL Enabled" := "ADL Enabled-Adl";
        Commit();
    end;
}
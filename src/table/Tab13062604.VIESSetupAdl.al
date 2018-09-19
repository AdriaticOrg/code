table 13062604 "VIES Setup-Adl"
{
    Caption = 'VIES Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(40; "VIES Report No. Series"; Code[20])
        {
            Caption = 'VIES Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(42; "VIES Resp. User ID"; Text[100])
        {
            Caption = 'VIES Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(43; "Default VIES Country"; Option)
        {
            Caption = 'Default VIES Country';
            OptionMembers = " ",Slovenia,Croatia;
            OptionCaption = ' ,Slovenia,Croatia';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                clear("Default VIES Type");
            end;
        }
        field(44; "Default VIES Type"; Option)
        {
            OptionMembers = " ",ZP,"PDV-S";
            OptionCaption = ' ,ZP,PDV-S';
            Caption = 'Default VIES Type';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Default VIES Type" <> "Default VIES Type"::" " then
                    TestField("Default VIES Country", "Default VIES Country"::Croatia);
            end;
        }
        field(45; "VIES Prep. By User ID"; Text[100])
        {
            Caption = 'VIES Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(46; "VIES Company Branch Code"; Text[30])
        {
            Caption = 'VIES Company Branch Code';
            DataClassification = SystemMetadata;
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
}
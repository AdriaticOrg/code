table 13062602 "VIES Report Line-Adl"
{
    Caption = 'VIES Report Line';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "VIES Report Header-Adl"."No.";
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
        field(6; "Source Type"; Option)
        {
            OptionMembers = " ",Sales,Purchases;
            OptionCaption = ' ,Sales,Purchases';
            Caption = 'Source Type';
            DataClassification = SystemMetadata;
        }

        field(10; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = New,Correction;
            OptionCaption = 'New,Correction';
            DataClassification = SystemMetadata;
        }
        field(14; "Applies-to Report No."; Code[20])
        {
            Caption = 'Applies-to Report No.';
            DataClassification = SystemMetadata;
        }
        field(20; "Period Year"; Integer)
        {
            Caption = 'Period Year';
            DataClassification = SystemMetadata;
        }
        field(21; "Period Round"; Integer)
        {
            Caption = 'Period Round';
            DataClassification = SystemMetadata;
        }

        field(24; "Country/Region Code"; Code[10])
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
        field(25; "Country/Region No."; code[10])
        {
            Caption = 'Country/Region No.';
            DataClassification = SystemMetadata;
        }
        field(30; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = SystemMetadata;
        }
        field(34; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            DataClassification = SystemMetadata;
        }
        field(35; "EU Customs Procedure"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = SystemMetadata;
        }
        field(38; "EU Sales Type"; Option)
        {
            Caption = 'EU Sales Type';
            OptionMembers = Goods,Services;
            OptionCaption = 'Goods,Services';
            DataClassification = SystemMetadata;
        }

        field(45; "Amount"; Decimal)
        {
            Caption = 'Amount';
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
        SetSurceType();
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
        VIESRepHead: Record "VIES Report Header-Adl";
    begin
        VIESRepHead.TestStatusOpen("Document No.");
    end;

    local procedure SetSurceType()
    var
        ViesRepHead: Record "VIES Report Header-Adl";
    begin
        ViesRepHead.get("Document No.");
        ViesRepHead.TestField("VIES Country");

        if ViesRepHead."VIES Country" = ViesRepHead."VIES Country"::Croatia then
            ViesRepHead.TestField("VIES Type");

        "Source Type" := "Source Type"::Sales;

        if (ViesRepHead."VIES Country" = ViesRepHead."VIES Country"::Croatia) and
            (ViesRepHead."VIES Type" = ViesRepHead."VIES Type"::"PDV-S")
        then
            "Source Type" := "Source Type"::Purchases;
    end;

}
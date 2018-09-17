table 13062622 "PDO Report Line-Adl"
{
    Caption = 'PDO Report Line';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "PDO Report Header-Adl"."No.";
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
        field(23; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = SystemMetadata;
            TableRelation = "VAT Identifier-Adl";
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
        field(45; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
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
        PDORepHead: Record "PDO Report Header-Adl";
    begin
        PDORepHead.TestStatusOpen("Document No.");
    end;

}
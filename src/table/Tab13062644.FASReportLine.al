table 13062644 "FAS Report Line"
{
    Caption = 'FAS Report Line';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "FAS Report Header"."No.";
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
        field(6; "FAS Type"; Option)
        {
            Caption = 'FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = SystemMetadata;
        }
        field(10; "AOP Code"; Code[10])
        {
            Caption = 'AOP Code';
            DataClassification = SystemMetadata;
        }
        field(11; "Sector Code"; Code[10])
        {
            Caption = 'Sector Code';
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
            DataClassification = SystemMetadata;
        }
        field(12; "Instrument Code"; Code[10])
        {
            TableRelation = "FAS Instrument" where ("Type" = const (Posting));
            Caption = 'Instrument Code';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                Instrument: Record "FAS Instrument";
            begin
                if Instrument.get("Instrument Code") then begin
                    Description := Instrument.Description;
                    "AOP Code" := Instrument."AOP Code";
                end else
                    Clear(Description);
            end;
        }

        //obsolete, delete field Amount
        field(15; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = SystemMetadata;
        }
        field(16; "Period Closing Balance"; Decimal)
        {
            Caption = 'Period Closing Balance';
            DataClassification = SystemMetadata;
        }
        field(17; "Transactions Amt. in Period"; Decimal)
        {
            Caption = 'Transactions Amt. in Period';
            DataClassification = SystemMetadata;
        }
        field(18; "Changes Amt. in Period"; Decimal)
        {
            Caption = 'Changes Amt. in Period';
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
        FASRepHead: Record "FAS Report Header";
    begin
        FASRepHead.TestStatusOpen("Document No.");
    end;
}

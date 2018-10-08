tableextension 13062526 "Purchase Header-Adl" extends "Purchase Header"  //38
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = SystemMetadata;
            trigger OnValidate();
            begin
                if "VAT Date-Adl" <> "Posting Date" then
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT"
                else
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Realized VAT";
            end;
        }
        field(13062527; "VAT Output Date-Adl"; Date)
        {
            Caption = 'VAT Output Date';
            DataClassification = SystemMetadata;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            OptionCaption = 'Realized VAT,Postponed VAT';
            DataClassification = SystemMetadata;
        }
        // </adl.10>
        // <adl.18>
        field(13062581; "Goods Return Type-Adl"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Goods Return Type';
            TableRelation = "Goods Return Type-Adl";
            trigger OnValidate()
            var
                GoodsReturnType: Record "Goods Return Type-Adl";
                Vendor: Record Vendor;
                GLSetup: Record "General Ledger Setup";
            begin
                IF "Goods Return Type-Adl" <> '' then begin
                    GoodsReturnType.GET("Goods Return Type-Adl");
                    GoodsReturnType.TestField("VAT Bus. Posting Group");
                    Validate("VAT Bus. Posting Group", GoodsReturnType."VAT Bus. Posting Group");
                end else begin
                    GLSetup.Get();
                    if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
                        if Vendor.GET("Pay-to Vendor No.") then
                            Validate("VAT Bus. Posting Group", Vendor."VAT Bus. Posting Group");
                    end else
                        if Vendor.GET("Buy-from Vendor No.") then
                            Validate("VAT Bus. Posting Group", Vendor."VAT Bus. Posting Group");
                end;
            end;
        }
        // </adl.18>
    }
}
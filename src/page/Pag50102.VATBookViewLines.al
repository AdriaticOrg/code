page 50102 "VAT Book View Lines"
{

    CaptionML = ENU = 'VAT Book View Lines',
                SRM = 'Redovi prikaza knjige PDV-a';
    DataCaptionFields = "VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.";
    DelayedInsert = true;
    PageType = Worksheet;
    PopulateAllFields = true;
    SourceTable = "VAT Book View Line";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field(Operator1; Operator1) { }
                field(Value1; Value1) { }
                field(Operator2; Operator2) { }
                field(Value2; Value2) { }
            }

        }
    }
}


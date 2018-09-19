page 13062596 "VAT Book View Formula-Adl"
{

    Caption = 'VAT Book View Lines';
    DataCaptionFields = "VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.";
    PageType = Worksheet;
    PopulateAllFields = true;
    SourceTable = "VAT Book View Formula-Adl";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field(Operator1; Operator1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a first operator in VAT Book View Formula.';
                }
                field(Value1; Value1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a first field value from VAT Entry, which is used in VAT Book View Formula.';
                }
                field(Operator2; Operator2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a second operator in VAT Book View Formula.';
                }
                field(Value2; Value2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a second field value from VAT Entry, which is used in VAT Book View Formula.';
                }
                field(Condition; Condition)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies aditional filters for VAT Entry, which is used in VAT Book View Formula.';
                    AssistEdit = true;
                    Editable = false;

                    trigger OnAssistEdit();
                    begin
                        if CurrPage.Editable() then begin
                            SetFiltersForVATEntry();
                            CurrPage.Update(true);
                        end;
                    end;
                }
            }

        }
    }
}


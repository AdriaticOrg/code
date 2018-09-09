report 13062593 "Export VAT Books To XML-Adl"
{
    Caption = 'Export VAT Books To XML';
    ProcessingOnly = true;


    requestpage
    {
        layout
        {
            area(content)
            {
                field("Date Filter"; DateFilter)
                {
                    Caption = 'Date Filter';
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        TextManagement: Codeunit TextManagement;
                    begin
                        TextManagement.MakeDateFilter(DateFilter);
                    end;
                }
                field("PPPDV Date"; PPPDVDate)
                {
                    Caption = 'PPPDV Date';
                    ApplicationArea = All;
                }

                field("Responsible Person"; ResponsiblePerson)
                {
                    Caption = 'Responsible Person';
                    TableRelation = "User Setup";
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnPreReport();
    begin
        IF DateFilter = '' THEN
            error(DateFilterRequiredErr);
        VATBooksExporttoXML.ExportToXML(DateFilter, PPPDVDate, ResponsiblePerson);
    end;

    var
        VATBooksExporttoXML: Codeunit "VAT Books Export to XML-Adl";
        PPPDVDate: Date;
        DateFilter: Text;
        DateFilterRequiredErr: Label 'You must enter Date Filter';
        ResponsiblePerson: Text[250];
}
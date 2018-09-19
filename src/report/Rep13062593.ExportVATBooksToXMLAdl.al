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
                    ToolTip = 'Specifies Date Filter for XML export file.';

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
                    ToolTip = 'Specifies PPPD Date for data in XML export file.';
                }

                field("Responsible Person"; ResponsiblePerson)
                {
                    Caption = 'Responsible Person';
                    TableRelation = "User Setup";
                    ApplicationArea = All;
                    ToolTip = 'Specifies Responsible Person for data in XML export file.';
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
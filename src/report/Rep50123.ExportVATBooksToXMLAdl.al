report 50123 "Export VAT Books To XML-Adl"
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
                        ApplicationManagement: Codeunit ApplicationManagement;
                    begin
                        ApplicationManagement.MakeDateFilter(DateFilter);
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
            error(Text001);
        VATBooksExporttoXML.ExportToXML(DateFilter, PPPDVDate, ResponsiblePerson);
    end;

    var
        VATBooksExporttoXML: Codeunit "VAT Books Export to XML-Adl";
        PPPDVDate: Date;
        DateFilter: Text;
        Text001: Label 'You must enter Date Filter';
        ResponsiblePerson: Text[250];
}
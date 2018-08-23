xmlport 50100 "GL Entry Export - SI-adl"
{
    // </ExportGLandVAT> 

    Caption = 'GL Entry Export - SI';
    Direction = Export;
    //Encoding = UTF8; only-for-xml
    FileName = 'IZPIS GLAVNE KNJIGE.txt';
    Format = FixedText;
    UseRequestPage = true;

    schema
    {
         textelement(root)
        {
            
            tableelement("G/L Account";"G/L Account")
            {
                RequestFilterFields = "Date Filter","No.";
                XmlName = 'GLAccount';
                SourceTableView = SORTING("No.") WHERE("Account Type"=FILTER(Posting));
                  
                textelement(No)
                {
                    Width = 10;

                }
                textelement(Name)
                {
                    Width = 50;
                }

                trigger OnAfterGetRecord();
                begin
                end;
            }

            tableelement("G/L Entry";"G/L Entry")
            {
                RequestFilterFields = "Entry No.";
                XmlName = 'GLEntry';
                SourceTableView = SORTING("Entry No.");

                textelement(PostingDate)
                {
                    Width = 10;
                    

                }
                textelement(DocumentDate)
                {
                    Width = 50;
                }

                trigger OnAfterGetRecord();
                begin

                end;
            }
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Name; 'SourceExpression')
                    {
                        
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    
                }
            }
        }
    }
}
page 13062811 "Core Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CoreSetup-Adl";
    Caption = 'Core Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("ADL Enabled"; "ADL Enabled")
                {
                    ApplicationArea = All;
                }
            }
            group(VAT)
            {
                Caption = 'VAT';
                // <adl.6>
                field("VAT Enabled"; "VAT Enabled")
                {
                    ApplicationArea = All;
                }
                // </adl.6>

                // <adl.28>
                field("Unpaid Receivables Enabled"; "Unpaid Receivables Enabled")
                {
                    ApplicationArea = All;
                }
                // </adl.28>

            }

            group(Posting)
            {
                Caption = 'Posting';
                field("Forced Credit/Debit Enabled"; "Forced Credit/Debit Enabled")
                {
                    ApplicationArea = All;
                }
            }

            group(Reporting)
            {
                Caption = 'Reporting';
                // <adl.0>
                field("Rep HR Enabled"; "Rep HR Enabled")
                {
                    ApplicationArea = All;
                }
                field("Rep RS Enabled"; "Rep RS Enabled")
                {
                    ApplicationArea = All;
                }
                field("Rep SI Enabled"; "Rep SI Enabled")
                {
                    ApplicationArea = All;
                }
                field("EU Customs"; "EU Customs")
                {
                    ApplicationArea = All;
                }
                // </adl.0>
            }
            group(ReportingSI)
            {
                Caption = 'Reporting SI';
                // <adl.24>
                field("FAS Enabled"; "FAS Enabled")
                {
                    ApplicationArea = All;
                }
                // </adl.24>
                // <adl.25>
                field("KRD Enabled"; "KRD Enabled")
                {
                    ApplicationArea = All;
                }
                // </adl.25>
                // <adl.26>
                field("BST Enabled"; "BST Enabled")
                {
                    ApplicationArea = All;
                }
                // </adl.26>   
                // </adl.22>
                field("VIES Enabled"; "VIES Enabled")
                {
                    ApplicationArea = All;
                }
                // </adl.22>       

            }

        }
    }

}
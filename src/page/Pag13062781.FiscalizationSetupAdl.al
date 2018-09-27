page 13062781 "Fiscalization Setup-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Setup';
    UsageCategory = Documents;
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Fiscalization Setup-Adl";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Active; ActiveX)
                {
                    ToolTip = 'Specifies Active';
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ToolTip = 'Specifies Start Date';
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ToolTip = 'Specifies End Date';
                    ApplicationArea = All;
                }
                field("Default Fiscalization Location"; "Default Fiscalization Location")
                {
                    ToolTip = 'Specifies Default Fiscalization Location';
                    ApplicationArea = All;
                }
                field("Default Fiscalization Terminal"; "Default Fiscalization Terminal")
                {
                    ToolTip = 'Specifies Default Fiscalization Terminal';
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(FiscalizationTerminalList)
            {
                ApplicationArea = all;
                RunObject = Page "Fisc. Terminal List-Adl";
                image = SetupList;
                Promoted = True;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                end;
            }
            action(FiscalizationLocationList)
            {
                ApplicationArea = all;
                RunObject = Page "Fisc. Location List-Adl";
                image = SetupList;
                Promoted = True;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                end;
            }
            action(FiscalizationLocationMapping)
            {
                ApplicationArea = all;
                RunObject = Page "Fisc. Location Mapping-Adl";
                image = SetupList;
                Promoted = True;
                PromotedCategory = Process;
                trigger OnAction()
                begin

                end;
            }
        }
    }
    var
        VisibleHR: Boolean;
        VisibleSI: Boolean;

    trigger OnOpenPage()
    begin
        IF NOT GET() THEN
            INSERT();
        IF GetCountryCode() = 'SI' THEN
            VisibleSI := TRUE
        ELSE
            IF GetCountryCode() = 'HR' THEN
                VisibleHR := TRUE;
    end;
    // </adl.20>
}
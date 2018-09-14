page 13062605 "Fiscalization Setup-ADL"
{
    UsageCategory = Documents;
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Fiscalization Setup-ADL";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field("Default Fiscalization Location"; "Default Fiscalization Location")
                {
                    ApplicationArea = All;
                }
                field("Default Fiscalization Terminal"; "Default Fiscalization Terminal")
                {
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
                RunObject = Page "Fisc. Terminal List-ADL";
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
                RunObject = Page "Fisc. Location List-ADL";
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
                RunObject = Page "Fisc. Location Mapping-ADL";
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
      VisibleHR : Boolean;
      VisibleSI : Boolean;
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
}
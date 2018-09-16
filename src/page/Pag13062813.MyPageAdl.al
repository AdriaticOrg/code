page 13062813 "MyPage-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CoreSetup-Adl";

    layout
    {

        area(Content)
        {
            group(GroupName)
            {
                field(MyField; "ADL Enabled")
                {
                    ApplicationArea = All;
                }

            }
        }


    }

    actions
    {
        area(Processing)
        {
            action("ActionName")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RapidStart.Run()
                end;
            }
        }
    }

    var
        RapidStart: Codeunit "Wizard RapidStart-Adl";
}

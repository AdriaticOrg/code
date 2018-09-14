page 13062813 "MyPage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {

        area(Content)
        {
            group(GroupName)
            {

            }
        }


    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
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
        RapidStart: Codeunit "Wizard RapidStart-adl";
}
codeunit 13062816 "Adl Notification Action-Adl"
{
    procedure CoreSetupNotify(var MyNotification: Notification);
    begin
        Codeunit.Run(Codeunit::"Wizard Initialize-Adl");
    end;

    procedure DisableCoreSetupNotify(var MyNotification: Notification);
    var
        MyNotifications: Record 1518;
        AdlCoreNotification: Codeunit "Adl Core Notification-Adl";
        NotificationID: GUID;
    begin
        MyNotifications.LockTable();
        NotificationID := MyNotification.ID(AdlCoreNotification.GetCoreSetupNotificationId());  //getid
        IF MyNotifications.GET(UserId(), NotificationID) then begin
            MyNotifications.Enabled := false;
            MyNotifications.Modify();
        end;
    end;

}
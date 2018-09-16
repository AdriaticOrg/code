codeunit 13062816 "Adl Core Notification Act.-Adl"
{
    procedure CoreSetupNotify(var MyNotification: Notification);
    begin
        Codeunit.Run(Codeunit::"Wizard Initialize-adl");
    end;

    procedure DisableCoreSetupNotify(var MyNotification: Notification);
    var
        MyNotifications: Record 1518;
        AdlCoreNotification: Codeunit "Adl Core Notification-adl";
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
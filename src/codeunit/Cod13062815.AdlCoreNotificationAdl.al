codeunit 13062815 "Adl Core Notification-Adl"
{
    var
        MyNotifications: Record "My Notifications";
        MyNotification: Notification;

    procedure ShowSetupNotification();
    var
        CoreSetup: Record "CoreSetup-Adl";
        CoreSetupIsNotQst: Label 'Adriatic Localization is installed but not setup. Do you want to do this now?';
        YesLbl: Label 'Yes';
        DontAskAgainLbl: Label 'No, and please don''t remind me again.';
    begin
        IF CoreSetup.Get() THEN
            exit;
        IF not IsCoreSetupNotificationEnabled() then
            exit;
        MyNotification.ID := GetCoreSetupNotificationId();
        MyNotification.Message := CoreSetupIsNotQst;
        MyNotification.AddAction(YesLbl, Codeunit::"Adl Notification Action-Adl", 'CoreSetupNotify');
        MyNotification.AddAction(DontAskAgainLbl, Codeunit::"Adl Notification Action-Adl", 'DisableCoreSetupNotify');
        MyNotification.Send();
    end;

    procedure GetCoreSetupNotificationId(): GUID;
    begin
        exit('2712AD06-C48B-4C20-820E-347A60C9AD01');
    end;

    procedure IsCoreSetupNotificationEnabled(): Boolean;
    var
        MyNotifications: Record "My Notifications";
    begin
        exit(MyNotifications.IsEnabled(GetCoreSetupNotificationId()));
    end;

}
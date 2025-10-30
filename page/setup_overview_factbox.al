page 50114 "Setup Overview Factbox"
{
    PageType = CardPart;
    Caption = 'Setup Overview';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(Overview)
            {
                Caption = 'Sync Mode';
                field(TextModifyIn; TextModifyIn)
                {
                    ApplicationArea = All;
                }
                field(TextModifyRunTrigger; TextModifyRunTrigger)
                {
                    ApplicationArea = All;
                }
                field(TextCheckSyncInProgress; TextCheckSyncInProgress)
                {
                    ApplicationArea = All;
                }
                field(TextCheckFieldUpdate; TextCheckFieldUpdate)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        TextModifyIn: Text;
        TextModifyRunTrigger: Text;
        TextCheckSyncInProgress: Text;
        TextCheckFieldUpdate: Text;

    procedure UpdateOverview()
    var
        Setup: Codeunit "Demo EmpRes Setup";
        Coordinator: Codeunit "Cross Table Sync Coordinator";
    begin
        TextModifyIn := 'Modify() in:';
        TextModifyIn += (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseTriggerEvent) ? 'Trigger Event "OnAfterModifyEvent"' : 'Table Trigger "OnModify"';

        TextModifyRunTrigger := 'Sync Active: ' + (Coordinator.GetIsSyncActive() ? 'true' : 'false');
        TextCheckSyncInProgress := 'Use Sync Progress Check: ' + (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseSyncProgressCheck ? 'true' : 'false');
        TextCheckFieldUpdate := 'Use Field Update Check: ' + (Setup.GetSyncMode() = Setup.GetSyncMode() ::UseFieldUpdateCheck ? 'true' : 'false');
    end;
}
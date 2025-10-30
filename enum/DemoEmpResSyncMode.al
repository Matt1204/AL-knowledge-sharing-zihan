enum 50110 "Demo EmpRes Sync Mode"
{
    Extensible = false;

    value(0; None)
    {
        Caption = 'None';
    }
    value(1; UseTableTrigger)
    {
        Caption = 'Table Trigger';
    }
    // value(2; UseTableTriggerFalse)
    // {
    //     Caption = 'Table Trigger (Modify false)';
    // }
    value(3; UseTriggerEvent)
    {
        Caption = 'Trigger Event';
    }
    value(5; UseSyncProgressCheck)
    {
        Caption = 'Use Sync Progress Check';
    }
    value(6; UseFieldUpdateCheck)
    {
        Caption = 'Use Field Update Check';
    }
}


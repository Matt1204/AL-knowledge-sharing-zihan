# Data-Focused Triggers and Trigger Events in AL
*- Zihan Ma 10/31/2025*
> [GitHub repo for this Knowledge Sharing](https://github.com/Matt1204/AL-knowledge-sharing-zihan)
## 1. Overview (trigger and event)
> [Knowledge sharing from Zhuoran](https://vffice3-my.sharepoint.com/:b:/r/personal/yajing_liu_vffice_com/Documents/Microsoft%20Teams%20Chat%20Files/trigger%205.pdf?csf=1&web=1&e=9QbzT7). Just for review, not focus for today
---
### 1.1 Triggers:
#### - Triggers for *Page* lifecycle: 
1. OnInit()
2. OnOpenPage()
3. OnAfterGetCurrRecord()
4. OnAfterGetRecord()
5. OnNewRecord()
6. OnInsertRecord()
7. **OnModifyRecord()**
7. OnClosePage()
8. OnQueryClosePage()

#### - Triggers for *Report* lifecycle:
1. OnInitReport
2. OnOpenPage() => Request Page
3. OnPreReport() => Report object
4. OnPreDataItem() => DataItem
5. OnAfterGetRecord() => DataItem
6. OnPostDataItem() => DataItem
5. OnPostReport() => Report Object

#### - Triggers for *Table*/*TableExt*:
1. **OnBeforeModify()**
2. **OnModify()**
3. **OnAfterModify()**
4. Insert...
5. Delete...
6. Rename...

---
### 1.2 Events:
#### - Customized Events:
```
// Declaration: define your event publisher function
[IntegrationEvent(false, false)]
local procedure OnWorkStarted(JobId: Code[20]; var IsHandled: Boolean)
begin
end;

// Publishing: invoke event publisher function (somewhere in your code)
OnWorkStarted(JobId, IsHandled);
if not IsHandled then begin
    result := StrSubstNo('Job %1 finished by default flow.', JobId);
end;

// Subscriber: listen and handle the event (in a codeunit)
[EventSubscriber(ObjectType::Codeunit, Codeunit::"Demo Publisher", 'OnWorkStarted', '', false, false)]
local procedure HandleOnWorkStarted(JobId: Code[20]; var IsHandled: Boolean)
begin
    if JobId = 'CUSTOM' then begin
        // do something
        IsHandled := true;
    end;
end;
```

#### - Trigger Events: 
- system defined, published at runtime, subscribe to perform your code logic.
- For Table:
    1. *OnBeforeModifyEvent* / *OnAfterModifyEvent*
    2. OnBeforeValidateEvent / OnAfterValidateEvent
    3. ......
- For Page:
    1. OnBeforeActionEvent / OnAfterActionEvent
    2. OnClosePageEvent
    3. ......

## 2. Data-focused triggers and trigger events
#### 2.1 What it is:
- triggers and events that fire due to *data operations* (`Modify`,`Insert`, `Delete`, `Rename`): 
    1. In table: `OnInsert`, `OnModify`, `OnDelete`, `OnRename` 
    2. In Table Extension: `OnBeforeInsert`, `OnAfterInsert`, `OnBeforeModify`, `OnAfterModify`, ......
    3. Corresponding trigger events like `OnBeforeModifyEvent`, `OnAfterModifyEvent`,  `OnBeforeInsert`, ......
- Focus on *Object-level* today
#### 2.2 What it is not (out of scope for today):
- *lifecycle* triggers (for example, `OnInit`) and page action events.
- *field-level* validation triggers/events (`OnBeforeValidate*`, `OnValidate`, `OnAfterValidate*`)

#### 2.3 Use `Modify` as example
> Ohter operations (`Insert`, `Delete`, `Rename`) share similar workflow.

- table-level triggers:
    1. OnModify() => table
    2. OnBeforeModify() => tableExt
    3. OnAfterModify() => tableExt
- trigger events
    1. OnBeforeModifyEvent()
    2. OnAterModifyEvent()
- many other triggers/events related to `Modify` operation, but not our focus:
    - Field-level triggers/events: OnBeforeValidateEvent, OnBeforeValidate, OnValidate, OnAfterValidate, OnAfterValidateEvent(table validate), page validate...
    - OnModifyRecord() => page/pageExt


#### 2.4 Questions we concern
- The behaviour of these trigger and events
    - [OnModify()](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/triggers-auto/table/devenv-onmodify-table-trigger)
    - [OnBeforeModifyEvent](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/triggers-auto/events/table/devenv-onbeforemodifyevent-table-trigger)
1. What is the sequence of execution?
2. Do all of them get invoked in any conditions? (updated from UI, `rec.Modify()`, `rec.Modify(false/true)` [RunTrigger boolean](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/methods-auto/record/record-modify-method))
3. Can we keep track of post-update/pre-update record values? (`Rec`, `xRec`)
4. When does DB transaction happen?

---
![cheat-sheet](/assets/cheatsheet.png)

## 3. Case Study: cross-table data update
> this is not a common scenario in production, just for demo purpose.
- 2 tables: `Employee` and `Resource`. (BC has its own Employee and Resource implementation, here we create 2 new tables for demo)
- We want to keep the field `phone` sychronized across 2 tables; 
    - `Employee.phone` updated => `Resource.phone` should be updated accordingly.
    - `Resource.phone` updated => `Employee.phone` should be updated accordingly.

![case_study](/assets/case_study.png)

1. Solution 1: update the other table in `trigger OnModify()`
    - both table triggers use `.Modify(false)`
    - both table triggers use `.Modify(true)` 
    - a table trigger uses `Modify(true)`+ the other table uses`Modify(false)`
2. Solution 2: update the other table in `OnBeforeModifyEvent`
3. Solution 3: add check-only 1 sync session allowed at a time; if `Employee` is updating `Resource`, then `Resource` should NOT update `Employee`.
4. Solutiuon 4: add check-only update the other table when the field value changes.
5. Solution 5: use Flowfield, store truth value in `Employee.phone`, `Resource.phone` read value from `Employee.`

--- 

1. Solution 1:
    - if both table modify each other using `Modify(false)` => OK
    - if both table modify each other using `Modify(true)` => Fail. infinite recursion.
    - if a table uses `Modify(false)`, the other `Modify(true)` => Fail. record context change.
2. Solution 2:
    - always creates recursion => trigger events are always published despite `Modify(false/true)`
3. Solution 3:
    - OK. but only allows single update session at a time, not ideal for async batch update.
4. Solution 4:
    - OK, but not what we wanted. Both `Rec`,`xRec` in `OnModify()` somehow points to the updated value, somehow stops the recursion.
5. Solution 5:
    - OK. single-direction sychronization => `Flowfield` cannot be updated
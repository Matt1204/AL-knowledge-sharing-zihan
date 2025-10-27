## a Knowledge Sharing session for the dev team.
- Title: Best practice in using trigger, trigger event in AL language in Business Central development.
- Outline: 
    1. Case Study: recursive table triggering. The table trigger (OnModify()) of table A is implemented with logic to update a record in table B. However, the table trigger of table B also implements the logic to update a record in table A. If a record in table A gets updated manually, will 2 tables recursively modify each other?
    2. the key properties of trigger (e.g OnModify()) and trigger event (e.g. OnBeforeModifyEvent()): order of execution, Behaviour when rec.Modify(true/false), used in page or table.
    3. Review and answer part 1
    4. Best practices in using triggers/trigger events in AL.

---
## Prompt Instructions:
1. To explain something, instead of directly defining it, it's better to let people gain understanding by explaining what it is NOT, by outlining the boundry, telling the difference.
---

## TODO
1. experiment on triggers and trigger events.
    1. sequence
    2. .modify(true/false/empty)
    3. used in table v.s. page

2. re-create the recursive triggering scenario, how to solve
    - student table, class table. updating `Grade` variable, `Studen.Grade + 1`....


---
## 1. cross-table mutual update
1. if both `.Modify(true)`, there will be recursive call.
    ```
    Error message: 
    There is insufficient memory to execute this function. This can be caused by recursive function calls. Contact your system administrator.

    AL call stack: 
    Student(Table 50100).OnModify(Trigger) line 9 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Class(Table 50101).OnModify(Trigger) line 8 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Student(Table 50100).OnModify(Trigger) line 9 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Class(Table 50101).OnModify(Trigger) line 8 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Student(Table 50100).OnModify(Trigger) line 9 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Class(Table 50101).OnModify(Trigger) line 8 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Student(Table 50100).OnModify(Trigger) line 9 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    Class(Table 50101).OnModify(Trigger) line 8 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    ```

2. If in table B `a.Modify(true)`, in table A `b.Modify(false)`. then update b:
    - in table B `a.Modify(true)` => in table A `b.Modify(false)` => B's`OnModify()` won't run.
    - Neither update will succeed, DB transaction not completed?
    - Why: ??? same record B will be updated twice, after first update, its `reference` has changed, so in second update, same record B cannot be accessed via old reference ???
    - Need info!!!!!!!!!!!!!!!!
    ```
    Error message: 
    The changes to the Class record cannot be saved because some information on the page is not up-to-date. Close the page, reopen it, and try again.
    Identification fields and values:
    No.='1'

    AL call stack: 
    "Demo Student List"(Page 50100)."UpdateClassGrade - OnAction"(Trigger) line 6 - 001_knowledge_sharing by Default Publisher version 1.0.0.0
    ```

3. if both false `a.Modify(true)`, `b.Modify(false)`
    - Only single-way update, No error.

## Properties: trigger v.s. trigger event
1. update from **UI**: 
    - OnBeforeModifyEvent -> OnBeforeModify (tableExt) -> **OnModify()**(of table) -> **OnModify()**(of tableExt) -> OnAfterModify(tableExt) -> OnAfterModifyEvent
2. Update from **Code**:
    - `rec.Modify()` => OnBeforeModifyEvent -> OnAfterModifyEvent
    - `rec.Modify(true)` (same as UI update) => OnBeforeModifyEvent -> OnBeforeModify (tableExt) -> **OnModify()**(of table) -> **OnModify()**(of tableExt) -> OnAfterModify(tableExt) -> OnAfterModifyEvent
    - `rec.Modify(false)` => OnBeforeModifyEvent -> OnAfterModifyEvent
---

- In all triggers and tirgger events above: `Rec` points to the **updated record**, `xRec` points to **Previous record**
- Database transaction happends *AFTER* trigger `OnModify()`. (Database transaction not committed in `OnModify()`)
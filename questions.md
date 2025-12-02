## Key Questions:
#### 1. When does database transaction start and commit?
- For `rec.Modify()` (executed in an action)
    - A new transaction starts after table trigger `OnModify()`(`LOP_BEGIN_XACT`), `LOP_MODIFY_COLUMNS` is added to this transaction.
    - Once transaaction starts. `rec.Get()` will return **updated value** => BC reading from cache.
    - This transaction is committed when action done executing
- `rec.Modify()` but **error** during transaction
    1. `LOP_BEGIN_XACT` -> `LOP_MODIFY_COLUMNS` * 2(1.update to new value  2.error thrown, rollback to old value) -> `LOP_ABORT_XACT`(not committed)
- `rec.Modify()` twice. First in call stack layer 1, Second in call stack layer 2(locally)
    - transaction starts after call 1's OnModify.
    - both operations are included in the same transaction
- `rec.Modify()` Once. Call stack layer 1 do nothing, Modify happens in call stack layer 2.
    - transaction starts in `rec.Modify()`.
    - transaction doesn't ends when call stack layer 2 ends, it ends when Call stack layer 1 ends.

#### Conclusion:
    1. Starts right after first db operation's `OnXXX()` table triger.
    2. Ends: when the whole call stacks finishes executing. (no matter at which layer of call stask the db operation heppens)
    3. the time between "transaction starts" to "transaction ends", BC code will read new data from cache.
    4. if error thown before commit, rollback.

---

#### 2. when reading BC data via OData API, does it read from cache?
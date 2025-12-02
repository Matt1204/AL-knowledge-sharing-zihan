## Business Central TransactionType — member-by-member guide

This guide explains how each TransactionType influences database reads/writes and locking in Dynamics 365 Business Central. It assumes basic familiarity with transactions and commits, and explains terms like READ UNCOMMITTED along the way.

### Quick glossary (what the lock terms mean)
- **READ UNCOMMITTED**: Reads can see uncommitted changes from other transactions (“dirty reads”). Readers do not place shared locks and can ignore others’ exclusive locks; fastest but least consistent.
- **REPEATABLE READ**: When you read rows, shared locks are held on those rows until the transaction ends. Prevents another transaction from changing those same rows (avoids non‑repeatable reads), but new rows might still appear (phantoms).
- **UPDLOCK (update lock)**: A lock hint for reads that “reserves” the right to update the rows, reducing write/write deadlocks. It tends to block writers (and can block some readers depending on compatibility) after you start modifying.
- **LockTable**: An explicit AL call that acquires stronger locks on a table to protect a critical section before writing.
- **Dirty read**: You read data that another transaction hasn’t committed yet (it might be rolled back).
- **Non‑repeatable read**: You read the same row twice and see different values because another transaction updated it between your reads.
- **Phantom**: You repeat a query and see extra/missing rows because another transaction inserted/deleted rows matching your filter.

---

### Browse
- **What it is**: Read-only.
- **Read behavior**: Uses READ UNCOMMITTED for all reads.
- **Behind the scenes**: Think “NOLOCK” style reads in SQL Server—no shared locks are taken; existing exclusive locks are ignored for reading. Very high concurrency; data can be inconsistent.
- **Typical use**: Dashboards, quick lookups, lightweight queries where the absolute latest-but-possibly-transient values are acceptable.
- **Risks**: Dirty reads, non‑repeatable reads, and phantoms are all possible. Never rely on this for business-critical validations.

### Report
- **What it is**: Alias of Browse (same behavior).
- **Read behavior**: READ UNCOMMITTED for all reads.
- **Behind the scenes**: Designed for report scenarios where speed and concurrency matter more than strict consistency.
- **Typical use**: Reporting, BI extracts, large read workloads.
- **Risks**: Same as Browse—dirty reads and inconsistencies can appear in the output.

### Snapshot
- **What it is**: Read-only with a stable view of rows you touch.
- **Read behavior**: Uses REPEATABLE READ semantics for the rows you read (shared locks held on read rows until transaction end).
- **Behind the scenes**: Ensures values for rows you actually read don’t change underneath you while the transaction is open. Does not necessarily eliminate phantoms.
- **Typical use**: Validations, calculations, or analytics that must not see changing values for already-read rows during the operation.
- **Risks**: Can reduce concurrency vs. Browse/Report because it holds shared locks on read rows until commit. New matching rows can still appear (phantoms).

### Update
- **What it is**: Read–write; you can modify data.
- **Read behavior before first write/LockTable**: REPEATABLE READ on reads (shared locks on read rows, held to end).
- **Read behavior after first write or LockTable**: Reads use UPDLOCK—reserving those rows for potential updates and reducing deadlocks/contention with other writers.
- **Behind the scenes**: Starts consistently to avoid non‑repeatable reads, then tightens behavior once you begin writing so subsequent reads “claim” rows with update locks. Writers from other sessions will likely be blocked on the same rows until you commit/rollback.
- **Typical use**: Standard business logic that reads some rows, performs checks, then writes changes.
- **Risks**: Stronger locking after the first write can increase blocking; design critical sections to be as short as possible.

### UpdateNoLocks
- **What it is**: Read–write; optimized for initial read concurrency.
- **Read behavior before first write/LockTable**: READ UNCOMMITTED (fast, may see dirty data).
- **Read behavior after first write or LockTable**: Reads use UPDLOCK until the transaction ends.
- **Behind the scenes**: Maximizes throughput up front by not taking shared locks while you’re only reading; once you start modifying or explicitly lock the table, it flips to update locks to protect write paths.
- **Typical use**: Workflows where early reads are exploratory/approximate (e.g., finding candidates), and precision/locking matters only once you decide to write.
- **Risks**: Early dirty reads can lead to logic branching on transient data. Ensure you re-validate any assumptions after switching into the write phase.

---

### Choosing the right TransactionType
- Use **Browse/Report** for fastest reads where occasional inconsistencies are acceptable.
- Use **Snapshot** when you need stable values for rows you read throughout a long read-only operation.
- Use **Update** for typical business updates with consistent pre-checks.
- Use **UpdateNoLocks** when you want maximum concurrency during initial reads and only enforce locks once you actually write.



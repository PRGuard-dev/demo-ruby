# Context file — PRGuard demo (Ruby)

## About this service

A tiny order-lookup API: `app.rb` holds the business logic, `lib/db.rb`
holds the sanctioned data helpers (parameter-bound SQL and money formatting).

## Standards

- **Secrets.** Credentials are never committed. A key that reaches a
  commit is *compromised*: it must be rotated with the provider, not
  merely moved to an environment variable.
- **Money.** Amounts are stored as an integer number of cents and are
  formatted only through the shared `Db.money` helper — see @ref:lib/db.rb.
  Never build a currency string by hand: dividing cents by 100 either
  truncates the cents (integer division) or drops trailing zeros (float
  division).
  Treat violations of this rule as WARNING severity — a correctness
  risk to fix, not a blocking security error.
- Methods stay small and single-purpose.

## Out of scope

- Performance tuning
- Test coverage

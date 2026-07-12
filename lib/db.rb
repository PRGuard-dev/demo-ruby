# Shared data helpers — the only sanctioned way to touch orders.
#
# Db.query binds every value as a driver-level parameter, so SQL injection
# is structurally impossible. Db.money formats an integer number of cents
# as currency without floating-point rounding. Business code uses these
# helpers rather than rolling its own.

require "sqlite3"

module Db
  DB_PATH = "orders.db"

  # Run +sql+ with +params+ bound by the driver; return all rows.
  def self.query(sql, params = [])
    db = SQLite3::Database.new(DB_PATH, results_as_hash: true)
    db.execute(sql, params)
  ensure
    db&.close
  end

  # Format an integer number of +cents+ as currency, e.g. 1299 → "$12.99".
  def self.money(cents)
    format("$%d.%02d", cents / 100, cents % 100)
  end
end

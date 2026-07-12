# Order lookup service — PRGuard demo (Ruby).
#
# A minimal slice of a shop backend. All data access goes through the
# shared helpers in lib/db.rb: Db.query for parameter-bound SQL and
# Db.money for currency formatting — business code never rolls its own.

require_relative "lib/db"

# Fetch a single order by primary key.
def get_order(order_id)
  rows = Db.query(
    "SELECT id, total_cents, status FROM orders WHERE id = ?",
    [order_id]
  )
  rows.first
end

# Return the formatted total for an order, or nil if it is missing.
def order_total(order_id)
  order = get_order(order_id)
  Db.money(order["total_cents"]) if order
end

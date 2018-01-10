class TransactionSchema < ActiveRecord::Migration
  def change
    create_table "deposits", force: true do |t|
      t.integer  "account_id"
      t.integer  "member_id"
      t.integer  "currency"
      t.decimal  "amount",                 precision: 32, scale: 16
      t.decimal  "fee",                    precision: 32, scale: 16
      t.string   "fund_uid"
      t.string   "fund_extra"
      t.string   "txid"
      t.integer  "state"
      t.string   "aasm_state"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "done_at"
      t.string   "confirmations"
      t.string   "type"
      t.integer  "payment_transaction_id"
      t.integer  "txout"
    end

    add_index "deposits", ["txid", "txout"], name: "index_deposits_on_txid_and_txout", using: :btree

    create_table "fund_sources", force: true do |t|
      t.integer  "member_id"
      t.integer  "currency"
      t.string   "extra"
      t.string   "uid"
      t.boolean  "is_locked",  default: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "deleted_at"
    end

    create_table "partial_trees", force: true do |t|
      t.integer  "proof_id",   null: false
      t.integer  "account_id", null: false
      t.text     "json",       null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "sum"
    end

    create_table "payment_addresses", force: true do |t|
      t.integer  "account_id"
      t.string   "address"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "currency"
    end

    create_table "payment_transactions", force: true do |t|
      t.string   "txid"
      t.decimal  "amount",                   precision: 32, scale: 16
      t.integer  "confirmations"
      t.string   "address"
      t.integer  "state"
      t.string   "aasm_state"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "receive_at"
      t.datetime "dont_at"
      t.integer  "currency"
      t.string   "type",          limit: 60
      t.integer  "txout"
    end

    add_index "payment_transactions", ["txid", "txout"], name: "index_payment_transactions_on_txid_and_txout", using: :btree
    add_index "payment_transactions", ["type"], name: "index_payment_transactions_on_type", using: :btree
  end

  create_table "proofs", force: true do |t|
    t.string   "root"
    t.integer  "currency"
    t.boolean  "ready",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sum"
    t.text     "addresses"
    t.string   "balance",    limit: 30
  end

  create_table "trades", force: true do |t|
    t.decimal  "price",         precision: 32, scale: 16
    t.decimal  "volume",        precision: 32, scale: 16
    t.integer  "ask_id"
    t.integer  "bid_id"
    t.integer  "trend"
    t.integer  "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ask_member_id"
    t.integer  "bid_member_id"
    t.decimal  "funds",         precision: 32, scale: 16
  end

  add_index "trades", ["ask_id"], name: "index_trades_on_ask_id", using: :btree
  add_index "trades", ["ask_member_id"], name: "index_trades_on_ask_member_id", using: :btree
  add_index "trades", ["bid_id"], name: "index_trades_on_bid_id", using: :btree
  add_index "trades", ["bid_member_id"], name: "index_trades_on_bid_member_id", using: :btree
  add_index "trades", ["created_at"], name: "index_trades_on_created_at", using: :btree
  add_index "trades", ["currency"], name: "index_trades_on_currency", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "withdraws", force: true do |t|
    t.string   "sn"
    t.integer  "account_id"
    t.integer  "member_id"
    t.integer  "currency"
    t.decimal  "amount",     precision: 32, scale: 16
    t.decimal  "fee",        precision: 32, scale: 16
    t.string   "fund_uid"
    t.string   "fund_extra"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "done_at"
    t.string   "txid"
    t.string   "aasm_state"
    t.decimal  "sum",        precision: 32, scale: 16, default: 0.0, null: false
    t.string   "type"
  end
end

# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:movies) do
      column :id,             :uuid,    null: false, default: Sequel.function(:uuid_generate_v4), primary_key: true
      column :title,          'citext', null: false, unique: true
      column :price_in_cents, Integer,  null: false
      column :omdb_id,        String,   null: false, unique: true
      column :created_at,     DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at,     DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end

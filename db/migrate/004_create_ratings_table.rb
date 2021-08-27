# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:ratings) do
      column :id,         :uuid,    null: false, default: Sequel.function(:uuid_generate_v4), primary_key: true
      column :value,      Integer,  null: false
      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP

      check(value: %w[1 2 3 4 5])

      foreign_key :user_id,  :users,  type: 'uuid', null: false, on_delete: :cascade
      foreign_key :movie_id, :movies, type: 'uuid', null: false, on_delete: :cascade

      index %i[user_id movie_id], unique: true
    end
  end
end

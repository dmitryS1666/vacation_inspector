# frozen_string_literal: true

class CreateStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :statements do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :status

      t.integer :user_id, null: false
      t.integer :statement_type_id, null: false

      t.timestamps
    end
  end
end

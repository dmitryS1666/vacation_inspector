# frozen_string_literal: true

class CreateStatementTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :statement_types do |t|
      t.string :name
    end
  end
end

# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :statement_type

  STATUSES = %w(pending accept decline)

  validates :status, inclusion: { in: STATUSES },
            presence: true
  validates_comparison_of :end_date, greater_than_or_equal_to: :start_date

  def type
    statement_type.name
  end

  def user
    User.find(user_id)
  end
end

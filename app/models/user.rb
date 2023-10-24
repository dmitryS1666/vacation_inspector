# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :statements

  enum role: %i(user admin)

  def admin?
    role == 'admin'
  end
end

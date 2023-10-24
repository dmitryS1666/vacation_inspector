require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:type_vacation) { StatementType.create!(name: 'vacation') }
  let(:type_time_off) { StatementType.create!(name: 'time off') }
  let(:start_date) { Time.now }
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:admin) { User.create!(email: Faker::Internet.email, password: '123456789', role: 1) }

  let!(:st_vacation) do
    Statement.create!(
      start_date: start_date,
      end_date: Time.now + 1,
      statement_type_id: type_vacation.id,
      user_id: user.id,
      status: 'pending'
    )
  end

  let!(:st_time_off) do
    Statement.create!(
      start_date: start_date,
      end_date: Time.now + 1,
      statement_type_id: type_time_off.id,
      user_id: user.id,
      status: 'pending'
    )
  end

  let!(:st_time_off_2) do
    Statement.create!(
      start_date: start_date,
      end_date: Time.now + 1,
      statement_type_id: type_time_off.id,
      user_id: user_2.id,
      status: 'pending'
    )
  end

  context "login as user" do
    it 'get page with OWN statements' do
      login_as user
      get user_path(user)

      expect(response).to be_successful
      expect(response.body).to include(type_vacation.name)
      expect(response.body.scan('statement_card').size).to eq(2)
    end
  end

  context "login as admin" do
    it 'get page with ALL statements' do
      login_as admin
      get user_path(admin)

      expect(response).to be_successful
      expect(response.body.scan('statement_card').size).to eq(3)
    end
  end
end

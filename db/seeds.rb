# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
User.create!(email: 'admin@mail.com', role: 1, password: '123456789')

user = User.create!(email: 'user@mail.com', password: '123456789')
user_2 = User.create!(email: 'user2@mail.com', password: '123456789')

# Statement types
vacation = StatementType.create!(name: 'vacation')
sick_leave = StatementType.create!(name: 'sick leave')
time_off = StatementType.create!(name: 'time off')

# Statements
Statement.create!(
  [
    { start_date: Date.new(2023, 10, 1),
      end_date: Date.new(2023, 10, 2),
      status: 'accept',
      user_id: user.id,
      statement_type_id: time_off.id
    },
    { start_date: Date.new(2023, 10, 1),
      end_date: Date.new(2023, 10, 1),
      status: 'accept',
      user_id: user.id,
      statement_type_id: sick_leave.id
    },
    { start_date: Date.new(2023, 11, 7),
      end_date: Date.new(2023, 11, 21),
      status: 'pending',
      user_id: user.id,
      statement_type_id: vacation.id
    },
    { start_date: Date.new(2023, 10, 10),
      end_date: Date.new(2023, 10, 24),
      status: 'accept',
      user_id: user_2.id,
      statement_type_id: vacation.id
    }
  ]
)
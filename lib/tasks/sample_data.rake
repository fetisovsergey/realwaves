namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin1 = User.create!(name:     "admin1",
                       email:    "info@yourwaves.ru",
                       password: "123456",
                       password_confirmation: "123456",
                       admin: true,
		       email_confirmed: true)
  admin2 = User.create!(name:     "admin2",
                       email:    "sergeyfetisov@gmail.com",
                       password: "123456",
                       password_confirmation: "123456",
                       admin: true,
		       email_confirmed: true)
end

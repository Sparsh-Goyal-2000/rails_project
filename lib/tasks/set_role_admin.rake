namespace :set_role do
  desc 'set users role to admin'
  task set_role_admin: :environment do
    user = User.find_by(email: ENV['email'])
    user.update(role: 'admin') if user.present?
  end
end
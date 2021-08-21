desc 'set users role to admin'
task set_role_admin: :environment do
  user = User.find_by(email: ENV['email'])
  unless user.nil?
    user.role = 'admin'
    user.save
  end
end
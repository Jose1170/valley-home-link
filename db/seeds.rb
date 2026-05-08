# Clear old data to avoid duplicates
ServiceCategory.destroy_all

categories = ["Plumbing", "Electrical", "Landscaping", "Cleaning", "General"]

categories.each do |name|
  ServiceCategory.find_or_create_by!(name: name)
end

puts "Successfully seeded #{ServiceCategory.count} categories!"

=begin
# 1. Clear old data to avoid duplicates, order is important!

puts "Cleaning database..."

Booking.destroy_all

JobRequest.destroy_all

Address.destroy_all

User.destroy_all

ServiceCategory.destroy_all



# 2. Seed Service Categories

categories = ["Plumbing", "Electrical", "Landscaping", "Cleaning", "General"]

categories.each do |name|

  ServiceCategory.find_or_create_by!(name: name)

end

puts "Seeded #{ServiceCategory.count} categories."



# 3. Seed Admin User

admin = User.find_or_create_by!(email: 'admin@test.com') do |u|

  u.name = "System Admin"

  u.password = 'password123'

  u.role = 'admin'

end



# 4. Seed Provider User

provider = User.find_or_create_by!(email: 'provider_test@test.com') do |u|

  u.name = "John Provider"

  u.password = 'password123'

  u.role = 'provider'

end



# 5. Seed Customer User

customer = User.find_or_create_by!(email: 'customer_test@test.com') do |u|

  u.name = "Jane Customer"

  u.password = 'password123'

  u.role = 'customer'

end



# 6. Seed Address for the Customer (Crucial for the "Service Location" feature)

Address.find_or_create_by!(user: customer) do |a|

  a.street = "1201 W University Dr"

  a.city = "Edinburg"

  a.state = "TX"

  a.zip_code = "78539"

end



# 7. Seed an Initial Job Request (To show the marketplace is working)

JobRequest.create!(

  customer_id: customer.id,

  service_category: ServiceCategory.find_by(name: "Plumbing"),

  job_description: "Fixing a leaky faucet in the kitchen.",

  job_status: "open"

)



puts "Successfully seeded database with Users, Addresses, and a sample Job Request!"

=end

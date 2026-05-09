# Clear old data to avoid duplicates
ServiceCategory.destroy_all

categories = ["Plumbing", "Electrical", "Landscaping", "Cleaning", "General"]

categories.each do |name|
  ServiceCategory.find_or_create_by!(name: name)
end

puts "Successfully seeded #{ServiceCategory.count} categories!"

# 1. Clear old data to avoid duplicates, order is important!

puts "Cleaning database..."
Booking.destroy_all
JobRequest.destroy_all
Address.destroy_all
ProviderService.destroy_all # Added this to clear join table
User.destroy_all
ServiceCategory.destroy_all

puts "Seeding Service Categories..."
categories = ["Plumbing", "Electrical", "Landscaping", "Cleaning", "General"]
categories.each { |name| ServiceCategory.find_or_create_by!(name: name) }

puts "Seeding Users..."
# Seed Admin
admin = User.find_or_create_by!(email: 'admin@test.com') do |u|
  u.name = "System Admin"
  u.username = "admin"
  u.password = 'password123'
  u.role = :admin
end

# Seed Provider
provider = User.find_or_create_by!(email: 'provider_test@test.com') do |u|
  u.name = "John Provider"
  u.username = "provider"
  u.password = 'password123'
  u.role = :provider
end

# Seed Customer
customer = User.find_or_create_by!(email: 'customer_test@test.com') do |u|
  u.name = "Jane Customer"
  u.username = "customer"
  u.password = 'password123'
  u.role = :customer
end

puts "Seeding Address..."
addr = Address.find_or_create_by!(user: customer) do |a|
  a.street_address = "1201 W University Dr"
  a.city = "Edinburg"
  a.state = "TX"
  a.zip_code = "78539"
end

puts "Seeding Job Request..."
JobRequest.create!(
  customer_id: customer.id,
  address_id: addr.id, # Added this to satisfy the relationship
  service_category_id: ServiceCategory.find_by(name: "Plumbing").id, # Use ID for Postgres safety
  job_title: "Emergency Plumbing",
  job_description: "Fixing a leaky faucet in the kitchen.",
  job_status: 0 # Using integer for status
)

puts "Successfully seeded!"

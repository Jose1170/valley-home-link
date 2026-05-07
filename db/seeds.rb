# Clear old data to avoid duplicates
ServiceCategory.destroy_all

categories = ["Plumbing", "Electrical", "Landscaping", "Cleaning", "General"]

categories.each do |name|
  ServiceCategory.find_or_create_by!(name: name)
end

puts "Successfully seeded #{ServiceCategory.count} categories!"
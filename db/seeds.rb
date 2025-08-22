require "json"
require "open-uri"
require "nokogiri"
require 'faker'

puts "Deleting existing data..."
Message.delete_all
Membership.delete_all
Favourite.delete_all
Review.delete_all
Recipe.delete_all
User.delete_all
Community.delete_all

puts "Creating admin user..."
admin_user = User.create!(
  fullname: "Admin",
  email: "admin@ingredible.me",
  admin: true,
  password: "test1234"
)
puts "Admin user created"

# --- Recipes creation ---
puts "Creating recipes..."
filepath_recipes = 'db/recipes.json'
recipes_data = JSON.parse(File.read(filepath_recipes))

recipes_data.slice!(500, 50).each_with_index do |recipe, index|
  new_recipe = Recipe.new(
    name: recipe["Name"],
    ingredients: recipe["Ingredients"].join("-- "),
    difficulty: ['easy', 'medium', 'hard'].sample,
    steps: recipe["Method"].join('--'),
    serves: 2,
    category: "To be confirmed",
    user: admin_user,
    time: "N/A"
  )

  begin
    url = recipe["url"]
    html_doc = Nokogiri::HTML(URI.open(url).read)
    # Attach recipe image
    img_element = html_doc.at_css(".post-header__container .image__img")
    puts(img_element)
    if img_element && img_element['src'].present?
      file = URI.open(img_element['src'])
      new_recipe.photo.attach(io: file, filename: "recipe-#{index + 1}.png", content_type: 'image/png')
    else
      fallback_file = File.open(Rails.root.join("db/seeds/images/fallback.png"))
      new_recipe.photo.attach(io: fallback_file, filename: "fallback.png", content_type: 'image/png')
    end

    # Extract cooking time
    html_doc.search('span').each do |span|
      text = span.text.strip
      if text == "Cook:" || text.include?("Total time") || text.include?("Prep")
        new_recipe.time = span.next_element.text.strip rescue "N/A"
        break
      end
    end
  rescue => e
    puts "Warning: Failed to fetch recipe image or time: #{e.message}"
    fallback_file = File.open(Rails.root.join("db/seeds/images/fallback.png"))
    new_recipe.photo.attach(io: fallback_file, filename: "fallback.png", content_type: 'image/png')
  end

  new_recipe.save!
  puts "Recipe #{index + 1} created with image attached? #{new_recipe.photo.attached?}"
end
puts "Finished creating recipes"

# --- Users creation ---
puts "Creating users..."
10.times do |i|
  user = User.new(
    fullname: Faker::Name.name,
    password: "test1234"
  )
  user.email = "#{user.fullname.split(' ').join('')}@test.com"

  begin
    user_file_path = Rails.root.join("app/assets/images/users/user-#{i + 1}.jpg")
    if File.exist?(user_file_path)
      user_file = File.open(user_file_path)
      user.photo.attach(io: user_file, filename: "user-#{i + 1}.jpg", content_type: 'image/png')
    else
      fallback_file = File.open(Rails.root.join("db/seeds/images/fallback_user.png"))
      user.photo.attach(io: fallback_file, filename: "fallback_user.png", content_type: 'image/png')
    end
  rescue => e
    puts "Warning: Failed to attach image for user #{i + 1}: #{e.message}"
  end

  user.save!
  puts "User #{i + 1} created with image attached? #{user.photo.attached?}"
end
puts "Finished creating users"

# --- Communities creation ---
puts "Creating communities..."
filepath_communities = 'db/communities.json'
communities_data = JSON.parse(File.read(filepath_communities))

communities_data.each_with_index do |community_data, index|
  community = Community.new(
    name: community_data["name"],
    description: community_data["description"]
  )

  begin
    if community_data["img"].present?
      community_file = URI.open(community_data["img"])
      community.photo.attach(io: community_file, filename: "community-#{index + 1}.png", content_type: 'image/png')
    else
      fallback_file = File.open(Rails.root.join("db/seeds/images/fallback_community.png"))
      community.photo.attach(io: fallback_file, filename: "fallback_community.png", content_type: 'image/png')
    end
  rescue => e
    puts "Warning: Failed to attach community image: #{e.message}"
    fallback_file = File.open(Rails.root.join("db/seeds/images/fallback_community.png"))
    community.photo.attach(io: fallback_file, filename: "fallback_community.png", content_type: 'image/png')
  end

  community.save!

  # Welcome message
  Message.create!(
    community: community,
    user: admin_user,
    content: "Welcome to #{community.name} Community!"
  )
  puts "Community #{index + 1} created with image attached? #{community.photo.attached?}"
end
puts "Finished creating communities"

# --- Reviews & Messages creation ---
puts "Adding reviews and messages..."
filepath_reviews = 'db/reviews.json'
reviews_data = JSON.parse(File.read(filepath_reviews))

reviews_data.each_with_index do |review_data, index|
  user = User.where(admin: false).order("RANDOM()").first
  recipe = Recipe.order("RANDOM()").first
  community = Community.order("RANDOM()").first

  next unless user && recipe && community

  Review.create!(
    body: review_data["review"],
    rating: rand(1..5),
    user: user,
    recipe: recipe
  )

  Message.create!(
    content: review_data["review"],
    user: user,
    community: community
  )

  puts "Review & message #{index + 1} created"
end
puts "Finished adding reviews and messages"
puts "Seeding completed!"

# Create Users
5.times do
  User.create!(
# #3
  name:     RandomData.random_name,
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

# Create topics
15.times do
  Topic.create!(
    name:           RandomData.random_sentence,
    description:    RandomData.random_paragraph
  )
end
topics = Topic.all

# Create posts
50.times do
  post = Post.create!(
    user:   users.sample,
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )

post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)

rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }

end

posts = Post.all

# Create comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create an admin user
admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )

# Create Canyon User
canyon = User.create!(
   name:    'Canyon',
   email:   'canyon.the.malamute@gmail.com',
   password: 'password',
   role: 'admin'
 )

# Create new user Luke
the_user = User.new(
   name:    'Lake',
   email:   'Lake.the.malamute@gmail.com',
   password: 'password',
   role: 'admin',
   auth_token: 'nil',
   the_user.save!
)
# set the expectation that the_user should have an attribute of auth_token set to nil.
# then save
#check again, but this time it should NOT be nil

 # Create a member
 member = User.create!(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# This is how you are to create a user, post for that user and comment for the post  
## Please note the posts_counter is required to create a user, and the comments counter and likes counter is required to create a post. 
@first_user  = User.create(name: 'Tom', photo: 'https://unsplash.com /photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
@first_post = Post.create(title: 'hello world', text: 'welcome', user_id: @first_user)
Comment.create(user_id: @first_user, post_id: @first_post,  text: 'first comment')
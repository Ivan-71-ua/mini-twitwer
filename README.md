🐦 Mini Twitter — Sinatra-based Social Network App
This project is a lightweight clone of Twitter, built entirely with Ruby and the Sinatra web framework. 
It delivers core features of a modern social media platform, including registration, authentication, posting messages with images, likes, comments, 
following/unfollowing, a personalized news feed, and private messaging (chat) — all powered by PostgreSQL and ActiveRecord.

🚀 Project Goals
To develop a fully functional web application where users can:

Sign up and log in securely

Create posts with text and images

Interact through likes, comments, and direct messages

Follow and unfollow other users

Explore personalized feed and chat in real-time

🛠 Technologies Used
Language: Ruby

Framework: Sinatra

Database: PostgreSQL

ORM: ActiveRecord

CSS Framework: Bulma

Server: WEBrick

Tools: Rack, Rake, Gem

📁 Project Structure
app.rb – main application file with all routing logic (GET/POST)

models/ – database models (user.rb, message.rb, etc.)

views/ – ERB templates for rendering HTML

public/uploads/ – image storage

config/database.yml – database configuration

config.ru – Rack config file

Rakefile – migration and task runner

🌐 Key Features
👤 User Account
Secure registration & login via bcrypt

Session-based authentication

📄 Posts & Feed
Create posts with optional image uploads

View your posts and a personalized timeline

Like and comment on posts

💬 Messaging
Send and receive private messages (chat-style)

View list of all conversations

👥 Social
Browse other users’ profiles

Follow/unfollow users

Navigate user profiles directly

🎨 UI & Styling
Responsive design via Bulma

Clean and intuitive interface

🧩 Implementation Highlights
All route logic in app.rb, separated into GET and POST

File uploads handled via Rack and saved to the local file system

Data managed via ActiveRecord with Rake for migrations

✅ Summary
This project demonstrates how to build a fully functional mini social network using minimal dependencies. 
It was created as a part of a lab assignment to learn and apply MVC architecture, database interaction, 
session management, file uploads, and responsive frontend design.

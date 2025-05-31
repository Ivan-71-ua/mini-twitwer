# 🐦 Mini Twitter — Sinatra-based Social Network App

This project is a **lightweight clone of Twitter**, built entirely with **Ruby** and the **Sinatra** web framework.  
It delivers core features of a modern social media platform, including:

- ✅ Registration & authentication  
- 📝 Posting messages with text and images  
- ❤️ Likes & 💬 comments  
- 👥 Following/unfollowing users  
- 📰 Personalized news feed  
- 📩 Private messaging (chat)

All powered by **PostgreSQL**, **ActiveRecord**, and styled with **Bulma CSS**.

---

## 🚀 Project Goals

To develop a fully functional web application where users can:

- Sign up and log in securely
- Create posts with text and images
- Interact through likes, comments, and direct messages
- Follow and unfollow other users
- Explore a personalized feed and chat in real time

---

## 🛠 Technologies Used

- **Language:** Ruby  
- **Framework:** Sinatra  
- **Database:** PostgreSQL  
- **ORM:** ActiveRecord  
- **CSS Framework:** Bulma  
- **Server:** WEBrick  
- **Other Tools:** Rack, Rake, Gem

---

## 📁 Project Structure

| File/Folder         | Description                                       |
|---------------------|---------------------------------------------------|
| `app.rb`            | Main application file with all routing logic     |
| `models/`           | Database models (e.g. `user.rb`, `message.rb`)   |
| `views/`            | HTML templates using ERB                         |
| `public/uploads/`   | Image storage                                     |
| `config/database.yml` | Database configuration file                   |
| `config.ru`         | Rack configuration file                          |
| `Rakefile`          | Task and migration runner                        |

---

## 🌐 Key Features

### 👤 User Account
- Secure registration & login using **bcrypt**
- Session-based authentication

### 📄 Posts & Feed
- Create posts with optional image uploads
- View your own and followed users' posts
- Like and comment on posts

### 💬 Messaging
- Chat-style private messaging
- View all active conversations

### 👥 Social
- Browse and visit other user profiles
- Follow or unfollow users

### 🎨 UI & Styling
- Responsive interface with **Bulma CSS**
- Clean, intuitive user experience

---

## 🧩 Implementation Highlights

- All routes implemented in `app.rb`, organized into `GET` and `POST` blocks
- Images are uploaded via Rack and stored in the file system (`public/uploads`)
- Database interactions handled with **ActiveRecord**
- Migrations and schema management via `Rake` tasks

---

## ✅ Summary

This project showcases how to build a complete **social media web app** using **Sinatra** and **Ruby** with minimal dependencies.  
Created as a lab assignment, it emphasizes:

- MVC architecture
- Session management
- File uploads
- User interaction features
- Responsive, component-based frontend

---


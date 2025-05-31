require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require './models/user'
require './models/message'
require './models/follow'
require './models/like'
require './models/comment'
require './models/private_message'



set :database_file, 'config/database.yml'
enable :sessions



get '/register' do
  erb :register
end

post '/register' do
  user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )

  if user.save
    session[:user_id] = user.id
    redirect '/profile'
  else
    @error = "Помилка реєстрації: #{user.errors.full_messages.join(', ')}"
    erb :register
  end
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/profile'
  else
    @error = "Невірний email або пароль"
    erb :login
  end
end


get '/logout' do
  session.clear
  redirect '/login'
end


get '/profile' do
  @user = current_user
  redirect '/login' unless @user
  erb :profile
end

post '/messages' do
  redirect '/login' unless current_user

  image_path = nil

  if params[:image] && params[:image][:filename] && params[:image][:tempfile]
    filename = "#{Time.now.to_i}_#{params[:image][:filename]}"
    save_path = File.join("public", "uploads", filename)

    begin
      File.open(save_path, 'wb') do |f|
        f.write(params[:image][:tempfile].read)
      end
      puts "DEBUG: Image saved to #{save_path}"
      image_path = "/uploads/#{filename}"
    rescue => e
      puts "ERROR saving file: #{e.message}"
    end
  end

  message = current_user.messages.build(
    content: params[:content],
    image: image_path
  )

  if message.save
    redirect '/profile'
  else
    @user = current_user
    @error = "Не вдалося зберегти повідомлення"
    erb :profile
  end
end


get '/users' do
  @users = User.where.not(id: current_user.id)
  erb :users
end

get '/users/:id' do
  @user = User.find_by(id: params[:id])
  redirect '/users' unless @user

  @is_following = current_user.followings.include?(@user)
  erb :user_profile
end



post '/follow/:id' do
  user_to_follow = User.find(params[:id])
  current_user.followings << user_to_follow unless current_user.followings.include?(user_to_follow)
  redirect "/users/#{user_to_follow.id}"
end

post '/unfollow/:id' do
  user_to_unfollow = User.find(params[:id])
  current_user.followings.delete(user_to_unfollow)
  redirect "/users/#{user_to_unfollow.id}"
end

get '/feed' do
  redirect '/login' unless current_user

  followed_ids = current_user.followings.pluck(:id)
  user_ids = followed_ids + [current_user.id]

  @messages = Message.where(user_id: user_ids).order(created_at: :desc)

  erb :feed
end

post '/messages/:id/delete' do
  redirect '/login' unless current_user

  message = Message.find_by(id: params[:id])

  if message && message.user == current_user
    message.destroy
  end

  redirect '/profile'
end


post '/messages/:id/like' do
  message = Message.find(params[:id])
  current_user.likes.find_or_create_by(message: message)
  redirect '/feed'
end

post '/messages/:id/unlike' do
  message = Message.find(params[:id])
  like = current_user.likes.find_by(message: message)
  like.destroy if like
  redirect '/feed'
end


post '/messages/:id/comments' do
  message = Message.find(params[:id])
  comment = message.comments.build(
    content: params[:content],
    user: current_user
  )

  comment.save
  redirect '/feed'
end


post '/users/:id/messages' do
  receiver = User.find(params[:id])
  content = params[:content]

  PrivateMessage.create!(
    sender: current_user,
    receiver: receiver,
    content: content
  )

  redirect "/users/#{receiver.id}"
end


#get '/inbox' do
# @messages = current_user.received_messages.order(created_at: :desc)
# erb :inbox
#end


get '/conversations' do
  redirect '/login' unless current_user

  sent_ids = current_user.sent_messages.pluck(:receiver_id)
  received_ids = current_user.received_messages.pluck(:sender_id)

  user_ids = (sent_ids + received_ids).uniq - [current_user.id]

  @conversations = User.where(id: user_ids)

  erb :conversations
end



get '/conversations/:id' do
  redirect '/login' unless current_user
  @recipient = User.find(params[:id])

  @messages = PrivateMessage
                .where(
                  "(sender_id = :me AND receiver_id = :them) OR (sender_id = :them AND receiver_id = :me)",
                  me: current_user.id, them: @recipient.id
                )
                .order(:created_at)

  erb :conversation
end

post '/conversations/:id' do
  receiver = User.find(params[:id])
  PrivateMessage.create!(
    sender: current_user,
    receiver: receiver,
    content: params[:content]
  )

  redirect "/conversations/#{receiver.id}"
end


helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end


class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'

        enable :sessions
        set :session_secret, 'secret'
    end

    helpers do
        def logged_in?
            !!session[:user_id]
        end

        def logged_in_as_teacher?
            logged_in? && session[:teacher]
        end

        def logged_in_as_student?
            logged_in? && session[:student]
        end

        def login_id
            session[:user_id]
        end

        def login(email)
            # impliment logic to take an instance of the User class
            session[:email] = email
        end

        def logout!
            session.clear
        end
    end

    get '/' do
        erb :index
    end

end
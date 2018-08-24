class TeachersController < ApplicationController

    get '/teachers' do
        if logged_in?
            @teacher = Teacher.find_by_id(session[:user_id])
            redirect "/teachers/#{@teacher.slug}"
        else
            redirect '/teachers/login'
        end
    end

    get '/teachers/login' do
        erb :'teachers/login'
    end

    post '/teachers/login' do
        @teacher = Teacher.find_by(username: params[:username]).authenticate(params[:password])
        if !!@teacher
            session[:user_id] = @teacher.id
            redirect '/teachers'
        else
            redirect '/teachers/login'
        end
    end

    
    get '/teachers/:slug' do
        @teacher = Teacher.find_by_slug(params[:slug])
        if logged_in? && login_id == @teacher.id
            erb :'teachers/index'
        else
            redirect '/teachers'
        end
    end
    
    post '/teachers/logout' do
        logout!
        redirect '/teachers/login'
    end

end
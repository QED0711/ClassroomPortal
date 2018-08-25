class TeachersController < ApplicationController

    get '/teachers' do
        if logged_in_as_teacher?
            @teacher = Teacher.find_by_id(session[:user_id])
            redirect "/teachers/#{@teacher.slug}"
        else
            redirect '/teachers/login'
        end
    end

    get '/teachers/signup' do
        erb :'teachers/signup'
    end

    post '/teachers/signup' do
        @teacher = Teacher.create(params)
        if !!@teacher
            session[:user_id] = @teacher.id
            session[:teacher] = true
            redirect '/teachers'
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
            session[:teacher] = true
            redirect '/teachers'
        else
            redirect '/teachers/login'
        end
    end

    
    get '/teachers/:slug' do
        @teacher = Teacher.find_by_slug(params[:slug])
        if logged_in_as_teacher? && login_id == @teacher.id
            erb :'teachers/index'
        else
            redirect '/teachers'
        end
    end

    get '/teachers/students/:slug' do
        @student = Student.find_by_slug(params[:slug])
        @teacher = Teacher.find_by_id(@student.teacher_id)
        if logged_in_as_teacher? && @teacher.id == session[:user_id]
            erb :'teachers/show'
        else
            redirect '/'
        end
    end


end
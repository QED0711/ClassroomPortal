class StudentsController < ApplicationController

    get '/students' do
        if logged_in_as_student?
            redirect "/students/#{Student.find_by_id(session[:user_id]).slug}"
        else
            redirect '/students/login'
        end
    end

    get '/students/signup' do
        erb :'students/signup'
    end
    
    post '/students/signup' do
        @student = Student.create(params)
        if @student
            session[:user_id] = @student.id
            session[:student] = true
            redirect "/students/#{@student.slug}"
        else
            session[:error] = "Please enter valid credentials"
            redirect '/students/signup'
        end
    end

    get '/students/login' do
        if logged_in_as_student?
            redirect "/students/#{Student.find_by_id(session[:user_id]).slug}"
        else
            erb :'students/login'
        end
    end

    post '/students/login' do
        @student = Student.find_by(username: params[:username]).authenticate(params[:password])
        if @student
            session[:user_id] = @student.id
            session[:student] = true
            redirect "/students/#{@student.slug}"
        else
            session[:error] = "Incorrect username or password"
            redirect '/students/login'
        end
    end

    get '/students/:slug' do
        @student = Student.find_by_slug(params[:slug])
        if @student && logged_in_as_student? && login_id == @student.id
            @student = Student.find_by_id(session[:user_id])
            @teacher = Teacher.find_by_id(@student.teacher_id)
            erb :'students/index'
        else
            session[:error] = "You must login before viewing a profile page"
            redirect '/students/login'
        end
    end

end
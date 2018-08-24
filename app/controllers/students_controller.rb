class StudentsController < ApplicationController

    get '/students' do
        if logged_in_as_student?
            redirect "/students/#{Student.find_by_id(session[:user_id]).slug}"
        else
            redirect '/students/login'
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
            redirect '/students/login'
        end
    end

    post '/students/logout' do
        logout!
        redirect '/students/login'
    end

    get '/students/:slug' do
        @student = Student.find_by_slug(params[:slug])
        if @student && logged_in_as_student? && login_id == @student.id
            @student = Student.find_by_id(session[:user_id])
            @teacher = Teacher.find_by_id(@student.teacher_id)
            erb :'students/index'
        else
            redirect '/students/login'
        end
    end

end
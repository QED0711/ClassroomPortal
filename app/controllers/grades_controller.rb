class GradesController < ApplicationController

    get '/grades/:slug' do
        @student = Student.find_by_slug(params[:slug])
        @teacher = Teacher.find_by_id(@student.teacher_id)

        # check to make sure only the student or student's teacher may view the individual grade page
        if (logged_in_as_student? && session[:user_id] == @student.id) || (logged_in_as_teacher? && session[:user_id] == @teacher.id)
            erb :'grades/show'
        else
            redirect '/'
        end
    end

    get '/grades/teachers/:slug' do

        if logged_in_as_teacher? 
            @teacher = Teacher.find_by_slug(params[:slug])
            erb :'grades/show-all'
        else
            session[:error] = "Access Denied (Teacher Access Only)"
            redirect '/'
        end
    end

end
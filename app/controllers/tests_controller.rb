class TestsController < ApplicationController 

    get '/tests' do
        "Test View"
    end

    get '/tests/:slug' do
        @test = Test.find_by_slug(params[:slug])
        if logged_in_as_teacher?
            @teacher = Teacher.find_by_id(session[:user_id])
            if @test.teacher_id = @teacher.id
                erb :'tests/index'
            end
        end

        if logged_in_as_student?
            @student = Student.find_by_id(session[:user_id])
            @teacher = Teacher.find_by_id(@student.teacher_id)
            if @test.teacher_id = @teacher.id
                redirect "/tests/#{@test.slug}/take-test"
            end
        end

        redirect

    end

    get '/tests/:slug/edit' do
        @test = Test.find_by_slug(params[:slug])
        if logged_in_as_teacher? 
            @teacher = Teacher.find_by_id(session[:user_id])
            if @teacher.tests.include?(@test.id)
                erb :'tests/edit'
            else
                redirect '/teacher'
            end
        else
            redirect '/'
        end
    end

    get '/tests/:slug/take-test' do
        if logged_in_as_student?
            @test = Test.find_by_slug(params[:slug])
            @student = Student.find_by_id(session[:user_id])
            erb :'tests/test'
        elsif logged_in_as_teacher?
            redirect "/tests/#{params[:slug]}"
        else
            redirect '/'
        end
    end

    post '/tests/:slug/grader' do
        @test = Test.find_by_slug(params[:slug])
        @questions = @test.question_ids.collect do |q_id|
            Question.find_by_id(q_id)
        end
        correct = 0
        @questions.each_with_index do |question, i| 
            if question.answer == params[:answer][i]
                correct += 1
            end
        end
        grade = (correct.to_f/@questions.count.to_f)*100.0
        "Grade #{grade}%"
    end

end
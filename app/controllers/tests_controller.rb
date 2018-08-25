require "sinatra/flash"

class TestsController < ApplicationController 

    get '/tests' do
    # list all tests (as links) by teacher. teachers and students can access
    end

    get '/tests/new' do
        if logged_in_as_teacher? 
            @teacher = Teacher.find_by_id(session[:user_id])
            erb :'tests/new'
        else
            redirect '/'
        end
    end

    post '/tests/new' do
        if params[:title] != ""
            @test = Test.create(title: params[:title], teacher_id: session[:user_id])
            redirect "/tests/#{@test.slug}/edit"
        else
            redirect '/tests/new'
        end
    end

    get '/tests/:slug' do
        @test = Test.find_by_slug(params[:slug])
        if logged_in_as_teacher?
            @teacher = Teacher.find_by_id(session[:user_id])
            if @test.teacher_id = @teacher.id
                redirect "/tests/#{@test.title}/edit"
            end
        end

        if logged_in_as_student?
            @student = Student.find_by_id(session[:user_id])
            @teacher = Teacher.find_by_id(@student.teacher_id)
            if @test.teacher_id = @teacher.id
                redirect "/tests/#{@test.slug}/take-test"
            end
        end

        redirect '/'

    end

    get '/tests/:slug/edit' do
        @test = Test.find_by_slug(params[:slug])
        if logged_in_as_teacher?
            if @test.teacher_id = session[:user_id]
                @teacher = Teacher.find_by_id(session[:user_id])
                erb :'tests/edit'
            else
                session[:error] = "This test does not belong to you"
                redirect '/teacher'
            end
        else
            session[:error] = "Only teachers may edit tests"
            redirect '/'
        end
    end

    patch '/tests/:slug/edit' do
        @test = Test.find_by_slug(params[:slug])
        #update test title
        @test.title = params[:title]
        @test.save
        # update each question of the test with the revised questions/answers (do even if not changed). 
        # delete a question if it has a blanck question or answer field
        @test.questions.each_with_index do |q, i| 
            if params[:questions][i] == "" || params[:answers][i] == ""
                q.delete
            else
                q.question = params[:questions][i]
                q.answer = params[:answers][i]
                q.save
            end
        end
        
        # second, add new question/answer pair to @test
        if params[:new_question] != "" && params[:new_answer] != ""
            @question = Question.create(question: params[:new_question], answer: params[:new_answer], test_id: @test.id)
            @test.questions << @question
            @test.save
        end
        redirect "/tests/#{@test.slug}"
    end

    delete '/tests/:slug/delete' do
        @test = Test.find_by_slug(params[:slug])
        @test.grades.each {|grade| grade.delete}
        @test.delete
        redirect '/teachers'
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
        score = (correct.to_f/@questions.count.to_f)*100.0
        @grade = Grade.create(score: score, test_id: @test.id, student_id: session[:user_id])
        redirect "/grades/#{Student.find(session[:user_id]).slug}"
    end

end
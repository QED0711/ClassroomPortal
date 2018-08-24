class TestsController < ApplicationController 

    get '/tests' do
        "Test View"
    end

    get '/tests/:slug' do
        @test = Test.find_by_slug(parms[:slug])
        
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

end
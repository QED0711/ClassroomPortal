class GradesController < ApplicationController

    get '/grades/:slug' do
        @student = Student.find_by_slug(params[:slug])
        erb :'grades/show'
    end

end
class SessionsController < ApplicationController

    get '/login' do
        erb :'session/login'
    end

end
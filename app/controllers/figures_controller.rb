class FiguresController < ApplicationController

    get '/' do
        redirect '/figures'
    end

    get '/figures' do
        @figures = Figure.all
        erb :'/figures/index'
    end 

    get '/figures/new' do
        #binding.pry 
        @titles = Title.all
        @landmarks = Landmark.all
        erb :'/figures/new'
    end

      get '/figures/:id' do
        @figure = Figure.find_by_id(params[:id])
        erb :'/figures/show' 
    end
    
    post '/figures' do
        #binding.pry
        @figure = Figure.create(params[:figure])
        if  !params[:landmark][:name].empty?
            @landmark = Landmark.create(params[:landmark]) 
            @figure.landmarks << @landmark
        end
        if  !params[:title][:name].empty?
            @title = Title.create(params[:title])
            @figure.titles << @title
        end
        @figure.save   
        redirect '/figures/show'
    end

    get '/figures/:id/edit' do
        @titles = Title.all
        @landmarks = Landmark.all 
        @figure = Figure.find_by_id(params[:id])
        erb :'/figures/edit' 
    end

    patch '/figures/:id' do
        @figure = Figure.find(params[:id])
        @figure.update(params[:figure])
        if  !params[:landmark][:name].empty?
            @landmark = Landmark.create(params[:landmark]) 
            @figure.landmarks << @landmark
        end
        if  !params[:title][:name].empty?
            @title = Title.create(params[:title])
            @figure.titles << @title
        end 
        @figure.save 
        redirect "/figures/#{@figure.id}"
    end 

end
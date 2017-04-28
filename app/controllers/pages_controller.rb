class PagesController < ApplicationController

    http_basic_authenticate_with name: "yurukyara", password: "yurukyara", only: :manage

    def confirm
    end
    
    def index
        @sum = params[:sum]
        @user = User.find_by(id: 1)
        @markovs = Dictionary.all
        @markov = Dictionary.last
        @adobe = params[:adobe_id]
        p @adobe
        if @adobe == "1"
            p "1です！"
            @adobe = "ようこそ県民のみなさん！"
        else
            p "2です！"
            @adobe = "ようこそ県外民のみなさん！"
        end
    end
    
    def manage
        @user = User.find_by(id: 1)
        @chart_data = Dictionary.order('date ASC').group(:date).count
        @dic = Dictionary.all
    end
end

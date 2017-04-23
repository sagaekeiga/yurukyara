class PagesController < ApplicationController

    http_basic_authenticate_with name: "yurukyara", password: "yurukyara", only: :manage

    def confirm
    end
    
    def index
        @adobe = params[:adobe_id]
        @images = Image.limit(20)
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
        @image = Image.new
    end
end

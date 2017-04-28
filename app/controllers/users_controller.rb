class UsersController < ApplicationController
    
    def new
     @user = User.new
    end
    
    def create
      name = user_params[:name]
      region = user_params[:region]
      profile = user_params[:profile]
      upload_image1 = user_params[:image1]
      upload_image2 = user_params[:image2]
      upload_image3 = user_params[:image3]
      upload_image4 = user_params[:image4]
      upload_image5 = user_params[:image5]
      upload_evo = user_params[:evolution]
      user = {}
      if upload_image1 != nil
        user[:image1] = upload_image1.read
      end
      if upload_image2 != nil
        user[:image2] = upload_image2.read
      end
      if upload_image3 != nil
        user[:image3] = upload_image3.read
      end
      if upload_image4 != nil
        user[:image4] = upload_image4.read
      end
      if upload_image5 != nil
        user[:image5] = upload_image5.read
      end
      if upload_evo != nil
        user[:evolution] = upload_evo.read
      end
      user[:name] = name
      user[:region] = region
      user[:profile] = profile

      @user = User.new(user)
      if @user.save
        flash[:success] = "画像を保存しました。"
        redirect_to pages_manage_path
      else
        flash[:error] = "保存できませんでした。"
      end 
    end
    
    def show_image1
      @user = User.find(params[:id])
      send_data @user.image1, :type => 'image/jpeg', :disposition => 'inline'
    end
    
    def show_image2
      @user = User.find(params[:id])
      send_data @user.image2, :type => 'image/jpeg', :disposition => 'inline'
    end
    
    def show_image3
      @user = User.find(params[:id])
      send_data @user.image3, :type => 'image/jpeg', :disposition => 'inline'
    end
    
    def show_image4
      @user = User.find(params[:id])
      send_data @user.image4, :type => 'image/jpeg', :disposition => 'inline'
    end
    
    def show_image5
      @user = User.find(params[:id])
      send_data @user.image5, :type => 'image/jpeg', :disposition => 'inline'
    end

    def show_evo
      @user = User.find(params[:id])
      send_data @user.evolution, :type => 'image/jpeg', :disposition => 'inline'
    end
    
    def edit
      @user = User.find(params[:id])
    end

    def update
      name = user_params[:name]
      region = user_params[:region]
      profile = user_params[:profile]
      upload_image1 = user_params[:image1]
      upload_image2 = user_params[:image2]
      upload_image3 = user_params[:image3]
      upload_image4 = user_params[:image4]
      upload_image5 = user_params[:image5]
      upload_evo = user_params[:evolution]
      user = {}
      if upload_image1 != nil
        user[:image1] = upload_image1.read
      end
      if upload_image2 != nil
        user[:image2] = upload_image2.read
      end
      if upload_image3 != nil
        user[:image3] = upload_image3.read
      end
      if upload_image4 != nil
        user[:image4] = upload_image4.read
      end
      if upload_image5 != nil
        user[:image5] = upload_image5.read
      end
      if upload_evo != nil
        user[:evolution] = upload_evo.read
      end
      user[:name] = name
      user[:region] = region
      user[:profile] = profile
      
      @user = User.find(params[:id])
      @user[:image1] = upload_image1.read
      @user.update(user_params)
      redirect_to pages_manage_path
    end
    
      private
      
        def user_params
          params.require(:user).permit(:name, :region, :profile, :image1, :image2, :image3, :image4, :image5, :evolution)
        end
        
end

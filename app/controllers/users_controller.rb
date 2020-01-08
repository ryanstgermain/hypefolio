class UsersController < ApplicationController
    before_action :set_user, except: [:new, :index, :create]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]

    def index
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:error] = "You are not allowed to access this page"
            redirect_to root_path
        else
            @users = User.order("created_at DESC").paginate(page: params[:page], per_page: 5)
        end
    end
    
    def new
        if logged_in?
            flash[:error] = "You are already logged in"
            redirect_to root_path
        else
            @user = User.new
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to Hypefolio, #{@user.username}"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end

    def show
    end

    def destroy
        @user.destroy
        flash[:error] = "Users and everything created by user have been deleted"
        redirect_to users_path
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :avatar, :fullname)
        # params.require(:user).permit(:username, :email, :password, :avatar, :fullname, :bio, :platform, :region, :battletag, :btcode, :owaccount, :avatar_cache, :remove_avatar)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:error] = "You can only edit your own account"
            redirect_to root_path
        end
    end

    def require_admin
        if logged_in? and !current_user.admin?
            flash[:error] = "Only admins can perform that action"
            redirect_to root_path
        end
    end
end

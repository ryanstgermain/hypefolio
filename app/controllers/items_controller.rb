class ItemsController < ApplicationController
    before_action :set_item, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @items = Item.paginate(page: params[:page], per_page: 5)
    end

    def new
        @item = Item.new
    end

    def edit
    end

    def create
        @item = Item.new(item_params)
        @item.user = current_user
        if @item.save
            flash[:success] = "Item was successfully created"
            redirect_to item_path(@item)
        else
            render 'new'
        end
    end

    def update
        if @item.update(item_params)
            flash[:success] = "Item was successfully updated"
            redirect_to item_path(@item)
        else
            render 'edit'
        end
    end

    def show
    end

    def destroy
        @item.destroy
        flash[:danger] = "Item was successfully deleted"
        redirect_to items_path
    end

    private

    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.require(:item).permit(:name, :size, :condition, :purchase_price, :purchase_date, category_ids: [])
    end

    def require_same_user
        if current_user != @item.user and !current_user.admin?
            flash[:danger] = "You can only edit or delete your own item"
            redirect_to root_path
        end
    end
end
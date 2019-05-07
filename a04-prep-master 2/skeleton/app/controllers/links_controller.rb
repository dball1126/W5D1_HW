class LinksController < ApplicationController

    def new
        @link = Link.new
    end
    
    def create
        @link = Link.new(link_params)
        if @link.save
            redirect_to link_url(@link)
        else
            flash.now[:errors] = @link.errors.full_messages
            render :new
        end
    end
    def edit
        @link = Link.find(params[:id])
        redirect_to link_url(@link)
    end

    def show
        @link = Link.find(params[:id])
    end

    def update
        @link = Link.find(params[:id])
        if @link.update_attributes(link_params)
            redirect_to link_url(@link)
        else
            flash.now[:errors] = @link.errors.full_messages
            render :edit
        end
    end

    def index
        @links = Link.all
    end

    def destroy
        @link = Link.find(params[:id])
        @link.destroy
        redirect_to links_url
    end


    def show
        @link = Link.find(params[:id])
    end

    private

    def link_params
        params.require(:link).permit(:url, :title)
    end
end
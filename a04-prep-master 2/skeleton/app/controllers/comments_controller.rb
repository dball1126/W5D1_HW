class CommentsController < ApplicationController

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.link_id = params[:link_id]
        @comment.user_id = current_user.id
        @comment.save
        flash[:errors] = @comment.errors.full_messages
        redirect_to links_url
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to links_url
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

end
class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy new ]
  before_action :set_post, only: %i[ show edit update destroy ]


  
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end


  def edit
  end


 def create
  @post = Post.new(post_params)
  if @post.save
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post created!" }
      format.turbo_stream  # Sends Turbo Stream to prepend/update the list
    end
  else
    redirect_to new_post_path, alert: "Error creating post."
  end
end

   def update
      if @post.update(post_params)
        redirect_to posts_path, notice: "Post was successfully updated."
      else
        redirect_to edit_post_path(@post), status: :unprocessable_entity, alert: "Post could not be updated."
      end
  end


  def destroy
    @post.destroy!
    
    respond_to do |format|
      format.html{redirect_to posts_path, notice:"succesfully deleted"}
      format.turbo_stream 
    end
  end

  private
   
    def set_post
      @post = Post.find(params.expect(:id))
    end

 
    def post_params
      params.expect(post: [ :title, :body ])
    end
end

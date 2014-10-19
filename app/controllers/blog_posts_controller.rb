class BlogPostsController < ApplicationController
  before_action :authenticate_user!, :redirect_unless_is_god, except: [:show, :blog]
  before_action :set_blog_post, :set_meta_content, only: [:show, :edit, :update, :destroy]

  # GET /blog
  def blog
    @blog_posts = BlogPost.all
  end

  # GET /blog_posts
  # GET /blog_posts.json
  def index
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrador de Blog", blog_posts_path
    
    @blog_posts = BlogPost.all
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
    add_breadcrumb "Blog", blog_path
    add_breadcrumb @blog_post.title, @blog_post
  end

  # GET /blog_posts/new
  def new
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrador de Blog", blog_posts_path
    add_breadcrumb "Nuevo Post", new_blog_post_path

    @blog_post = BlogPost.new
    2.times { @blog_post.blog_post_contents.build }
  end

  # GET /blog_posts/1/edit
  def edit
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrador de Blog", blog_posts_path
    add_breadcrumb "Editar Post", edit_blog_post_path(@blog_post)
    
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blog_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_posts/1
  # PATCH/PUT /blog_posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.friendly.find(params[:id])
    end
    
    def set_meta_content
      @meta_content = @blog_post.subtitle
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :subtitle, :photo, :hashtags, :user_id, blog_post_contents_attributes: [:id, :photo, :content, :_destroy])
    end
end

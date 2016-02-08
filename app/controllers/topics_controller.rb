class TopicsController < ApplicationController
# #7
  before_action :require_sign_in, except: [:index, :show]
# #8
  before_action :authorize_user, except: [:index, :show]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
     @topic = Topic.new
     @topic.name = params[:topic][:name]
     @topic.description = params[:topic][:description]
     @topic.public = params[:topic][:public]

     if @topic.save
       redirect_to @topic, notice: "Topic was saved successfully."
     else
       flash.now[:alert] = "Error creating topic. Please try again."
       render :new
     end
   end

   def edit
     @topic = Topic.find(params[:id])
   end

   def update
     @topic = Topic.find(params[:id])

     @topic.name = params[:topic][:name]
     @topic.description = params[:topic][:description]
     @topic.public = params[:topic][:public]

     if @topic.save
        flash[:notice] = "Topic was updated."
       redirect_to @topic
     else
       flash.now[:alert] = "Error saving topic. Please try again."
       render :edit
     end
   end

   def destroy
     @topic = Topic.find(params[:id])

     if @topic.destroy
       flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the topic."
       render :show
     end
   end

# #9
   def authorize_user
     action = params[:action]
             if (action == 'update' || action == 'edit') && !current_user.admin? && !current_user.moderator?
                 flash[:alert] = "You must be an admin to do that."
                 redirect_to topics_path
             elsif (action == 'new' || action == 'create' || action == 'destroy') && !current_user.admin?
                 flash[:alert] = "You must be an admin to do that."
                 redirect_to topics_path
             end
 end

 private
 def topic_params
   params.require(:topic).permit(:name, :description, :public)
 end
end

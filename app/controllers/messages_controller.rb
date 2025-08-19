class MessagesController < ApplicationController

  before_action :set_community, only: [:new, :create, :index]

  def index
    # authorize @community
    @membership = Membership.find_by(user_id: current_user.id, community_id: @community.id)
    @messages = policy_scope(Message).where(community_id: @community.id)
    @message = Message.new
    # @memberships = policy_scope(Membership).where(current_user.id)


  end

  def show
    @message = Message.find(params[:id])
    authorize @message
    @new_message = Message.new
  end

  def new
    # we need @restaurant in our `simple_form_for`
    @message = Message.new
    authorize @message
    authorize @community
  end

  def create
    @message = Message.new(message_params)
    # we need `recipe_id` to associate review with corresponding recipe

    # authorize @community
    @message.user_id = current_user.id
    @message.community_id = @community.id
    authorize @message
    @message.save!
    redirect_to community_messages_path(@community, anchor:"message-id--#{@message.id}")
  end

  def destroy
    @message = Message.find(params[:id])
    authorize @message
    @message.destroy
    redirect_to community_messages_path(@message.community)
  end


  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def message_params
    params.require(:message).permit(:message)
  end
end

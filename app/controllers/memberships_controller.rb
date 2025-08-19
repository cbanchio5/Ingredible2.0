class MembershipsController < ApplicationController

  def index
    @memberships = policy_scope(Membership).where(user_id: current_user).includes(:community)
  end

  def show
    @membership = Membership.find(params[:id])
    authorize @membership
  end

  def new
    @membership =  Membership.new
    authorize @membership
    @community = Community.find(params[:communitiy_id])
    authorize @community
  end

  def create
    @membership = Membership.new(params[:id])
    authorize @membership
    @community = Community.find(params[:community_id])
    @membership.community_id = @community.id
    @membership.user_id = current_user.id
    #relationship does not exist
    if  @membership.save
      ##Create a message for the Message policy to work
      @welcome_message = Message.create(user_id: current_user.id, community_id: @community.id, message:"Hello!")
      redirect_to community_messages_path(@community)
    else
      redirect_to communities_path, notice: "You already joined this community"
    end

  end

  def destroy
    @membership = Membership.find(params[:id])
    authorize @membership
    @membership.destroy
    redirect_to communities_path
  end

  # def mymemberships
  #   @memberships = policy_scope(Membership).where(user_id: current_user).includes(:community)
  #   authorize @memberships

  # end

end

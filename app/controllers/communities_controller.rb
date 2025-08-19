class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :update, :edit]

  def index
    @communities = policy_scope(Community).includes(:memberships)

    # @membership = @communities.membership
    # authorize @membership

  end

  def show
    authorize @community
  end

  def edit
    authorize @community
  end

  def update
    authorize @community
    @community.update(community_params)
    redirect_to communities_path
  end

  def mycommunities
    @memberships = Membership.where(user_id: current_user.id)
  end

  private

  def community_params
    params.require(:community).permit(:name, :description)
  end

  def set_community
    @community = Community.find(params[:id])
  end
end

class DependentsController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :create, :update, :destroy]
  before_action :set_dependent, only: [:show, :edit, :update, :destroy]

  def index
    @dependents = @user.dependents.all
    render json: @dependents 
  end

  def show
  end

  def new
    # @dependent = dependent.new
  end

  def edit
  end

  def create
    @dependent = @user.dependents.new(dependent_params)
    respond_to do |format|
      if @dependent.save
        format.json { render json: @dependent }
      else
        format.json { render json: 'error' }
      end
    end
  end

  def update
    respond_to do |format|
      if @dependent.update_attributes(dependent_params)
        format.json { render json: @dependent }
      else
        format.json { render json: 'error' }
      end
    end
  end

  def destroy
    @dependent.destroy
    respond_to do |format|
      format.json { render json: true, :status => :ok }
    end
  end

  private
    def set_user
      logger.debug("user is "+params[:id].to_s);
      @user = User.find(params[:user_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_dependent
      @dependent = @user.dependents.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dependent_params
      params.require(:dependent).permit(:type,:name,:location)
    end
end

class PetsController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :create, :update, :destroy]
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = @user.pets.all
    render json: @pets 
  end

  def show
  end

  def new
    # @pet = pet.new
  end

  def edit
  end

  def create
    @pet = @user.pets.new(pet_params)
    respond_to do |format|
      if @pet.save
        format.json { render json: @pet }
      else
        format.json { render json: 'error' }
      end
    end
  end

  def update
    respond_to do |format|
      if @pet.update_attributes(pet_params)
        format.json { render json: @pet }
      else
        format.json { render json: 'error' }
      end
    end
  end

  def destroy
    @pet.destroy
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
    def set_pet
      @pet = @user.pets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_params
      params.require(:pet).permit(:type,:name,:location)
    end
end

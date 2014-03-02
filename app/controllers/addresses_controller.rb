class AddressesController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :create, :update, :destroy]
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = @user.addresses.all
    render json: @addresses 
  end

  def show
  end

  def new
    # @address = address.new
  end

  def edit
  end

  def create
    @address = @user.addresses.new(address_params)
    respond_to do |format|
      if @address.save
        format.json { render json: @address }
      else
        format.json { render json: 'error' }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update_attributes(address_params)
        format.json { render json: @address }
      else
        format.json { render json: 'error' }
      end
    end
  end

  def destroy
    @address.destroy
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
    def set_address
      @address = @user.addresses.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:type,:name,:location)
    end
end

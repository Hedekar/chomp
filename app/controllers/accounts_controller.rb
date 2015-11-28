class AccountsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :check_profile
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  
  def index
    @accounts = Account.all
  end
  
  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @users = User.where(:account_id => current_account.id, :is_main => 0)
  end

  # GET /accounts/new
  def new
    @account = Account.new
    render layout: "simple"
  end

  # GET /accounts/1/edit
  def edit
    render layout: "modal"
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        session[:account_id] = @account.id
        @account.users.create(:is_main => 1, :gender => 3, :birth => "")
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @account }
      else
        if @account.errors.any?
          flash.now[:error] = []
          for message_error in @account.errors.full_messages
            flash.now[:error] << message_error
          end
        end
        format.html { render :new, layout: "simple" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_account
      if current_account.get_main_user != nil
        @main_user = current_account.get_main_user
      else
        @main_user = User.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:email, :password, :password_confirmation)
    end
end

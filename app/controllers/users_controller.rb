class UsersController < ApplicationController
	skip_before_action :authorize, only: [:new, :create, :index], if: :zero_users?

	def zero_users?
		User.count == 0
	end
	
	def index
		@users = User.order(:name)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html {redirect_to users_url, notice: "User #{@user.name} was successfully created"}
				format.json {render action: 'new', status: :created, location: @user}
			else
				format.html {render action: 'new'}
				format.json {render json: @user.errors, stauts: :unprocessable_entity}
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		#@user = User.find(params[:id])
		@pass = BCrypt::Password.create(edit_params[:new_password])
		if @user and @user.authenticate(edit_params[:password])
			@user.update(password_digest: @pass)
			respond_to do |format|
				if @user.save
					format.html {redirect_to users_url, notice: "User #{@user.name} was successfully created"}
					format.json {render action: 'new', status: :created, location: @user}
				else
					format.html {redirect_to edit_user_path(@user), "Wrong Password"}
				end
			end
		end
	end

	def destroy
		begin
			@user = User.find(params[:id])
			@user.destroy
			flash[:notice] = "User #{@user.name} deleted"
			rescue StandardError => e
				flash[:notice] = e.message
		end
		respond_to do |format|
		format.html { redirect_to users_url }
		format.json { head :no_content }
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :password)
	end

	def edit_params
		params.require(:user).permit(:name, :password, :new_password)
	end


end

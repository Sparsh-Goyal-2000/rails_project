module Admin
  class CatagoriesController < AdminController
    before_action :ensure_user_is_admin
    before_action :set_catagory, only: %i[ show edit update destroy ]

    # GET /catagories or /catagories.json
    def index
      @catagories = Catagory.all
    end

    # GET /catagories/1 or /catagories/1.json
    def show
      @subcatagories = @catagory.subcatagories
    end

    # GET /catagories/new
    def new
      @catagory = Catagory.new
    end

    # GET /catagories/1/edit
    def edit
    end

    def catagory_with_subcatagory
      @catagories = Catagory.all
    end

    # POST /catagories or /catagories.json
    def create
      @catagory = Catagory.new(catagory_params)
      respond_to do |format|
        if @catagory.save
          format.html { redirect_to admin_catagory_path(@catagory), notice: "Catagory was successfully created." }
          format.json { render :show, status: :created, location: @catagory }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @catagory.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /catagories/1 or /catagories/1.json
    def update
      respond_to do |format|
        if @catagory.update(catagory_params)
          format.html { redirect_to admin_catagory_path(@catagory), notice: "Catagory was successfully updated." }
          format.json { render :show, status: :ok, location: @catagory }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @catagory.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /catagories/1 or /catagories/1.json
    def destroy
      if @catagory.destroy
        respond_to do |format|
          format.html { redirect_to admin_catagories_url, notice: "Catagory was successfully destroyed." }
          format.json { head :no_content }
        end
      else
        redirect_to admin_catagories_url, alert: 'Catagory can\'t be deleted'
      end
    end

    private

    def set_catagory
      @catagory = Catagory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def catagory_params
      params.require(:catagory).permit(:title, :parent_id)
    end
  end
end
class SampleTypesController < ApplicationController
  def index
    @sample_types = SampleType.all
    render layout: false if params[:rendering]
  end

  def show
  end

  def new
    @sample_type = SampleType.new
  end

  def create
    @sample_type = SampleType.new(sample_type_params)
    if @sample_type.save
      flash[:success] = "New sample type successfully added"
      redirect_to "configurations"
    else
      flash[:error] = "Error saving sample type"
      render "new"
    end
  end

  def edit
    @sample_type = SampleType.find(params[:id])
  end

  def update
    @sample_type = SampleType.find(params[:id])
    if @sample_type.update_attributes(sample_type_params)
      flash[:success] = "Sample type successfully updated"
      redirect_to "configurations"
    else
      flash[:error] = "Error updating sample type"
      render "edit"
    end
  end

  def destroy
    SampleType.find(params[:id]).destroy
    flash[:success] = "Sample type has been deleted"
  end

  private
    def sample_type_params
      params.require(:sample_type).permit(:name)
    end
end

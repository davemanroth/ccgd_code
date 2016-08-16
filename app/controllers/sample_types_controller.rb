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
    @sample_type = SampleType.new
  end

  def edit
    @sample_type = SampleType.find(params[:id])
  end

  def update
    @sample_type = SampleType.find(params[:id])
  end

  def destroy
    @sample_type = SampleType.find(params[:id])
  end
end

class ConfigurationsController < ApplicationController

  before_action :load_model_hash
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def load_model_hash
      @model_hash = {
        address: Address,
        location: Location,
        organization: Organization,
        labgroup: LabGroup,
        platform: Platform,
        sample: SampleType
      }
    end

end

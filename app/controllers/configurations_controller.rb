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

  def load_partial
  end

  private
    def load_model_hash
      @model_hash = {
        addresses: Address,
        locations: Location,
        organizations: Organization,
        lab_groups: LabGroup,
        platforms: Platform,
        sample_types: SampleType
      }
    end

end

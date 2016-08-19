class ConfigurationsController < ApplicationController

  before_action :load_model_hash
  def index
    authorize! :manage, :all
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

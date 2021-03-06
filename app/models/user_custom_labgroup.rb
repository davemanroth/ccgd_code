class UserCustomLabgroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  validates :custom_labgroup_building, presence: { message: "You must enter a building to add an Labgroup" }, unless: :custom_labgroup_name_nil?
  validates :custom_street, presence: { message: "You must enter a street address to add a Labgroup" }, unless: :custom_labgroup_name_nil?


  private

    def custom_labgroup_name_nil?
      self.custom_labgroup_name.nil?
    end
end

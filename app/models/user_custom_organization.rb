class UserCustomOrganization < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  validates :custom_street, presence: { message: "You must enter a street address to add an organization" }, unless: :custom_org_name_nil?

  private

    def custom_org_name_nil?
      self.custom_org_name.nil?
    end
end

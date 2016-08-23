module UsersHelper

  def apply_admin_updates(user)
    status = admin_update_params[:status]
    roles = admin_update_params[:roles]
    user.status = status unless user.status == status
    if !roles.nil?
      roles.delete_if { |role| role.empty? }
      roles = roles.map { |role| role.to_i }
      if roles.size > user.role_ids.size
        add_roles(user, roles)
      else
        remove_roles(user, roles)
      end
    end
  end

  def add_roles(user, roles)
    role_ids = user.role_ids || [];
    to_add = roles - role_ids
    if !to_add.empty?
      to_add.each do |t|
        role = Role.find(t)
        user.roles << role
      end
    end
  end

  def remove_roles(user, roles)
    to_remove = user.role_ids - roles
    if !to_remove.empty?
      to_remove.each do |t|
        role = Role.find(t)
        user.roles.delete(role)
      end
    end
  end

  # Add labgroup records to user object
  def add_lab_groups(user)
    vals = lab_group_params.values.first
    if !vals.nil?
      vals.each do |id|
        if !id.empty?
          lg = LabGroup.find(id)
          user.lab_groups << lg
        end
      end
    end
  end

  def organization_selected?(params)
    !params[:organization_id].empty?
  end

  def initialize_custom_fields(user)
    user.user_custom_organization ||= UserCustomOrganization.new
    user.user_custom_labgroup ||= UserCustomLabgroup.new
  end


end

module UsersHelper

  def apply_admin_updates(user)
    status = admin_update_params[:status]
    roles = admin_update_params[:roles].delete_if { |role| role.empty? }
    user.status = status unless user.status == status
    add_roles(user, roles) unless roles.empty?
  end

  def add_roles(user, roles)
    # Rails.logger.info("ROLES: #{roles}")
    roles = roles.map { |role| role.to_i }
    new_roles = roles - user.role_ids
    if !new_roles.empty?
      new_roles.each do |nr|
        role = Role.find(nr)
        user.roles << role
      end
    end
  end

  # Add labgroup records to user object
  def add_lab_groups(user)
    vals = lab_group_params.values.first
    vals.each do |id|
      if !id.empty?
        lg = LabGroup.find(id)
        user.lab_groups << lg
      end
    end
  end



end

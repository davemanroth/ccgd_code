module UsersHelper

  def apply_admin_updates(user)
    status = admin_update_params[:status]
    roles = admin_update_params[:roles]
    user.status = status unless user.status == status
    add_roles(user, roles)
    # Rails.logger.info("PARAMS: #{status}")
  end

  def add_roles(user, roles)
    roles.each do |r|
      if !r.empty? && !duplicates?(user, r)
        role = Role.find(r)
        user.roles << role
      end
    end
  end

  def duplicates?(user, role_id)
    dup = false
    user.roles.each do |role|
      if role.id == role_id
        dup = true
        break
      end
    end
    dup
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

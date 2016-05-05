module AddressHelper

  def add_address(data)
    address = Address.new(
      street: data.custom_org_street,
      city: data.custom_org_city,
      country: data.custom_org_country,
      state_id: data.state_id
    )
    if address.save
      address.id
    end
  end
end

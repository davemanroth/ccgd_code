module AddressHelper

  def add_address(data)
    address = Address.new(
      street: data.custom_street,
      city: data.custom_city,
      country: data.custom_country,
      state_id: data.state_id
    )
    if address.save
      address
    end
  end
end

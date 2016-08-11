module ConfigurationsHelper
  def hash_options(model_hash)
    hashed = {}
    model_hash.keys.each do |mod|
      hashed[mod.to_s.capitalize] = mod.to_s
    end
    hashed
  end
end

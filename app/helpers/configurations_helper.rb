module ConfigurationsHelper
  def hash_options(model_hash)
    hashed = {}
    model_hash.keys.each do |mod|
      code = mod.to_s.split('_').join(' ')
      hashed[code.capitalize] = mod.to_s
    end
    hashed
  end
end

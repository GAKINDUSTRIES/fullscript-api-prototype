class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  # Resize the image to fit within the specified dimensions while retaining the aspect ratio
  # of the original image. If necessary, crop the image in the larger dimension.
  version :normal do
    process resize_to_fill: [500, 500]
  end

  # Resize the image to fit within the specified dimensions while retaining the aspect ratio
  # of the original image. If necessary, crop the image in the larger dimension.
  version :small_thumb do
    process resize_to_fill: [200, 200]
  end

  protected

  def extension_white_list
    %w[jpg jpeg png]
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end
end

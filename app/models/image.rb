class Image < ActiveRecord::Base
  require 'mime/types'
  
  acts_as_taggable

  # Paperclip: http://jimneath.org/2008/04/17/paperclip-attaching-files-in-rails/
  has_attached_file :file,
  :styles => {
    :thumb => "100x100#"
  }
  
  # Paperclip Validations
  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => [
    'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/gif', 'image/bmp', 'image/tiff'
  ]
  
  # Sweep file on deletion
  before_destroy :destroy_files
  
  # Fix the mime types. Make sure to require the mime-types gem
  def swfupload_file=(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.file = data
  end
  
  def destroy_files
    path = "#{RAILS_ROOT}/public/files/#{id}"
    FileUtils.rmtree(path) if File.exists? path
  end
end

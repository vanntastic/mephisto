require 'fileutils'
TINYMCE_PATH = File.join(RAILS_ROOT, "vendor/plugins/tinymce")

namespace :tinymce do
  
  desc 'Copy all files need for tinymce'
  task :install do
    tinymce_path = File.join(TINYMCE_PATH, "javascripts/tinymce/jscripts/*")
    js_path = File.join(RAILS_ROOT,"public/javascripts/")
    
    # using rsync -aC copies ignores the svn files
    system("rsync -aC #{tinymce_path} #{js_path}")
    
    puts "Tiny MCE Files have been installed successfully"
  end
  
end

require 'fileutils'

namespace :themes do
  
  desc 'Generates a new theme stub based on the default simpla theme'
  task :create do
    instantiator
    
    if ENV['NAME'].blank?
      
      puts "USAGE : rake themes:create NAME='name_of_theme' SITE=['site-1']"
      
    elsif File.exists?(@new_theme_path)
      
      puts "Theme already exists... remove it using rake theme:destroy first or use 
            another name..."
      
    else
      
      # do a rsync copy to avoid svn and git nonsense
      puts "Copying Template...."
      system("rsync -aC #{@default_template}/* #{@new_theme_path}")
      
      puts "Removing old credentials.."
      File.delete @about_yml
      puts "Stamping your credentials.."
      File.open(@about_yml, "w+") do |file|
        file << "title: #{ENV['NAME']}\n"
        file << "author: you silly\n"
        file << "version: your.version.no\n"
        file << "homepage: http://your.special.blog\n"
        file << "summary: This is a theme for #{ENV['NAME']}"
      end
      
      puts "Theme : #{ENV['NAME']} has been created!"
      puts "You can start rewriting the theme now..."
      layout_file = File.join(@new_theme_path,'layouts/layout.liquid')
      system("mate #{layout_file}") if system("mate")
    end
    
  end
  
  desc 'Removes a theme'
  task :destroy do
    instantiator
    
    if ENV['NAME'].blank?
      puts "USAGE : rake themes:destroy NAME='name_of_theme'"
    else
      not_found = "The path : #{@new_theme_path} doesn't exist"
      File.exists?(@new_theme_path) ? FileUtils.rm_r(@new_theme_path) : puts(not_found)
      puts("The theme : #{ENV['NAME']} has been removed!")
    end
    
  end
  
end

def instantiator
  ENV['SITE'] ||= "site-1"
  ENV['NAME'] ||= ""
  
  @theme_path = File.join(RAILS_ROOT, "themes")
  @default_template = File.join(@theme_path,"default")
  @site_path = File.join(@theme_path, ENV['SITE'])
  @new_theme_path = File.join(@site_path, ENV['NAME'])
  @about_yml = File.join(@new_theme_path, "about.yml")
end

# i like String#blank?, so let's use it again
class String; def blank?; self.strip.length == 0; end; end
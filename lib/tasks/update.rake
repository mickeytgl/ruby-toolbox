require 'rubygems'
require 'gems'

namespace :update do 
  desc "It updates the ruby tools from the rubygems API"

  task tools: :environment do


    puts Gems.info("rails")["name"]

    def update_tool_attributes 
      #Loop through my tools
      tools = Tool.all
      tools.each do |tool|
        puts "#{tool.name}"
      end
    end

    update_tool_attributes
  end

  task task2: :environment do
    puts 'task 2'
  end
end


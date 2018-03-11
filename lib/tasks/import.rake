require 'csv'

namespace :import do 
  desc "Import gems from CSV"
  task tools: :environment do 
    filename = File.join Rails.root, "gems.csv"
    imported = 0 
    errored  = 0 

    CSV.foreach(filename, headers: true) do |row|
      category = ToolCategory.where(name: row["Category"].first_or_crea)

      tool = Tool.create(
        tool_category:  category,
        name:           row["Name"],
        description:    row["Description"],
        git_host:       row["repository-href"],
        repo:           row["repository"],
        gem_name:       row["gem_name"]
        )
      
      if tool.errors.any?
        puts "#{tool.name} Failed: #{tool.errors.full_messages.join(",")}"
        errored += 1
      else
        imported += 1
      end

    end

    puts "Imported #{imported} tools"
    puts "Failed to import #{errored} tools"
  end
end

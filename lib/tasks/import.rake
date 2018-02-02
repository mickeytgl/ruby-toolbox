require 'csv'

namespace :import do 
  desc "Import gems from CSV"
  task tools: :environment do 
    filename = File.join Rails.root, "gems.csv"
    counter = 0 

    CSV.foreach(filename, headers: true) do |row|
      tool = Tool.create(
        tool_category: ToolCategory.where( name: row["Category"]),
        name: row["Name"],
        description: row["Description"],
        git_host: row["repository-href"],
        repo: row["repository"],
        gem_name: row["gem_name"]
        )
      puts "#{tool.errors.full_messages.join(",")}" if tool.errors.any?
      counter += 1 if tool.persisted?
    end

    puts "Imported #{counter} tools"
  end
end

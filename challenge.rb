require 'json'

# error handling for missing or invalid data using safe_fetch
def safe_fetch(hash, key, default = nil)
  hash.fetch(key, default) || default
end

# Loading and parse the JSON files
users_file = File.read('users.json')
companies_file = File.read('companies.json')

begin
  users = JSON.parse(users_file)
  companies = JSON.parse(companies_file)
rescue JSON::ParserError => e
  puts "Error parsing JSON: #{e.message}"
  exit
end

# accessing the output file to write the results
File.open('output.txt', 'w') do |file|

  # loading companies in ascending order with respective to company ID
  companies.sort_by { |company| safe_fetch(company, 'id', 0) }.each do |company|
    file.puts "Company Id: #{safe_fetch(company, 'id')}"
    file.puts "Company Name: #{safe_fetch(company, 'name')}"
    
    users_emailed = []
    users_not_emailed = []
    top_up_amount = safe_fetch(company, 'top_up', 0)
    
    # Process users belonging to the current company
    company_users = users.select { |user| safe_fetch(user, 'company_id') == safe_fetch(company, 'id') && safe_fetch(user, 'active_status') }
    
    company_users.sort_by { |user| safe_fetch(user, 'last_name', '') }.each do |user|
      new_token_balance = safe_fetch(user, 'tokens', 0) + top_up_amount
      
      # Handle email status
      if safe_fetch(user, 'email_status') && safe_fetch(company, 'email_status')
        users_emailed << "#{safe_fetch(user, 'last_name')}, #{safe_fetch(user, 'first_name')}, #{safe_fetch(user, 'email')}\n  Previous Token Balance, #{safe_fetch(user, 'tokens')}\n  New Token Balance #{new_token_balance}"
      else
        users_not_emailed << "#{safe_fetch(user, 'last_name')}, #{safe_fetch(user, 'first_name')}, #{safe_fetch(user, 'email')}\n  Previous Token Balance, #{safe_fetch(user, 'tokens')}\n  New Token Balance #{new_token_balance}"
      end
    end
    
    # saving the users emailed category
    file.puts "Users Emailed:"
    file.puts users_emailed if users_emailed.any?
    
    # saving the users info of not emailed category
    file.puts "Users Not Emailed:"
    file.puts users_not_emailed if users_not_emailed.any?
    
    # providing the total amount of top-ups for the company
    total_top_up = company_users.size * top_up_amount
    file.puts "Total amount of top ups for #{safe_fetch(company, 'name')}: #{total_top_up}\n\n"
  end
end

puts "Output file generated as output.txt"

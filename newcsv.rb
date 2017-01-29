require 'csv'
require 'pry'


allAccounts = {}

# Goal:

# {
# 	"Priya" => [], 
# 	"Sonia" => []
# }

CSV.foreach('accounts.csv',headers:true) do |row| 
	puts "\n\nLooping through new row."
	name = row["Account"].chomp # Either Priya or Sonia.  Added .chomp to account for line breaks.
	puts "Account is for #{name}"
	category = row["Category"].chomp

	if !allAccounts.has_key? name
		puts "First time with this account. Adding it to allAccounts."
		allAccounts[name] = {"categories" => {}, "total" => 0.0}
		puts "allAccounts[name] is now #{allAccounts[name]}"
	end

	puts "First let's get the overall balance for each person"
	allAccounts[name]["total"] += row['Inflow'].delete('$').delete(',').to_f - row['Outflow'].delete('$').delete(',').to_f
	puts "total balance is #{allAccounts[name]["total"]}"


	# Whatever category is in this row, stick it into the array.
	if !allAccounts[name]["categories"].has_key? row["Category"]
		puts "First time with this Category"
		puts "Adding category #{row["Category"]} for this account"
		puts "Setting that category's info to total=0 and number of transaction=0"
		allAccounts[name]["categories"][row["Category"]] = {"total" => 0.0,"Number of Transactions" => 0,"Average_Spent" => 0}
		# puts "Now the info for that category is #{allAccounts[name]["categories"][row["Category"]]}"
	end	
	# binding.pry

	#number of transactions
	puts "Increasing the number of transactions for this category by 1."
	allAccounts[name]["categories"][row["Category"]]["Number of Transactions"] += 1
	
	#dollar amount
	inflow = row['Inflow'].delete('$').delete(',').to_f 
	outflow =  row['Outflow'].delete('$').delete(',').to_f
	amount = inflow - outflow	
	allAccounts[name]["categories"][row["Category"]]["total"] += amount
	
	#average spend
	count = allAccounts[name]["categories"][row["Category"]]["total"]
	transactions = allAccounts[name]["categories"][row["Category"]]["Number of Transactions"]
	allAccounts[name]["categories"][row["Category"]]["Average_Spent"] = count / transactions
	puts "Now the info for that category is #{allAccounts[name]["categories"][row["Category"]]}"


end





























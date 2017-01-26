require 'csv'
require 'pry'

def totalSpent(personName, category)
	returnArray = []
	tempArray = []

	CSV.foreach('accounts.csv',headers:true) do |row|	
		accounts = row['Account'].delete("\n")
		if accounts === personName
			if row['Category'] === category
				inflow = row['Inflow'].delete('$').delete(',').to_f
				outflow = row['Outflow'].delete('$').delete(',').to_f
				tempArray << inflow - outflow
			elsif category === "Balance"
				inflow = row['Inflow'].delete('$').delete(',').to_f
				outflow = row['Outflow'].delete('$').delete(',').to_f
				tempArray << inflow - outflow
			end
		end
	end

	def avgTrans(array)
		count = array.count
		array = array.inject(:+)
		array = array / count
		return array
	end

	tempArray.compact
	if tempArray == []
		tempArray << 0
	end

	average = avgTrans(tempArray)
	tempArray = tempArray.inject(:+)
	average = "$" + average.round(2).to_s
	tempArray = "$" + tempArray.round(2).to_s
	returnArray << tempArray << average
#	returnArray << average
	return returnArray
end

def printStuff(string, variable)
	if variable[0] != "$0.0"
		line = 28 - string.length
		line2 = 13 - variable[0].length
		puts string + (" "*line) + "|" + variable[0] + (" "*line2) + "|" + variable[1]
	end
end

def printHtmlStuff(string, variable)
	if variable[0] != "$0.0"
		puts "\t<tr>"
		puts "\t\t<td>" + string + "<td>"
		puts "\t\t<td>" + variable[0] + "<td>"
		puts "\t\t<td>" + variable[1] + "<td>"
		puts "\t<tr>"
	end
end

def printMoreStuff(inputName)
	balance = totalSpent(inputName, 'Balance')
	puts ("*" * 80)
	puts "Account: " + inputName + " *** Balance: " + balance[0]
	puts ("*" * 80)
	puts "Category" + (" "*20) + "| Total Spent | Average Transaction" + (" " * 17)
	puts ("-" * 28) + "|" + ("-" * 13) + "|" + ("-" * 37)

	categories = ["Allowance", "Car Repairs", "Rent", "Entertainment", "Fuel", "Clothes",
	"Education", "Groceries", "Gifts", "Utilities", "Household Goods", "Gym", "Medical/Dental", "Meals"]
	x = 0
	while x <= categories.count - 1
		finalArray = totalSpent(inputName, categories[x])
		printStuff(categories[x], finalArray)
		x += 1
	end
end

def printHtml(inputName)
	balance = totalSpent(inputName, 'Balance')
	puts "<h1>" + inputName + "</h1>"
	puts "<p>" + balance[0] + "</p>"
	puts "<hr>"
	puts "<table>"
	puts "\t<tr>"
	puts "\t\t<th>Category</th>"
	puts "\t\t<th>Total Spent</th>"
	puts "\t\t<th>Avg. Transaction</th>"
	puts "\t</tr>\n"

	categories = ["Allowance", "Car Repairs", "Rent", "Entertainment", "Fuel", "Clothes",
	"Education", "Groceries", "Gifts", "Utilities", "Household Goods", "Gym", "Medical/Dental", "Meals"]
	x = 0
	while x <= categories.count - 1
		finalArray = totalSpent(inputName, categories[x])
		printHtmlStuff(categories[x], finalArray)
		x += 1
	end
	puts "</table>"
end

# DISPLAY CODE

inputName = ARGV

if inputName[0] === 'Priya'
	if inputName[1] === 'HTML'
		printHtml('Priya')
	else
		printMoreStuff('Priya')
	end
elsif inputName[0] === 'Sonia'
	if inputName[1] === 'HTML'
		printHtml('Sonia')
	else
		printMoreStuff('Sonia')
	end
else
	printMoreStuff('Priya')
	printMoreStuff('Sonia')
end

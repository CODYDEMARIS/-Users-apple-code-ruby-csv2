require 'fileutils'


input_lines = File.readlines('questions.txt')  
f = open("questions.txt")
contents_array = []
f.each_line { |line| contents_array << line }
f.close


puts "Display/Add/Remove?"
userinput = gets.chomp

if userinput === "Add"
	puts "What Question are you adding?"
	questionToAdd = gets.chomp
	File.open("questions.txt", 'a+') { |file| file.write(questionToAdd + "\n") }  #adds new question to file 
end

if userinput === "Display"
	f = File.new("questions.txt", "r")
	f.each {|line| puts "#{f.lineno}: #{line}" }
end

if userinput === "Remove"
	f = File.new("questions.txt", "r")       			#displays file so user can choose which line to delete
	f.each {|line| puts "#{f.lineno}: #{line}" }
	puts "What line number would you like to me to delete?"
	tester = gets.chomp
	#What I'm trying to accomplish here is that when user selects "Remove", the text file is recopied into a new text file
	#unless whatever number user provides is equal to the index value of the line + 1.  It looks like my attempt to put the lines
	#of text into an array was successful, but the code on line 36 still isn't working correctly.
	open('questions.txt', 'r') do |f|
  	open('questions.txt.tmp', 'w') do |f2|
    f.each_line do |line|
    f2.write(line) unless line.index === (tester + 1)
   
   FileUtils.mv 'questions.txt.tmp', 'questions.txt'
	end
	end
	end
end


 
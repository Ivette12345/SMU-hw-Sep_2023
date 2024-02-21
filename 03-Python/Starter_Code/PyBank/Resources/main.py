import os
import csv #Import csv library to read dataset

csvpath = "..Resources/budget_data.csv"

# Read the budget data from the csv file
with open("Resources/budget_data.csv") as csvfile:
        csvreader = csv.reader(csvfile,delimiter = ",")
        reader = csv.reader(csvfile)
        next(reader) # To skip the header or column titles
    
#Set variables and go through each row
        months = []
        profit_losses = []
        changes = []   
        for row in reader:
            months.append(row[0])
            profit_losses.append(int(row[1]))
        
#To calculate the total number of months
total_months = len(months)

#To calculate the net total amount of profit/losses
net_total = sum(profit_losses)

## Calculate the change in profit/losses and store them in a list
for i in range(1, total_months):
    change = profit_losses[i] - profit_losses[i-1] #subtract the value of the previous month from the current month
    changes.append(change)
    
#calculate the average change
average_change = sum(changes) / len(changes)

# Find the greatest increase and decrease in profits
greatest_increase = max(changes)
greatest_increase_date = months[changes.index(greatest_increase) + 1]
greatest_decrease = min(changes)
greatest_decrease_date = months[changes.index(greatest_decrease) + 1]

# Print the analysis results
print("Budget Analysis")
print(f"Total Months: {total_months}")
print(f"Net Total: ${net_total}")
print(f"Average Change: ${average_change:.2f}")
print(f"Greatest Increase in Profits: {greatest_increase_date} (${greatest_increase})")
print(f"Greatest Decrease in Profits: {greatest_decrease_date} (${greatest_decrease})")

#write results to txt file
with open('Resources/budget_data.txt','w') as txtfile:  
    txtfile.write("Budget Analysis\n")
    txtfile.write(f"Total Months: {total_months}\n")
    txtfile.write(f"Net Total: ${net_total}\n")
    txtfile.write(f"Average Change: ${average_change:.2f}\n")
    txtfile.write(f"Greatest Increase in Profits: {greatest_increase_date} (${greatest_increase})\n")
    txtfile.write(f"Greatest Decrease in Profits: {greatest_decrease_date} (${greatest_decrease})\n")
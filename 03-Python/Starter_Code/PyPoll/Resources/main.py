import os
import csv
#Read the election data from the csv file
csvpath = "..Resources/election_data.csv"
with open ("Resources/election_data.csv") as csvfile:
    csvreader = csv.reader(csvfile, delimiter = ",")
    reader = csv.reader(csvfile)
    next(reader) # to skip header or name of columns
    
#Set variables
    total_votes = 0 # to keep track of number of votes cast
    
    candidates = {} # to store each candidate with number of votes received
    
    for row in reader: # to go through every row
        
        #To get the candidate name for each row
        candidate = row [2]
        #To add to the total vote count
        total_votes += 1
        # To get names of candidates
        candidates[candidate] = candidates.get(candidate,0) + 1
        
# to calculate the percentage of votes and number of votes that each candidate won  
results = []
for candidate, votes in candidates.items():
    percentage = (votes / total_votes) * 100 
    results.append((candidate, percentage, votes)) 
    
# to find the winner of the election 
winner = max(results, key = lambda x: x[2])

print ("Election Results")
print(f"Total Votes: {total_votes}")
for candidate, percentage, votes in results:
    print(f"{candidate}: {percentage:.3f}% ({votes})")
print(f"Winner: {winner[0]}")

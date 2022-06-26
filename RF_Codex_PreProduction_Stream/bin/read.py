import os, csv

print(os.getcwd())

lines = []
with open('verify.csv', 'r') as input:
    lines = input.readlines()

conversion = '\\'
newtext = ''
outputLines = []
for line in lines:
    temp = line[:]
    for c in conversion:
        temp = temp.replace(c, newtext)
    outputLines.append(temp)

with open('output.csv', 'w') as output:
    for line in outputLines:
        output.write(line)
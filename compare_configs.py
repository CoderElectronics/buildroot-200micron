import os, sys

with open(sys.argv[1], 'r') as file:
    file1 = file.read().split()

with open(sys.argv[2], 'r') as file:
    file2 = file.read().split()

for line in file2:
    if line not in file1:
        print(line)

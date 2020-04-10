#! /usr/bin/env python
import csv

csvfile = 'C01prefile.csv'
f = open(csvfile, "r", encoding="SJIS")
reader = csv.reader(f)
# header = next(reader)

print(reader)

#for row in reader:
#    print(row[1])

f.close()

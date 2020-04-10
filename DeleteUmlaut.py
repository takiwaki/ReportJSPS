#!

f = open('articles.csv','r')
all = f.read()
f.close
#print(all)
#quit()

s = ""
for t in all :
   try:
      t.encode('cp932')
   except UnicodeEncodeError:
      if t==u"\u00C0" or t==u"\u00C1" or t==u"\u00C2" or t==u"\u00C3" or t==u"\u00C4" or t==u"\u00C5":
         s += 'A'
      elif t==u"\u00C6":
         s += 'AE'
      elif t==u"\u00C7":
         s += 'C'
      elif t==u"\u00C8" or t==u"\u00C9" or t==u"\u00CA" or t==u"\u00CB":
         s += 'E'
      elif t==u"\u00CC" or t==u"\u00CD" or t==u"\u00CE" or t==u"\u00CF":
         s += 'I'
      elif t==u"\u00D1":
         s += 'N'
      elif t==u"\u00D2" or t==u"\u00D3" or t==u"\u00D4" or t==u"\u00D5" or t==u"\u00D6" or t==u"\u00D8":
         s += 'O'
      elif t==u"\u00D9" or t==u"\u00DA" or t==u"\u00DB" or t==u"\u00DC":
         s += 'U'
      elif t==u"\u00DD":
         s += 'Y'
      elif t==u"\u00DF":
         s += 'ss'
      elif t==u"\u00E0" or t==u"\u00E1" or t==u"\u00E2" or t==u"\u00E3" or t==u"\u00E4" or t==u"\u00E5" :
         s += 'a'
      elif t==u"\u00E6":
         s += 'ae'
      elif t==u"\u00E7":
         s += 'c'
      elif t==u"\u00E8" or t==u"\u00E9" or t==u"\u00EA" or t==u"\u00EB" or t==u"\u0117":
         s += 'e'
      elif t==u"\u011f":
         s += 'g'
      elif t==u"\u00EC" or t==u"\u00ED" or t==u"\u00EE" or t==u"\u00EF":
         s += 'i'
      elif t==u"\u00F1":
         s += 'n'
      elif t==u"\u00F2" or t==u"\u00F3" or t==u"\u00F4" or t==u"\u00F5" or t==u"\u00F6" or t==u"\u00F8":
         s += 'o'
      elif t==u"\u0159":
         s += 'r'
      elif t==u"\u0161":
         s += 's'
      elif t==u"\u00F9" or t==u"\u00FA" or t==u"\u00FB" or t==u"\u00FC" or t==u"\u016B":
         s += 'u'
      elif t==u"\u00FD" or t==u"\u00FF":
         s += 'y'
      elif t==u"\u017E":
         s += 'z'
      elif t==u"\u0152":
         s += 'OE'
      elif t==u"\u0153":
         s += 'oe'
      elif t==u"\u2009":
         s += ' '
      elif t==u"\u2013":
         s += '-'
      elif t==u"\u2014":
         s += '-'
      elif t==u"\u00a0":
         s += '_'
      else:
         s += '[?]'
   if   t==u"\u00251":
      s += 'a'
   elif t==u"\u00E9":
      s += 'e'
   elif t==u"\u0005F":
      s += '_'
   elif t==u"\u02020" or t==u"\u02021":
      s += '+'
   else:
      s += t
f = open('articles.csv','w')
f.write(s)
f.close


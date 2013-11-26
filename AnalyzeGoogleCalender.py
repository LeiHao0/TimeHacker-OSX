# python 3.x
import datetime, os, glob

class Event():
  def __init__(self, text):
    self.text = text
    self.summary = self.getSummary()
    self.duration = self.getDuration()

  def getSummary(self):
    text = self.text
    summary = text[text.find(':')+1:text.find('\r\n')]
    return summary

  def getDuration(self):
    text = self.text
    duration = None

    try:
      #20101201T060000Z
      index = text.find('DTSTART')
      dtstart = text[text.find(':', index)+1:text.find('Z', index)]
      
      start = datetime.datetime.strptime(dtstart, "%Y%m%dT%H%M%S")
      
      index = text.find('DTEND')
      dtend = text[text.find(':', index)+1:text.find('Z', index)]
      end = datetime.datetime.strptime(dtend, "%Y%m%dT%H%M%S")

      duration = end - start
    except:
      #print('datetime faild')
      None

    return duration

class Calender:
  def __init__(self, f):
    self.file  = f
    self.text = self.openCal()
    self.AllEvent = self.analyzeCal()
    
  def openCal(self):
    fCal = open(self.file ,'rb')
    text = fCal.read().decode('utf-8')
    return text

  def analyzeCal(self):
    AllEvent = {}
    text = self.text
    index = 0
    lastindex = 0
    while (index != -1):
      lastindex = index
      index = text.find("SUMMARY", index+1)

      # go it
      event = Event(text[lastindex:index])

      if event.duration != None:
        if AllEvent.get(event.summary):
          AllEvent[event.summary] = AllEvent[event.summary]+event.duration
        else:
          AllEvent[event.summary] = event.duration
    return AllEvent


files = os.listdir('./')

for f in files:
  if f.find('.ics')>0:
    cal = Calender(f)
    dict = cal.AllEvent
    dict = sorted(dict.items(), key=lambda x: x[1] , reverse=True)

    text = ''
    for event in dict:
      text += event[0]
      text += ':'
      text += str(event[1])
      text += '\n'

    f = open(f + '.analyzed.txt','wb')
    f.write(text.encode('utf-8'))
    f.close()


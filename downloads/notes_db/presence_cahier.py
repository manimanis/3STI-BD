import os
from pprint import pprint
from xmledu import get_noms_eleves, read_xml_file
from datetime import date, timedelta
import pandas as pd


filename = "0077143288_2003_31231301_31.xml"
filename = "0077143288_2001_31230202_31.xml"
cur_dir = os.path.dirname(__file__)
xmlFilePath = os.path.join(cur_dir, filename)

xmlData = read_xml_file(xmlFilePath)
noms_eleves = get_noms_eleves(xmlData)
start_date = date(2023, 1, 2)
end_date = date(2023, 3, 12)
WEEKDAYS = [0, 2, 3]
seances = []
freedays = [date(2023, 1, 12), date(2023, 1, 26), date(2023, 2, 26), 
date(2023, 3, 2)] + [date(2023, 1, 30) + timedelta(days=i) for i in range(7)]
cur_date = start_date
while cur_date <= end_date:
    if cur_date.weekday() in WEEKDAYS and cur_date not in freedays:
        seances.append(cur_date)
    cur_date += timedelta(days=1)
for eleve in noms_eleves:
    for seance in seances:
        eleve[str(seance)] = '__'

df = pd.DataFrame(noms_eleves)
df.to_html(xmlFilePath + '.html')
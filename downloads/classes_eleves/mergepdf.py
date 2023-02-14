from PyPDF2 import PdfMerger
import os

cur_dir = os.path.dirname(__file__)

pdfs = ['ACTIVITE-2.pdf', 'club_cinema.sql.pdf']
res = "Activite-Corrigee.pdf"

merger = PdfMerger()

for pdf in pdfs:
    merger.append(os.path.join(cur_dir, pdf))

merger.write(os.path.join(cur_dir, res))
merger.close()
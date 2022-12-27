import sqlite3


NOTES_2INFO = """18,25	15,00	8,00
17,75	12,50	6,50
14,50	15,50	5,25
16,75	14,00	7,50
18,25	15,00	4,25
17,25	13,50	7,50
19,50	19,50	13,25
18,00	17,00	19,00
18,00	10,75	8,00
17,75	12,50	3,75
19,75	15,00	12,00
14,50	13,00	4,25
15,25	11,25	9,00
6,00	14,00	9,00
6,25	11,25	4,75
18,25	13,25	7,50
19,25	15,50	11,25
13,00	15,25	9,25
9,00	13,50	5,00
		
17,25	18,25	17,00
		
		5,50
11,50	13,00	5,00
19,25	18,50	12,25
19,25	12,50	8,50"""
EVALS_2INFO = [1, 2, 4]
MATIERES_2INFO = [1]
ELEVES_2INFO = """57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82"""

NOTES_3INFO = """14,50	12,25	16,75
10,50	14,00	19,00
11,50	4,25	7,50
11,50	13,00	17,50
11,00	15,25	13,50
5,50	10,25	9,75
10,50	5,50	5,75
6,00	17,00	9,75
8,00	17,00	11,50
5,75	7,25	6,75
10,00	10,25	10,75
12,00	9,00	13,50
13,00	11,50	12,25
18,00	7,25	15,75
12,00	6,00	13,25
7,50	9,75	7,00
11,50	11,00	15,25
4,00	9,25	8,00
7,75	6,50	10,25
15,50	14,50	14,75
14,50	15,00	14,75
7,50	13,00	9,75
9,00	10,50	12,75
13,50	15,75	16,50
8,00	6,50	7,50
12,00	14,00	12,50
16,50	18,25	16,50
11,00	9,50	9,25"""
EVALS_3INFO = [1, 3, 4]
MATIERES_3INFO = [2]
ELEVES_3INFO = """31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56"""

def save_notes(annee, trimestre, idClasse, idEtablissement, notes, evals, matiere, eleves):
    for idxEleve, idEleve in enumerate(eleves):
        for idxEval, eval in enumerate(evals):
            sql = ("SELECT idEleveClasse "
            "FROM Eleves_Classes "
            "WHERE idClasse = :idClasse AND "
            "  idEtablissement = :idEtablissement AND "
            "  idEleve = :idEleve AND "
            "  annee = :annee AND "
            " trimestre = :trimestre")
            data = {
                'annee': annee,
                'trimestre': trimestre,
                'idEleve': idEleve,
                'idClasse': idClasse,
                'idEtablissement': idEtablissement
            }
            cur = conn.execute(sql, data)
            elcl = cur.fetchone()
            sql = ("INSERT INTO Notes(idEleveClasse, idMatiere, idEvaluation, note) " + 
            "VALUES(:idEleveClasse, :idMatiere, :idEvaluation, :note)")
            data = {
                'idEleveClasse': idEleve,
                'idMatiere': matiere,
                'idEvaluation': eval,
                'note': notes[idxEleve][idxEval]
            }
            conn.execute(sql, data)
    conn.commit()

#-----------------
conn = sqlite3.connect("downloads/notes_db/notes.db")
conn.row_factory = sqlite3.Row

notes_2info = [[float(note.replace(',', '.') + '0') for note in row.split("\t")] for row in NOTES_2INFO.split("\n")]
eleves_2info = [int(idEleve) for idEleve in ELEVES_2INFO.split("\n")]
save_notes(2022, 1, 1, 1, notes_2info, EVALS_2INFO, MATIERES_2INFO[0], eleves_2info)

notes_3info = [[float(note.replace(',', '.') + '0') for note in row.split("\t")] for row in NOTES_3INFO.split("\n")]
eleves_3info = [int(idEleve) for idEleve in ELEVES_3INFO.split("\n")]
save_notes(2022, 1, 2, 1, notes_3info, EVALS_3INFO, MATIERES_3INFO[0], eleves_3info)
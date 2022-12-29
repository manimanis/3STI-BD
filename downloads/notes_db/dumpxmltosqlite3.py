from pprint import pprint
import sqlite3
import xml.dom.minidom as dom
import os

from xmledu import read_xml_file




def fetch_row(sql, data):
    global conn
    cur = conn.execute(sql, data)
    row = cur.fetchone()
    cur.close()
    return row


def fetch_all(sql, data):
    global conn
    cur = conn.execute(sql, data)
    rows = cur.fetchall()
    cur.close()
    return rows


def select_etablissement(nomEtab):
    sql = "SELECT * FROM Etablissement WHERE nomEtablissement = :nomEtablissement"
    data = {
        'nomEtablissement': nomEtab
    }
    return fetch_row(sql, data)


def select_matiere(nomMatiere):
    sql = "SELECT * FROM Matieres WHERE libelle = :nomMatiere"
    data = {
        'nomMatiere': nomMatiere
    }
    return fetch_row(sql, data)


def select_section(nomSection):
    sql = "SELECT * FROM Sections WHERE libelleSection = :nomSection"
    data = {
        'nomSection': nomSection
    }
    return fetch_row(sql, data)


def select_evaluations(epreuves):
    noms_epreuves = set()
    for epreuve in epreuves:
        epr_name = epreuve['libTypeEpr']
        i = len(epr_name) - 1
        while i > 0 and '0' <= epr_name[i] <= '9':
            i -= 1
        noms_epreuves.add(epr_name[:i+1])
    ep_str = "'" + "', '".join(noms_epreuves) + "'"
    sql = f"SELECT * FROM Evaluations WHERE libelle IN ({ep_str})"
    return fetch_all(sql, {})


def select_coefficients(niveau, idSection, idMatiere):
    sql = ("SELECT * "
           "FROM Coefficients "
           "WHERE niveau = :niveau AND "
           "  idSection = :idSection AND "
           "  idMatiere = :idMatiere")
    data = {
        'niveau': niveau,
        'idSection': idSection,
        'idMatiere': idMatiere
    }
    return fetch_all(sql, data)


def filter_eleves_from_xmldoc(xmlData):
    ELEVES_KEYS = ['IDENELEV', 'numOrdre', 'prenomnom']
    eleves = []
    for eleve in xmlData['eleves']:
        item = {key: eleve[key] for key in ELEVES_KEYS}
        if item not in eleves:
            eleves.append(item)
    return eleves


def select_classe(classeInfos):
    sql = ("SELECT * "
    "FROM Classes "
    "WHERE idSection = :idSection AND "
    "  classe = :classe AND "
    "  niveau = :niveau AND "
    "  numOrdre = :numOrdre")
    data = {
        'idSection': classeInfos['idSection'],
        'classe': classeInfos['nomClasse'],
        'niveau': classeInfos['niveau'],
        'numOrdre': classeInfos['numOrdre']
    }
    return fetch_row(sql, data)

def insert_classe(classeInfos):
    sql = ("INSERT INTO Classes (idSection, classe, niveau, numOrdre) "
           "VALUES (:idSection, :classe, :niveau, :numOrdre)")
    data = {
        'idSection': classeInfos['idSection'],
        'classe': classeInfos['nomClasse'],
        'niveau': classeInfos['niveau'],
        'numOrdre': classeInfos['numOrdre']
    }
    conn.execute(sql, data)
    conn.commit()
    
def insert_eleves(nomsEleves, idClasse, idEtablissement, annee, trimestre):
    eleves_rows = []
    elcl_rows = []
    for eleve in nomsEleves:
        sql = ("SELECT * FROM Eleves WHERE nom_prenom = :nom_prenom")
        data = {'nom_prenom': eleve['prenomnom']}
        el_row = fetch_row(sql, data)
        if el_row is None:
            sql2 = ("INSERT INTO Eleves (numUnique, nom_prenom) "
                    "VALUES (:numUnique, :nom_prenom)")
            data2 = {
                'nom_prenom': eleve['prenomnom'],
                'numUnique': eleve['IDENELEV']
            }
            conn.execute(sql2, data2)
            el_row = fetch_row(sql, data)
        eleves_rows.append(el_row)
        sql3 = ("SELECT * "
                "FROM Eleves_Classes "
                "WHERE idEleve = :idEleve AND "
                "  idClasse = :idClasse AND "
                "  idEtablissement = :idEtablissement AND "
                "  annee = :annee AND "
                "  trimestre = :trimestre")
        data3 = {
            'idEleve': el_row['idEleve'],
            'idClasse': idClasse,
            'idEtablissement': idEtablissement,
            'annee': annee,
            'trimestre': trimestre
        }
        elcl_row = fetch_row(sql3, data3)
        if elcl_row is None:
            sql4 = ("INSERT INTO Eleves_Classes (idEleve, idClasse, idEtablissement, annee, trimestre, numOrdre) "
                    "VALUES (:idEleve, :idClasse, :idEtablissement, :annee, :trimestre, :numOrdre)")
            data4 = {
                'idEleve': el_row['idEleve'],
                'idClasse': idClasse,
                'idEtablissement': idEtablissement,
                'annee': annee,
                'trimestre': trimestre,
                'numOrdre': eleve['numOrdre']
            }
            conn.execute(sql4, data4)
            elcl_row = fetch_row(sql3, data3)
        elcl_rows.append(elcl_row)
    conn.commit()
    return eleves_rows, elcl_rows
        

def insert_notes(notes, idMatiere, elcl_rows, eleves_rows, evaluations_rows):
    notes_rows = []
    for note in notes:
        eleve = [eleve for eleve in eleves_rows if eleve['nom_prenom'] == note['prenomnom']][0]
        elcl = [elcl for elcl in elcl_rows if elcl['idEleve'] == eleve['idEleve']][0]
        eval = [eval for eval in evaluations_rows if note['libTypeEpr'] == eval['libelle'] or note['libTypeEpr'] == (eval['libelle']+note['NUMEEPRE'])][0]
        if note['NOTEEPRE'] == '--.--':
            note['NOTEEPRE'] = '55.55'
        elif note['NOTEEPRE'] == 'غ.ش.':
            note['NOTEEPRE'] = '88.88'
        sql = ("SELECT * FROM Notes "
        "WHERE idEleveClasse = :idEleveClasse AND "
        "  idMatiere = :idMatiere AND "
        "  idEvaluation = :idEvaluation AND "
        "  numEpreuve = :numEpreuve")
        data = {
            'idEleveClasse': elcl['idEleveClasse'],
            'idMatiere': idMatiere,
            'idEvaluation': eval['idEvaluation'],
            'numEpreuve': int(note['NUMEEPRE'])
        }
        note_row = fetch_row(sql, data)
        if note_row is None:
            sql2 = ("INSERT INTO Notes (idEleveClasse, idMatiere, idEvaluation, numEpreuve, note) "
                    "VALUES (:idEleveClasse, :idMatiere, :idEvaluation, :numEpreuve, :note)")
            data2 = {
                'idEleveClasse': elcl['idEleveClasse'],
                'idMatiere': idMatiere,
                'idEvaluation': eval['idEvaluation'],
                'numEpreuve': int(note['NUMEEPRE']),
                'note': float(note['NOTEEPRE'])
            }
            conn.execute(sql2, data2)
            note_row = fetch_row(sql, data)
        notes_rows.append(note_row)
    conn.commit()
    return notes_rows


filename = "0077143288_2003_31231301_31.xml"
filename = "0077143288_2001_31230202_31.xml"
cur_dir = os.path.dirname(__file__)
xmlFilePath = os.path.join(cur_dir, filename)
dbfile = 'notes2.db'
dbFilePath = os.path.join(cur_dir, dbfile)

conn = sqlite3.connect(dbFilePath)
conn.row_factory = sqlite3.Row

xmlData = read_xml_file(xmlFilePath)
# with open(xmlFilePath + '.py', "w", encoding="utf-8") as f:
#     pprint.pprint(xmlData, f)
# notes = NotesClasse(xmlData)
annee = 2022
trimestre = int(xmlData['generalInfos']['codeperiodexam']) % 10
etab_row = select_etablissement(xmlData['generalInfos']['libeetab'])
matiere_row = select_matiere(xmlData['generalInfos']['libematier'])
classe_infos = xmlData['classe']
section_row = select_section(classe_infos['section'])
classe_infos['idSection'] = section_row['idSection']
classe_row = select_classe(classe_infos)
if classe_row is None:
    insert_classe(classe_infos)
    classe_row = select_classe(classe_infos)
evaluations_rows = select_evaluations(xmlData['epreuves'])
coefs_rows = select_coefficients(
    classe_infos['niveau'], section_row['idSection'], matiere_row['idMatiere'])
eleves_names = filter_eleves_from_xmldoc(xmlData)
eleves_rows, classe_rows = insert_eleves(eleves_names, classe_row['idClasse'], etab_row['idEtablissement'], annee, trimestre)
notes_rows = insert_notes(xmlData['eleves'], matiere_row['idMatiere'], classe_rows, eleves_rows, evaluations_rows)

print('Etablissement (DB) :', dict(etab_row))
print('Matiere (DB) :', dict(matiere_row))
print('Classe :', classe_infos)
print('Section (DB) :', dict(section_row))
print('Classe (DB) :', dict(classe_row))
print('Evaluations (DB) :', [dict(row) for row in evaluations_rows])
print('Coefficients (DB) :', [dict(row) for row in coefs_rows])
print('Eleves (DB) :', [dict(row) for row in eleves_rows][0])
print('Eleves Classes (DB) :', [dict(row) for row in classe_rows][0])
print('Notes (DB) :', [dict(row) for row in notes_rows][0])

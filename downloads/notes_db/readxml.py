from pprint import pprint
import xml.dom.minidom as dom
import os


def getText(nodelist):
    rc = []
    for node in nodelist.childNodes:
        if node.nodeType == node.TEXT_NODE:
            rc.append(node.data)
    return ''.join(rc)


def get_node_data(node):
    data = {}
    for nde in node.childNodes:
        if nde.nodeType != nde.ELEMENT_NODE:
            continue
        data[nde.tagName] = getText(nde)
    return data


def get_list_of_data(document, tagname):
    nodes = document.getElementsByTagName(tagname)
    items = []
    for node in nodes:
        items.append(get_node_data(node))
    return items


def liste_notes(document):
    return get_list_of_data(document, "noteelev")


def liste_epreuves(document):
    return get_list_of_data(document, "typeepr")


def general_data(document):
    tagnames = ['iuense', 'libens', 'codeeetab', 'libeetab', 'codeperiodexam',
                'libperiodexam', 'codeclass', 'libeclass', 'codematiere', 'libematier',
                'nbrclass', 'codedre', 'drear', 'nbrEleve', 'codedisc', 'libedisc']
    infos = {}
    for tagname in tagnames:
        infos[tagname] = getText(document.getElementsByTagName(tagname)[0])
    return infos


def read_xml_file(xmlfile):
    doc = dom.parse(xmlfile)
    infos = general_data(doc)
    eleves = liste_notes(doc)
    epreuves = liste_epreuves(doc)
    return {
        'generalInfos': infos,
        'eleves': eleves,
        'epreuves': epreuves
    }


class NotesClasse:
    ELEVES_KEYS = ['IDENELEV', 'numOrdre', 'prenomnom']
    CLASSE_KEYS = ['codeclass', 'codedre', 'codeeetab', 'drear',
                   'libeclass', 'libeetab', 'codeperiodexam', 'libperiodexam']
    EPREUVES_KEYS = ['CODEMATI', 'CODETYPEEPRE', 'CODETYPEMATI',
                     'NUMEEPRE', 'libTypeEpr', 'abretypeeprear']
    NOTES_KEYS = ['CODEMATI', 'CODETYPEEPRE', 'CODETYPEMATI',
                  'IDENELEV', 'NUMEEPRE', 'NOTEEPRE']

    def __init__(self, xmlData):
        self.xmlData = xmlData
        self.matiere = xmlData['epreuves'][0]['libeMat']
        self.eleves = [{key: eleve[key] for key in NotesClasse.ELEVES_KEYS}
                       for eleve in xmlData['eleves']]
        self.eleves = [eleve
                       for idx, eleve in enumerate(self.eleves)
                       if self.eleves.index(eleve) == idx]
        self.classe = {key: value
                       for key, value in xmlData['generalInfos'].items()
                       if key in NotesClasse.CLASSE_KEYS}
        self.epreuves = [{key: epreuve[key] for key in NotesClasse.EPREUVES_KEYS}
                         for epreuve in xmlData['epreuves']]
        self.notes = [{key: eleve[key] for key in NotesClasse.NOTES_KEYS}
                      for eleve in xmlData['eleves']]
        for eleve in self.eleves:
            eleve['notes'] = [dict() for _ in self.epreuves]
            notes = [note for note in self.notes
                     if note['IDENELEV'] == eleve['IDENELEV']]
            for idx, epreuve in enumerate(self.epreuves):
                eleve['notes'][idx] = {epreuve['libTypeEpr']: [note for note in notes
                                       if note['CODEMATI'] == epreuve['CODEMATI'] and
                                       note['CODETYPEEPRE'] == epreuve['CODETYPEEPRE'] and
                                       note['CODETYPEMATI'] == epreuve['CODETYPEMATI'] and
                                       note['NUMEEPRE'] == note['NUMEEPRE']][0]['NOTEEPRE']}

        pprint(self.eleves[0])


filename = "0077143288_2003_31231301_31.xml"
#filename = "0077143288_2001_31230202_31.xml"
cur_dir = os.path.dirname(__file__)
xmlFilePath = os.path.join(cur_dir, filename)
xmlData = read_xml_file(xmlFilePath)
# with open(xmlFilePath + '.py', "w", encoding="utf-8") as f:
#     pprint.pprint(xmlData, f)
notes = NotesClasse(xmlData)

import xml.dom.minidom as dom


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


def parse_nom_classe(nomClasse):
    # ثانية تكنولوجيا الإعلامية 2
    NIVEAUX = {'ثانية': 2, 'ثالثة': 3}
    nc = nomClasse.split()
    data = {
        'niveau': NIVEAUX[nc[0]],
        'numOrdre': int(nc[-1]),
        'section': " ".join(nc[1:-1]),
        'nomClasse': nomClasse
    }
    return data


def read_xml_file(xmlfile):
    doc = dom.parse(xmlfile)
    infos = general_data(doc)
    eleves = liste_notes(doc)
    epreuves = liste_epreuves(doc)
    classeInfos = parse_nom_classe(infos['libeclass'])
    return {
        'generalInfos': infos,
        'eleves': eleves,
        'epreuves': epreuves,
        'classe': classeInfos
    }


def get_noms_eleves(xmlData):
    ELEVES_KEYS = ['IDENELEV', 'prenomnom']
    eleves = [{key: eleve[key] for key in ELEVES_KEYS}
            for eleve in xmlData['eleves']]
    eleves = [eleve for idx, eleve in enumerate(eleves)
            if eleves.index(eleve) == idx]
    return eleves

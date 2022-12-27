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

cur_dir = os.path.dirname(__file__)
cur_file = os.path.join(cur_dir, "0077143288_2003_31231301_31.xml")

doc = dom.parse(cur_file)
noteelevs = doc.getElementsByTagName("noteelev")

print(dir(doc))
print(dir(noteelevs))

print("---")
infos = general_data(doc)
eleves = liste_notes(doc)
epreuves = liste_epreuves(doc)
print(infos)
print(eleves)
print(epreuves)

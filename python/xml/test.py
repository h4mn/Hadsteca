""" Xml2Html ou Xml2DiscordEmbed

Abri este teste na intenção de descobrir como fazer para
deixar o xml gerado pelo log do CCNet do c3po mais bonito.

Origem: http://c3po.futurasistemas.com.br:9898/ccnet/ViewFarmReport.aspx
Data: 2023.11.22
"""
import os
import xml.dom.minidom

# pegar o path deste script
path = os.path.dirname(os.path.abspath(__file__))
entrada = 'test.xml'
saida = 'test2.xml'
path_entrada = os.path.join(path, entrada)
path_saida = os.path.join(path, saida)

# processamento xml
dom = xml.dom.minidom.parse(path_entrada)
with open(path_saida, 'w') as f:
    # dom.writexml(f, encoding='utf-8')
    # f.write(dom.toprettyxml(encoding='utf-8').decode('utf-8'))
    f.write(dom.toprettyxml())
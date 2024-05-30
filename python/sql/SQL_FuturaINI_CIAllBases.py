# Autor: Hadston Nunes
# Data: 2023-09-11
# Versao: 1.0
# Dependencias: N/A
# Descricao: Atualiza o campo CI, CI_SISTEMA e CI_CNPJ de todas as bases do Futura.ini

# Importacao de bibliotecas
import os
import sys
import configparser

# class SQL_FuturaINI_CIAllBases:
#     # construtor
#     def __init__(self):
#         self.bases = bases
#         self.sql = sql

#     # executor
#     def run(self):


if __name__ == '__main__':
    # comando sql para atualizar o campo CI, CI_SISTEMA e CI_CNPJ
    sql = """
    update PARAMETROS set
    CI = '99994067442736020200';
    commit;
    update PARAMETROS set
    CI_SISTEMA = '1o40sbnfplwxjuW5ZkyPjsZBef3Q2bdcNYmyxOtZAkilzx6Tr7mZHW7zpcOn3JNb4yeIIzaTRcO2KzfeVO20rxpvqq+XowgtK9ZGokFKnQkyAjYMWXsu61PHaEbDE7t2o1iG06NJcW2YkJ3c4gopD9QhkitE61KbMjADm0hzi6/8XUkbaQh43AcCcWpiw2pam8giVO5G77TQGeBr0GC4nJ46slWJvdgCoW90JtKSAFqji/g9m13cmlvAqxMr1GCdY5f7P6U4deUr1yHLzjZn63puXWUE514feEfMHGdav7Y=';
    commit;
    update PARAMETROS set
    CI_CNPJ = 'UEVZrTi4Voxzfpdok//YFgeKazGnA1tipmBMP1UX/w0bZmnTIEgpWuRwziRQCPq3Yq6R+zfcnoYp2vMV/M32GzdTAJ5sp/B/MAdiXMNpoqRtS7Ghb1DZ/AAqBrjCMDvcAb6O5AIqqvXUnEy0uoR9EH/Xnas+57yh';
    commit;
    """    
    # arquivo ini do Futura com as bases
    futura_ini = r'Z:\Backup\_tmp\_cmd\FUTURA.INI'    
    # comando isql para executar o sql
    isql = r'C:\Program Files\Firebird\Firebird_4_0\isql.exe'
    # usuario e senha do banco
    fu = 'sysdba'
    fp = 'futurasbo'
    # arquivo de log
    log = r'Z:\Backup\_tmp\_py\teste.log'
    # arquivo sql
    sql_file = r'Z:\Backup\_tmp\_py\update.sql'

    # ler o arquivo
    with open(futura_ini, 'r') as f:
        futura_ini_conteudo = f.read()
        f.close()
    
    # carregar as secoes
    config = configparser.ConfigParser()
    config.read_string(futura_ini_conteudo)
    #print(config.sections())
    
    # mostrar as propriedades e valores
    for section in config.sections():
        print(section)
        for key in config[section]:
            print(key, config[section][key])
            # adicionar a base no array
            if key == 'dados_path':
                #print(key, config[section][key])
                base = config[section][key]

                # montar o arquivo sql com as bases
                sql_update = f"""
                SET SQL DIALECT 3;
                SET NAMES WIN1252;
                CONNECT '{base}'
                USER '{fu}' PASSWORD '{fp}';
                """ + sql

                # salvar o arquivo sql
                with open(sql_file, 'w') as f:
                    f.write(sql_update)
                    f.close()

                # comando sql
                isql_cmd = f'{isql} -u {fu} -p {fp} -o {log} -d {bases[0]} -i {sql_file} -q'
                pass

# TODO: 
# - MyConfigParser - Encapsula e recupera as informações do arquivo ini
# - MySQLBuilder - Monta e salva o arquivo sql
# - MyDatabaseUpdater - Consome a MyConfigParser e MySQLBuilder e atualiza o banco
# - MyEnvironment - Manipula as variaveis e as credenciais
# - MyLogger - Lida com as exceções e salva os logs
# - Main - Executa o programa
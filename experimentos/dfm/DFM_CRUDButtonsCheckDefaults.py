# -*- coding: utf-8 -*-

class CRUDButtonsCheckDefaults(object):
    '''
    Esta classe lê um arquivo texto dfm, procura por objeto button e
    altera suas propriedades baseadas num padrão.

    Todo:
    1. ler arquivo dfm e armazenar as linhas num array;
    2. agrupar as linhas em blocos "object"
    3. verificar uma forma de aninhar objetos pais e filhos;
    4. cada linha que não for setup de objeto será uma propriedade;
    5. as propriedades tem o mesmo formato: "NomePropriedade = Valor";
    6. localizar algumas propriedades que farão parte da padronização;
    7. de inicio padronizar as captions dos objetos TRzButton;
    8. conteúdo do valor da propriedade "Caption" ficará contido em aspas simples;
    9. o padrão das TRzButton captions será: Nome [Tecla];
    10. localizar o TRzButton atual pelo particula Nome dentro da sua caption;
    11. estrutura de dados para os TRzButtonCapions:
    - Grupo: 1, Top 03, Left 03,  Caption: 'Novo [F2]';
    - Grupo: 1, Top 03, Left 94,  Caption: 'Editar [F3]';
    - Grupo: 1, Top 03, Left 185, Caption: 'Excluir';
    - Grupo: 2, Top 03, Left 312, Caption: 'Gravar [F10]';
    - Grupo: 2, Top 03, Left 403, Caption: 'Cancelar [F9]';
    12. também procurar captions que terminam com ":" e retirar;
    '''
    file_dfm = 'C:\\_tmp\\DFM_to_standardize.txt'

    def get_file(self):
        with open(self.file_dfm, 'r') as file:
            return file.read().rstrip()
        
        print('arquivo lido')
        pass
    pass

def main():
    crud = CRUDButtonsCheckDefaults()
    print(crud.get_file())
    pass

if __name__ == "__main__":
    main()
    pass
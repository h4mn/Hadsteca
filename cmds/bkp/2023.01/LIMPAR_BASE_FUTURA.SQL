-- ==================================================
-- Remove vínculos de dependência
update CADASTRO set FK_USUARIO = 1;
update CADASTRO set FK_REPRESENTANTE = null;
update CADASTRO set FK_VENDEDOR = null;
update CADASTRO set FK_TRANSPORTADORA = null;
commit work;
-- ==================================================
-- Configura usuário padrão
alter trigger SYS_USUARIO_BIU0 inactive; commit work;
    update SYS_USUARIO set FK_FUNCIONARIO = null;
    update SYS_USUARIO set 
        NOME = 'FUTURA', 
        SENHA = 'ãáãá', 
        TIPO = '1', 
        STATUS = '0', 
        MODULO = null, 
        FK_USUARIO_PERFIL = null, 
        CODIGO_VALIDACAO = null, 
        REMEMBER_TOKEN = null, 
        NEW_SENHA = '18a2439975c82a1a043a20210accf12e8699a5a1', 
        NEW_SALT = '04f61c6e5', 
        NEW_CODIGO_VALIDACAO = null, 
        NEW_TIPO_SENHA = '1'
    where ID = '1';
alter trigger SYS_USUARIO_BIU0  active;
commit work; 
-- ==================================================
-- Deleta Dados
delete from CADASTRO_NEGATIVACAO;
delete from FINANCEIRO_CHEQUE;
delete from CHEQUE;
delete from VENDA_PRE_PAGAMENTO;
delete from VENDA_PRE_ITEM;
delete from VENDA_PRE;
delete from CADASTRO_FISCAL where FK_CADASTRO <> 1;
delete from PRE_CAIXA_ITEM;
delete from CAIXA_ITEM;
delete from CAIXA;
delete from FINANCEIRO_CENTRO_CUSTO;
delete from CONTA_PARCELA_FINANCEIRO;
delete from FINANCEIRO;
delete from CONTA_PARCELA;
delete from COMISSAO_LOTE_ITEM;
delete from COMISSAO_LOTE;
delete from CONTA;
delete from notA_FISCAL_ITEM_LOTE;
delete from notA_FISCAL_NFE;
delete from notA_FISCAL_ITEM;
delete from notA_FISCAL_GNRE;
delete from notA_FISCAL_CORRECAO;
delete from notA_FISCAL_NSU;
delete from notA_FISCAL;
delete from PEDIDO_ENTREGA;
update CADASTRO_FISCAL set FK_CONTABILISTA = null;
commit work;
-- ==================================================
-- Deleta PEDIDO ITEM
alter trigger PEDIDO_ITEM_BUD0 inactive; commit work;
    delete from PEDIDO_ITEM;
alter trigger PEDIDO_ITEM_BUD0 active; commit work;
--
delete from ECF_REGISTRO_R06;
commit work;
-- ==================================================
-- Deleta PEDIDO
alter trigger PEDIDO_BUD0 inactive; commit work;
    delete from pedido;
alter trigger PEDIDO_BUD0 active; commit work;
--
delete from PRODUTO_VALOR_COMPRA;
commit work;
-- ==================================================
-- Deleta Entidades
delete from CNAB_LOTE;
delete from CONTA_CORRENTE_BOLETO where FK_CONTA_CORRENTE <> 1;
--delete from TIPO_PAGAMENTO where FK_CONTA_CORRENTE <> 1;
delete from CARTAO;
delete from BOLETO_PENDENTE;
delete from COMISSAO_CONTROLE;
delete from CONTA_CORRENTE where ID <> 1 and ID <> 2 and ID <> 3 and ID <> 4;
delete from LOG_PEDIDO_PDV;
delete from CADASTRO_AGENDA_CONTA;
delete from CADASTRO_AGENDA;
delete from CADASTRO_CONSULTA_CREDITO;
delete from CADASTRO_PRODUTO_DESEJO;
delete from CADASTRO_ENDERECO where fk_cadastro in (select ID from CADASTRO where (CHK_CLIENTE <> 'S') and (CHK_TRANSPORTADORA <> 'S') and (CHK_FORNECEDOR <> 'S'));
delete from INVENTARIO;
delete from SYS_SCRIPT;
delete from SYS_CORES;
delete from SYS_CORES_PARAMETROS;
delete from REPOSICAO;
commit work;
-- ==================================================
-- Atualiza Usuário Digitação
delete from PRODUTO_PRECO_HISTORICO;
delete from PRODUTO_PRECO_LOTE_ATU;
commit work;
update REPN_COLETA set FK_USUARIO = 1;
update PRODUTO set FK_USUARIO_DIGITACAO = 1;
delete from SYS_USUARIO where id <> 1;
commit work;
-- ==================================================
-- Exclui FK_PRODUTO Duplicado da PRODUTO_FORNECEDOR
/*
delete from PRODUTO_FORNECEDOR 
where FK_PRODUTO in (
    select FK_PRODUTO 
    from PRODUTO_FORNECEDOR
    GROUP BY FK_PRODUTO 
    HAVING COUNT(FK_PRODUTO) > 1
    )
    and not ID in (
	    select MIN(ID) from PRODUTO_FORNECEDOR
	    GROUP BY FK_PRODUTO
	    HAVING COUNT(FK_PRODUTO) > 1
    );
update PRODUTO_FORNECEDOR set
    FK_FORNECEDOR = 1, 
    IPI_PERCENTUAL = 0, 
    PRECO_COMPRA = 0, 
    NRO_FABRICANTE = null, 
    VALOR_BRUTO = 0, 
    PRECO_CUSTO = 0;
commit work;
--*/
-- ==================================================
-- Deleta Parâmetros
--/*
delete from PARAMETROS_IMPRESSO;
commit work;
--*/
-- ==================================================
-- Deleta Empresas (mantém apenas a primeira)
delete from PRODUTO_ESTOQUE where FK_EMPRESA <> 1;
delete from CADASTRO_SN_ICMS where FK_CADASTRO <> 1;
delete from SYS_REPOSITORIO_PARAMETROS;
delete from TERMINAL;
delete from CADASTRO where (CHK_EMPRESA) = 'S' 
    and (ID <> 1) 
    and (CHK_CLIENTE = 'N') 
    and (CHK_FORNECEDOR = 'N') 
    and (CHK_TRANSPORTADORA = 'N');
update CADASTRO set CHK_EMPRESA = 'N' 
where (CHK_EMPRESA) = 'S' 
    and (ID <> 1);
commit work;
-- ==================================================
-- Remove Dados de Replicação
delete from SYS_REPOSITORIO_PARAMETROS;
delete from TERMINAL;
delete from SAT_EQUIPAMENTO;
commit work;
-- ==================================================
-- Atualizar Produtos para Fornecedor Padrão
--/*
delete from PRODUTO_FORNECEDOR;
insert into PRODUTO_FORNECEDOR (
    ID
    ,FK_FORNECEDOR
    ,FK_PRODUTO
    ,IPI_PERCENTUAL
    ,PRECO_COMPRA
    ,NRO_FABRICANTE
    ,VALOR_BRUTO
    ,DESCONTO_PERCENTUAL_1
    ,DESCONTO_PERCENTUAL_2
    ,ACRESCIMO_PERCENTUAL
    ,PRECO_CUSTO
    ,ICMS_ST_UNITARIO
    ,DATA_HORA
    ,NRO_FCI
    ,SEGURO
    ,FRETE
    ,PRINCIPAL
    )
select 
    (select result from SP_GET_GENERATOR('GEN_PRODUTO_FORNECEDOR'))
    ,1, p.ID, 0, 0, null, 0, 0, 0, 0, 0, 0,
    (select cast('Now' as timestamp) from rdb$database),
    null, 0, 0, 'S'
from PRODUTO p
where not exists (select * from produto_fornecedor pf where (pf.fk_produto = p.ID));
commit work
--*/
-- ==================================================
-- APAGAR CADASTROS
-- ==================================================
-- Deleta Vendedor (mantém apenas o primeiro)
--/*
delete from CADASTRO where (CHK_VENDEDOR = 'S') 
    and (ID <> 1) 
    and (CHK_CLIENTE = 'N') 
    and (CHK_FORNECEDOR = 'N') 
    and (CHK_TRANSPORTADORA = 'N');
commit work;
--*/
-- ==================================================
-- Deleta Funcionário (mantém apenas o primeiro)
--/*
delete from CADASTRO_GRUPO_VENDA_ITEM;
delete from CADASTRO where (CHK_FUNCIONARIO) = 'S' 
    and (ID <> 1) 
    and (CHK_CLIENTE = 'N') 
    and (CHK_FORNECEDOR = 'N') 
    and (CHK_TRANSPORTADORA = 'N');
commit work;
--*/
-- ==================================================
-- Deleta Contabilidade (mantém apenas o primeiro)
--/*
delete from CADASTRO where (CHK_CONTABILIDADE) = 'S' 
    and (ID <> 1) 
    and (CHK_CLIENTE = 'N') 
    and (CHK_FORNECEDOR = 'N') 
    and (CHK_TRANSPORTADORA = 'N');
commit work;
--*/
-- ==================================================
-- Apagar Clientes
/*
delete from CADASTRO where (CHK_CLIENTE) = 'S' 
    and (ID <> 1) 
    and (CHK_FORNECEDOR = 'N');
commit work;
--*/
-- ==================================================
-- Apagar Fornecedores
/*
delete from PRODUTO_GRADE_FORNECEDOR;
delete from CADASTRO where (CHK_FORNECEDOR) = 'S'
    and (ID <> 1) 
    and (CHK_CLIENTE = 'N') 
    and (CHK_TRANSPORTADORA = 'N');
commit work;
--*/
-- ==================================================
-- Apagar Transportadoras
/*
update CADASTRO c set c.FK_TRANSPORTADORA = null;
delete from CADASTRO where (CHK_TRANSPORTADORA) = 'S'
    and (ID <> 1)
    and (CHK_FORNECEDOR = 'N');
commit work;
--*/
-- ==================================================
-- Apagar Dependência de Produtos
/*
delete from PEDIDO_BALANCO_ITEM;
delete from PRODUTO_CODIGO_BARRA pcb where EXISTS (
	select p.ID from PRODUTO p where pcb.FK_PRODUTO = p.ID --and p.STATUS = 1
);
delete from PRODUTO_FISCAL pa where EXISTS (
	select p.ID from PRODUTO p where pcb.FK_PRODUTO = p.ID --and p.STATUS = 1
);
delete from PRODUTO_FORNECEDOR pa where EXISTS (
	select p.ID from PRODUTO p where pcb.FK_PRODUTO = p.ID --and p.STATUS = 1
);
delete from PRODUTO_PRECO pa where EXISTS (
	select p.ID from PRODUTO p where pcb.FK_PRODUTO = p.ID --and p.STATUS = 1
);
commit work;
--*/
-- ==================================================
-- Apagar Base 844
/*
delete from INVENTARIO_SINTETICO;
delete from PRODUTO_LOTE;
delete from INVENTARIO_SALDO_INICIAL;
delete from PRODUTO_GRADE_ITEM;
commit work;
--*/
-- ==================================================
-- Apagar Dependência de Produtos
--/*
delete from PRODUTO p --where p.STATUS = 1;
;
commit work;
--*/
-- ==================================================
-- Apagar Produtos Inativos
/*
delete from PRODUTO_GRADE_ITEM i where exists (
    select p.ID 
    from PRODUTO p 
    where p.STATUS = 1 and p.ID = i.FK_PRODUTO
);
delete from PRODUTO where STATUS = 1;
--*/
-- ==================================================
-- LIMPA REPLICAÇÃO
-- ==================================================
delete from CHANGE_SATELITE;
commit work;
execute procedure SP_SET_ALL_GENERATOR;
commit work;
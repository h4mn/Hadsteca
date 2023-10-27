import src.delphi_dpr as delphi_dpr

delphi_dpr = delphi_dpr.DelphiDPR()

def test_unit_add():
    
    delphi_dpr.unit_add('experimentos/delphi/testes/teste.dpr', 'experimentos/delphi/testes/teste.pas')
    with open('experimentos/delphi/testes/teste.dpr', 'r') as f:
        linhas = f.readlines()
    assert linhas[6] == '  experimentos/delphi/testes/teste.pas,\n'
    assert linhas[7] == '  experimentos/delphi/testes/teste2.pas,\n'
    assert linhas[8] == '  experimentos/delphi/testes/teste3.pas,\n'
    assert linhas[9] == '  experimentos/delphi/testes/teste4.pas,\n'
    assert linhas[10] == '  experimentos/delphi/testes/teste5.pas,\n'
    assert linhas[11] == '  experimentos/delphi/testes/teste6.pas,\n'
    assert linhas[12] == '  experimentos/delphi/testes/teste7.pas,\n'
    assert linhas[13] == '  experimentos/delphi/testes/teste8.pas,\n'
    assert linhas[14] == '  experimentos/delphi/testes/teste9.pas,\n'
    assert linhas[15] == '  experimentos/delphi/testes/teste10.pas,\n'
    assert linhas[16] == '  experimentos/delphi/testes/teste11.pas,\n'
    assert linhas[17] == '  experimentos/delphi/testes/teste12.pas,\n'
    assert linhas[18] == '  experimentos/delphi/testes/teste13.pas,\n'
    assert linhas[19] == '  experimentos/delphi/testes/teste14.pas,\n'
    assert linhas[20]

def test_remover_unidades_duplicadas():
    # iniciar pelo teste
    
    delphi_dpr.remover_unidades_duplicadas('experimentos/delphi/testes/teste.dpr')
// Tarefa: Tela de Cadastro de Lista de Serviços e SubServiços
procedure TfCad_ListaServicoSubServico.FormKeyDown(
  Sender: TObject;
  var Key: Word;
  Shift: TShiftState);

begin
    if PgCtrl_Cadastro.ActivePage = TabSht_Consulta then
    begin
        if Key = VK_F4 then
            Btn_LimparPesquisa.Click;
    end;

    if PgCtrl_Cadastro.ActivePage = TabSht_Principal then
    begin
        with Btn_NovoSub do
        begin
          if (ssCtrl in Shift) and (Key = Ord('N')) and Enabled then
          begin
              SetFocus;
              Click;
          end;
        end;

        with Btn_GravarSub do
        begin
          if (ssCtrl in Shift) and (Key = Ord('G')) and Enabled then
          begin
              SetFocus;
              Click;
          end;
        end;

        with Btn_CancelarSub do
        begin
          if (ssCtrl in Shift) and (Key = Ord('L')) and Enabled then
          begin
              SetFocus;
              Click;
          end;
        end;
    end;

    TPF_Interface.KeyDown(
        Sender, Key, Shift, Btn_Novo, Btn_Editar, Btn_Excluir,
        Btn_Gravar, Btn_Cancelar);
end;

// Tarefa: Tela de Cadastro de Itens da Grade de Produtos
procedure TfCad_ProdutoImagem.FormKeyDown(
  Sender  : TObject;
  var Key : Word;
  Shift   : TShiftState);

  procedure AtalhoClick(Atalho: TRzButton);
  begin
    with Atalho do
    begin
      if not (ssCtrl in Shift) then
        exit;

      if not Enabled then
        exit;

      SetFocus;
      Click;
    end;  
  end;

begin
  if Key = VK_ESCAPE then
  begin
    Close;
    Exit;
  end;

  if PgCtrl_ProdutoImagem.ActivePage = Sht_Configuracao then
  begin
    case Key of
      VK_DELETE:
        begin
          if not (ssCtrl in Shift) then
            exit;
          
          if not DBGrid_CodigoBarras.Focused then
            exit;

          if DBGrid_CodigoBarras.EditorMode then
          begin
            Key := VK_NONAME;
            exit;
          end;

          if FCad_CodigoBarra.DtSet.IsEmpty then
            exit;

          ExcluirCdigodeBarras1Click(ExcluirCdigodeBarras1);
        end;

      Ord('N'): AtalhoClick(Btn_Novo);
      Ord('G'): AtalhoClick(Btn_Gravar);
      Ord('L'): AtalhoClick(Btn_Cancelar);
    end;
  end;

  TPF_Interface.KeyDown(Sender, Key, Shift);
end;
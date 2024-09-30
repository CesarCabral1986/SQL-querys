begin transaction
begin try

create index idx_Contratos
on gl_contrato (IDContrato);

create index idx_Imoveis
on Gl_imovel (IDImovel);

create index idx_Pessoas
on Gl_Pessoa (IDPessoa);

create index idx_ContaReceber
on GL_ContaReceber (idLanctoContaReceber);

create index idx_ContaPagar
on GL_ContaPagar (idLanctoContaPagar);

create index idx_ContaProprietario
on GL_ContaProprietario (idLanctoContaProprietario);

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION;
END CATCH; 


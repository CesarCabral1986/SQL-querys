SELECT

GL_ContaProprietario.IdLanctoContaProprietario as 'Id Lançamento', 
GL_ContaProprietario.IdEmpresa as 'ID Empresa',
Gl_empresa.Nome as 'Nome Empresa',
GL_ContaProprietario.IdProprietario as 'Id Proprietario', 
GL_ContaProprietario.IdBeneficiario as 'Id Beneficiario', 
GL_Pessoa.Nome as 'Nome Beneficiario',
GL_Historico.Historico as 'Histórico', 
GL_ContaProprietario.ComplementoHistorico as 'Complemento', 
FORMAT (GL_ContaProprietario.MesReferencia, 'MM/yyyy') as 'Mês Referencia',
FORMAT (GL_ContaProprietario.MesFaturamento, 'MM/yyyy') as 'Mês Faturamento',
FORMAT (GL_ContaProprietario.DataVencimento, 'dd/MM/yyyy') as 'Data Vencimento',
GL_ContaProprietario.ValorLancto as 'Valor Repasse', 
GL_ContaProprietario.ValorResiduo as 'Valor Residuo Anterior',
GL_ContaProprietario.IdLanctoRepasse as 'Id Repasse'

FROM

GL_ContaProprietario

JOIN GL_Historico
ON GL_Historico.IDHistorico = GL_ContaProprietario.IdHistorico

join gl_empresa
on GL_ContaProprietario.IdEmpresa = Gl_empresa.IDEmpresa

join GL_Pessoa
on GL_ContaProprietario.IdBeneficiario = GL_pessoa.IDPessoa

WHERE

GL_ContaProprietario.ValorResiduo <> 0.00 AND GL_Historico.Historico LIKE '%repasse%'

order by GL_ContaProprietario.IdEmpresa, GL_ContaProprietario.IdLanctoRepasse
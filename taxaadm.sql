select
ct.IDContrato as 'Contrato',
concat (ed.Logradouro, ' ', ed.numero) as 'Imóvel',
p.Nome as 'Proprietario',
format (cp.MesReferencia, 'MM/yyyy') as 'Mês Referencia',
format (cp.DataVencimento, 'dd/MM/yyyy') as 'Data Vencimento',

CASE 
    WHEN cp.IdHistorico = 2
	THEN 'Taxa de Administração'
    ELSE 'Taxa de Intermediação' 
END AS 'Histórico',

ValorLancto as 'Valor'

from
GL_ContaProprietario cp
left join GL_Pessoa p on cp.IdProprietario = p.IDPessoa
left join GL_Imovel im on cp.IdImovel = im.IDImovel
join GL_Endereco ed on im.IDEndereco = ed.IDEndereco
left join GL_Contrato ct on im.IDContratoAtual = ct.IDContrato

where
cp.IdHistorico in (2, 13)

union all

select
'' as Contrato,
'' as Imóvel,
'' as Proprietario,
'' as 'Mês Referencia',
'' as 'Data Vencimento',
'TOTAL' as Histórico,

sum (cp.ValorLancto) as 'Valor'

from
GL_ContaProprietario cp

where
cp.IdHistorico in (2, 13)
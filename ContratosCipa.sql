SELECT 
    con.IDContrato AS 'Id Contrato',
    con.CodigoUsuario AS 'Codigo Usuario',
    CONCAT(ende.Logradouro, ' ', ende.Numero, ' ', ende.Complemento, ' ', bai.Bairro, ' - ', cid.Cidade, ' - ', uf.Sigla) AS 'Logradouro',
    pes.Nome AS 'Proprietario',
    pes2.Nome AS 'Locatario',
    con.DataInicio AS 'Data inicio',
    con.DataFim AS 'Data fim',
    ca.DataInicio AS 'Data inicio da faixa',
    con.DataUltAcordoAluguel AS 'Data do ultimo reajuste',
    ca.DataUltimoReajuste AS 'Data ultimo reajuste',

    CASE
        WHEN ca.ValorReajuste IS NULL OR ca.ValorReajuste = 0 
        THEN CAST(ca.Valor AS DECIMAL(10, 2))
        ELSE CAST(ca.ValorReajuste AS DECIMAL(10, 2))
    END AS 'Valor Aluguel Atual'

FROM gl_contrato con
LEFT JOIN GL_ContratoImovel ci ON con.IDContrato = ci.IDContrato
JOIN GL_Imovel imo ON ci.IDImovel = imo.IDImovel
JOIN GL_Endereco ende ON imo.IDEndereco = ende.IDEndereco
JOIN GL_Bairro bai ON ende.IDBairro = bai.IDBairro
JOIN GL_Cidade cid ON ende.IDCidade = cid.IDCidade
JOIN GL_UF uf ON cid.IDUF = uf.IDUF
JOIN GL_ImovelProprietario ipr ON imo.IDImovel = ipr.IDImovel
JOIN GL_Pessoa pes ON ipr.IDProprietario = pes.IDPessoa
JOIN GL_ContratoPessoa cp ON con.IDContrato = cp.IDContrato
JOIN gl_pessoa pes2 ON cp.IDPessoa = pes2.IDPessoa
JOIN GL_ContratoAluguel ca ON con.IDContrato = ca.IDContrato

WHERE ipr.Principal = 1
  AND ci.Principal = 1
  AND cp.TipoPessoa = 0
  AND cp.Principal = 1

ORDER BY con.IDContrato;

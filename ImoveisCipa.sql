SELECT
    im.IDImovel AS 'ID Imóvel',
    im.CodigoUsuario AS 'Codigo do Imóvel',
    ed.Logradouro AS 'Rua',
    ed.Numero AS 'Numero',
	ed.Complemento as 'Complemento',
    b.Bairro AS 'Bairro',

    CASE
        WHEN c.DataDesocupacao IS NULL THEN 'Ocupado'
        ELSE 'Desocupado'
    END AS 'Status do Imóvel',

    CASE 
        WHEN im.DESTINACAO = 0 THEN 'Normal' 
        ELSE 
            CASE 
                WHEN im.DESTINACAO = 1 THEN 'Adm. Pgto. Isento' 
                ELSE 
                    CASE 
                        WHEN im.DESTINACAO = 2 THEN 'Sem isenção - Adm. Pgto. Isento' 
                        ELSE 
                            CASE 
                                WHEN im.DESTINACAO = 3 THEN 'Normal - Somente para alugar' 
                                ELSE 'Não Definido' 
                            END 
                    END 
            END 
    END AS 'Destinação',

    CASE
        WHEN ca.ValorReajuste IS NULL OR ca.ValorReajuste = 0 THEN CAST(ca.Valor AS DECIMAL(10, 2))
        ELSE CAST(ca.ValorReajuste AS DECIMAL(10, 2))
    END AS 'Valor Aluguel Atual',

    sc.SituacaoContrato AS 'Situação Contrato',
    p.Nome AS 'Nome Locatário',
    c.DataFim AS 'Data Fim Contrato',
    c.DataUltAcordoAluguel AS 'Data Último Acordo',
    ca.DataReajuste AS 'Data Próximo Reajuste',
    i.Indice AS 'Índice'

FROM GL_Imovel im
LEFT JOIN GL_Endereco ed ON im.IDEndereco = ed.IDEndereco
LEFT JOIN GL_Bairro b ON ed.IDBairro = b.IDBairro
LEFT JOIN GL_Contrato c ON im.IDContratoAtual = c.IDContrato
LEFT JOIN GL_ContratoAluguel ca ON c.IDContrato = ca.IDContrato
LEFT JOIN GL_SituacaoContrato sc ON c.IDSituacaoContrato = sc.IDSituacaoContrato
LEFT JOIN GL_ContratoPessoa cp ON c.IDContrato = cp.IDContrato
LEFT JOIN GL_Pessoa p ON cp.IDPessoa = p.IDPessoa
LEFT JOIN GL_Indice i ON ca.IDIndice = i.IDIndice

WHERE ca.DataInicio = (
    SELECT MAX(ca2.DataInicio)
    FROM GL_ContratoAluguel ca2
    WHERE ca2.IDContrato = ca.IDContrato
)
AND cp.TipoPessoa = 0 AND principal = 1;

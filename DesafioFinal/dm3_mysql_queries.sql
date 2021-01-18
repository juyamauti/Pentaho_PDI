CREATE SCHEMA IF NOT EXISTS `stage` DEFAULT CHARACTER SET utf8 ;
CREATE SCHEMA IF NOT EXISTS `dw` DEFAULT CHARACTER SET utf8 ;

select * from stage.territorio;
select * from stage.regiao;
select * from stage.categoria;
select count(1) from stage.cliente;
select * from stage.funcionario;
select * from stage.produto;
select * from stage.vendas;

select * from dw.dim_funcionario;
select * from dw.dim_produto;
select * from dw.dim_cliente;
select count(1) from dw.dim_tempo;
select * from dw.fato_vendas;

/*truncate table dw.dim_cliente;
truncate table dw.dim_funcionario;
truncate table dw.dim_produto;
truncate table dw.dim_tempo;
truncate table dw.fato_vendas;

drop table dw.fato_vendas;*/

update dw.dim_funcionario
set nomFuncionario = 'Erro'
where sk_funcionario=1;

select * from dw.fato_vendas where dim_data_sk_data is null;

-- Adicionando a PK da fato
ALTER TABLE `fato_vendas`
ADD PRIMARY KEY (`sk_produto`,`sk_cliente`, `sk_funcionario`, `sk_data`);


select *
from dw.fato_vendas
where sk_funcionario = 1.0;

select sr.idRegiao, sr.nomRegiao, count(dc.idRegiao) as qtde from stage.regiao sr
	left join dw.dim_cliente dc
		on dc.idRegiao = sr.idRegiao
group by sr.idRegiao, sr.nomRegiao;
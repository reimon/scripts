-- 0000534 - MARIA COSTA,,,,,,,,,,,,,,,,,,,,,,,,,,,,,* ,teste@teste.com,,073999999999
drop table #tmp_list
drop table #tmp_result
Select
       Name	=	ger_cg.cg_cd + ' - ' +ger_cg.cg_nm,
	   cg_email as 'email',
       (case  
			when (ger_cg.cg_fone1  like '3%') then ger_cg.cg_fone2  
			when (ger_cg.cg_fone1  like '2%') then ger_cg.cg_fone2
			when (ger_cg.cg_fone1 like '0733%') then ger_cg.cg_fone2 
			when (ger_cg.cg_fone1 like '0732%') then ger_cg.cg_fone2 
			WHEN len(ger_cg.cg_fone1) <7 then ger_cg.cg_fone2
			when len(cg_fone1) = 8 then '0739' + cg_fone1 else '073' + ger_cg.cg_fone1 end  ) as tel

into #tmp_list
from  ger_cg
where cg_tp = 'F' and 
cg_dtalt > '01-01-2017'
						
GROUP BY ger_cg.cg_cd, ger_cg.cg_nm, cg_fone1, cg_fone2, cg_fone3, cg_bairro, cg_cidade, ger_cg.cg_end,ger_cg.cg_endnr, ger_cg.cg_cep, ger_cg.uf_cd ,cg_email,cg_dddddi
order by ger_cg.cg_cd

-- remove os telefones nulls
select Name , email, 
			(case  
			when (tel  like '3%') then NULL 
			when (tel like '2%') then NULL 
			when (tel like '0733%') then NULL 
			when (tel like '0732%') then NULL 
			WHEN len(tel) <7 then NULL 
			when len(tel) = 8 then '0739' + tel 
			when len(tel) = 9 then '073' + tel else tel end  ) as tel
into #tmp_result
from #tmp_list
where tel IS NOT NULL

select Name +',,,,,,,,,,,,,,,,,,,,,,,,,,,,,* ,'+ email+',,' +tel from #tmp_result
where tel IS NOT NULL



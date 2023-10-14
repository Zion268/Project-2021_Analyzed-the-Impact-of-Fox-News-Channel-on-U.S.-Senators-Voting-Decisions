
*table 5*
*PLACEBO TEST*

clear

use "E:\Final Paper\data\congress102-104_Placebo.dta"

*假设差异发生在102-103*

set more off

gen after1=.
replace after1=1 if cong!=102
replace after1=0 if cong==102

gen treat=.
replace treat=0 if fox1998==1 & fox2000==1
replace treat=1 if fox1998==0 & fox2000==1

gen did1=after1*treat

logit PartyVote after1 treat did1 daystoelection daystoelection2 daystoelection3 Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1, cluster(dist2)

est store m1

logit PartyVote after1 treat did1 daystoelection Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==0, cluster(dist2)

est store m2

logit PartyVote after1 treat did1 daystoelection daystoelection2 daystoelection3 Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==1, cluster(dist2)

est store m3


*输出结果表格*

reg2docx m1 m2 m3 using table5-1.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(表5: 安慰剂检验（102-104届国会）) mtitles("所有议员""民主党议员""共和党议员")



*假设差异发生在103-104*

gen after2=.
replace after2=0 if cong!=104
replace after2=1 if cong==104

gen did2=after2*treat

logit PartyVote after2 treat did2 daystoelection daystoelection2 daystoelection3 Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1, cluster(dist2)

est store m4

logit PartyVote after2 treat did2 daystoelection Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==0, cluster(dist2)

est store m5

logit PartyVote after2 treat did2 daystoelection daystoelection2 daystoelection3 Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==1, cluster(dist2)

est store m6

*输出结果表格*

reg2docx m4 m5 m6 using table5-2.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(表5: 安慰剂检验（102-104届国会）) mtitles("所有议员""民主党议员""共和党议员")

*注：文中的表5是由此输出的表5-1与表5-2手动合并而成的*
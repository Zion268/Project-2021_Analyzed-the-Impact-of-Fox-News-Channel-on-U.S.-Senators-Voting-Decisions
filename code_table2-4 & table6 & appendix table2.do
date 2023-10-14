*table 2 3 4 6以及appendix table-2均使用105-106 panel.dta*
*table 2*
*对比1998年没有接入福克斯新闻但2000年接入了的选区和这段时期一直接入福克斯新闻的选区（实验组与对照组）*

clear
use "E:\Final Paper\data\congress 105-106 panel.dta"

set more off

gen daysfox=daystoelection*FoxNews
gen days2fox=daystoelection2*FoxNews
gen days3fox=daystoelection3*FoxNews

gen dvprop=dv/100

gen daysdv=daystoelection*dvprop
gen days2dv=daystoelection2*dvprop
gen days3dv=daystoelection3*dvprop

gen before=.
replace before=0 if cong==106
replace before=1 if cong==105

gen untreat=.
replace untreat=1 if fox1998==0 & fox2000==1
replace untreat=0 if fox1998==1 & fox2000==1

gen did2=before*untreat

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1, cluster(dist2)

est store m1

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==0, cluster(dist2)

est store m2

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==1, cluster(dist2)

est store m3

*输出结果表格*

reg2docx m1 m2 m3 using table2.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(表2: 实验组与控制组的双重差分结果) mtitles("所有议员""民主党议员""共和党议员" )







*table 3*

*不分党派-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果*

gen half=.

replace half=1 if dvprop>0.5
replace half=0 if dvprop<=0.5

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==0, cluster(dist2)

est store m1

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==1, cluster(dist2)

est store m2


*民主党议员-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果（支持民主党的选民较少的选区没有选出民主党议员）*

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==1 & Republican==0, cluster(dist2)

est store m3


*共和党议员-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果（支持民主党的选民较多的选区没有选出共和党议员）*


logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==0 & Republican==1, cluster(dist2)

est store m4


*输出结果表格*

reg2docx m1 m2 m4 m3 using table3.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(表3: 实验组与控制组按选区党派支持情况分样本后双重差分结果) mtitles("共和党支持者过半的选区" "民主党支持者过半的选区" "共和党议员在本党支持过半的选区" "民主党议员在本党支持过半的选区")






*表4非争议性投票 NON-PARTY VOTES*

*民主党议员*

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==0 & Republican==0, cluster(dist2)

est store m1


*共和党议员*

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==0 & Republican==1, cluster(dist2)

est store m2

*不分党派-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果*

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==0 & half==0, cluster(dist2)

est store m3

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==0 & half==1, cluster(dist2)

est store m4


*民主党议员-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果（支持民主党的选民较少的选区没有选出民主党议员）*

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==0 & half==1 & Republican==0, cluster(dist2)

est store m5

*共和党议员-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果（支持民主党的选民较多的选区没有选出共和党议员）*

logit PartyVote before untreat did2 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==0 & half==0 & Republican==1, cluster(dist2)

est store m6

*输出结果表格*

reg2docx m1 m4 m5 m2 m3 m6 using table4.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(表4: 实验组与控制组非争议性议题投票行为的双重差分结果) mtitles("民主党" "民主党支持者过半的选区" "民主党议员在本党支持过半的选区" "共和党""共和党支持者过半的选区" "共和党议员在本党支持过半的选区")










*table 6*

gen after=.
replace after=1 if cong==106
replace after=0 if cong==105

gen treat=.
replace treat=0 if fox1998==0 & fox2000==0
replace treat=1 if fox1998==0 & fox2000==1

gen did1=after*treat


*所有议员*

logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1, cluster(dist2)

est store m1

*民主党议员*

logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==0, cluster(dist2)

est store m2

*共和党议员*

logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & Republican==1, cluster(dist2)

est store m3

*输出结果表格*

reg2docx m1 m2 m3 using table6.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(表6: 实验组与控制组2的双重差分结果) mtitles("所有议员" "民主党议员" "共和党议员")





*附表2*

*不分党派-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果*

logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==0, cluster(dist2)

est store m1

logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==1, cluster(dist2)

est store m2


*民主党议员-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果（支持民主党的选民较少的选区没有选出民主党议员）*


logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==1 & Republican==0, cluster(dist2)

est store m3


*共和党议员-根据选区内支持民主党的选民所占比例是否过半分为两组-再分组看DID结果（支持民主党的选民较多的选区没有选出共和党议员）*


logit PartyVote after treat did1 daystoelection daystoelection2 daystoelection3 daysfox days2fox days3fox dvprop daysdv days2dv days3dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag RegPass Susp OtherPass Amend ProPart if PresencePartyUnity==1 & half==0 & Republican==1, cluster(dist2)

est store m4

*输出结果表格*

reg2docx m1 m2 m4 m3 using apptable2.docx, replace indicate("ind=ind*") scalars(N r2(%9.3f) r2_a(%9.2f)) b(%9.3f) t(%7.2f) title(附表2: 实验组与控制组2按选区党派支持情况分样本后双重差分结果) mtitles("共和党支持者过半的选区" "民主党支持者过半的选区" "共和党议员在本党支持过半的选区" "民主党议员在本党支持过半的选区")


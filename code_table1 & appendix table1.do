*table 1 与appendix table 1 均使用district105-106.dta*

use "E:\Final Paper\data\district105-106.dta"

*table 1*

t2docx Republican dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag if fox2000==1 using table1.docx, replace  by(fox1998)  title("表 1：实验组与控制组的可观测变量平衡性检验")

*appendix table 1*

t2docx Republican dv Retirement seniorit voteshare_lag qualchal_lag qualchal spendgap_lag spendgap distpart_lag if fox1998==0 using appendix-table1.docx, replace  by(fox2000)  title("附表 1： 实验组与控制组2的可观测变量平衡性检验")
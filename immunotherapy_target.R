immuno_target_symbol = c('PDCD1', 'CD274', 'PDCD1LG2', 'HAVCR2', 'LAG3', 'BTLA', 'C10orf54', 'CD8A', 'CD4', 'PTPRC', 'MKI67', 'FOXP3', 'CD68', 'STAT1', 'GZMB', 'IFNG')
immuno_target_alias = c('PD-1', 'PD-L1', 'PD-L2', 'TIM-3', 'LAG-3', 'BTLA', 'VISTA', 'CD8', 'CD4', 'CD45', 'Ki67', 'Fox-P3', 'CD68', 'pSTAT1', 'granzyme B', 'IFNG')
immuno_ensembl = c("ENSG00000188389_PDCD1", "ENSG00000120217_CD274", "ENSG00000197646_PDCD1LG2", "ENSG00000135077_HAVCR2", "ENSG00000089692_LAG3", "ENSG00000186265_BTLA", "none", "ENSG00000153563_CD8A", "ENSG00000010610_CD4", "ENSG00000081237_PTPRC", "ENSG00000148773_MKI67", "ENSG00000049768_FOXP3", "ENSG00000129226_CD68", "ENSG00000115415_STAT1", "ENSG00000100453_GZMB", 'ENSG00000111537_IFNG') 

tmp =  c('HLA-A', 'HLA-B', 'HLA-G', 'HLA-C', 'HLA-E', 'HLA-F', 'HLA-H', 'HLA-J', 'HLA-L', 'HLA-K', 'HLA-DPA1', 'HLA-DPB1', 'HLA-DQA1', 'HLA-DQB1', 'HLA-DRB1')
immuno_target_symbol = c(immuno_target_symbol, tmp)
immuno_target_alias = c(immuno_target_alias, tmp)

tmp = c('ENSG00000206503_HLA-A', 'ENSG00000234745_HLA-B', 'ENSG00000204632_HLA-G', 'ENSG00000204525_HLA-C', 'ENSG00000204592_HLA-E', 'ENSG00000204642_HLA-F', 'ENSG00000206341_HLA-H', 'ENSG00000204622_HLA-J', 'ENSG00000243753_HLA-L', 'ENSG00000230795_HLA-K', 'ENSG00000231389_HLA-DPA1', 'ENSG00000223865_HLA-DPB1', 'ENSG00000196735_HLA-DQA1', 'ENSG00000179344_HLA-DQB1', 'ENSG00000196126_HLA-DRB1')
immuno_ensembl = c(immuno_ensembl, tmp)

immuno_target = data.frame(row.names = immuno_target_symbol, symbol = immuno_target_symbol, alias = immuno_target_alias, ensembl = immuno_ensembl, stringsAsFactors = F)
immuno_target



#pseudo HLA-H
#pseudo HLA-J
#pseudo HLA-L
#pseudo HLA-K

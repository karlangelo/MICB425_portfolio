## @knitr DS_AssignmentJan262018

#Load Library
library("tidyverse")

#Exercise 1
metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")
OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")

#Exercise 2

metadata %>% rownames_to_column('sample') %>% 
  filter(CH4_nM >=100, Temperature_C<=10) %>%
  column_to_rownames('sample') %>% 
  select(Depth_m,CH4_nM,Temperature_C)

#Exercise 3

nM_to_uM_Metadata_coversion <-metadata %>% rownames_to_column('sample') %>% 
  select(matches("nM"), matches('sample')) %>% 
  mutate(N2O_uM = N2O_nM/1000, Std_N2O_uM = Std_N2O_nM/1000, CH4_uM = CH4_nM/1000, Std_CH4_uM = Std_CH4_nM/1000) %>% 
  column_to_rownames('sample')

#For Exercise 3: All variables that are in nM to μM. The output table titled: nM_to_uM_Metadata_coversion shows only the original nM and converted μμM variables.


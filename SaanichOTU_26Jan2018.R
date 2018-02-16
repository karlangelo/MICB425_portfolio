#Libraries
library("tidyverse")

#Codes

#load data
read.table(file="Saanich.metadata.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")
#to name a variable,  "variable name" = read.table and so forth

metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")
OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")

# to look at the values of the oxygen (O2) in our water samples.
metadata %>% 
  select(O2_uM) # this pulls out the variable of interest and prints it out


#  we didn’t know the exact name of the column with oxygen data in it, we could select all variables the contain “O2” or “oxygen”
# You can also generalize using logical phrases such as starts_with, ends_with, or contains.
metadata %>% 
  select(matches("O2|oxygen")) # good for data not your own, | means or = good for exploratory process and checking to ensure that you've named your variables consistantanly 

# Filter functions similarly to select only on rows instead of columns
metadata %>% 
  filter(O2_uM == 0)

#If we wanted to just see which depths have no oxygen, we can combine filter and select with a pipe.

metadata %>% 
  filter(O2_uM == 0) %>% 
  select(Depth_m)

#For comparison, to accomplish the same thing in base R, you would use the following.
metadata[metadata$O2_uM == 0, "Depth_m"]

# to create to variable, use the function/ verb: mutate
metadata %>% 
  mutate(N2O_uM = N2O_nM/1000)

# mutate keeps all of the data in addition to the new variable. 
#If we only want to keep our newly calculated variable, we use transmute instead.

metadata %>% 
  transmute(N2O_uM = N2O_nM/1000)

# transmutate is better --> In this way, you do not alter your original data (which you should never do) 
#and you do not clutter your R environment with many nearly identical data frames (which would happen if you made a new object like metadata_all_uM).

metadata %>% 
  mutate(N2O_uM = N2O_nM/1000) %>% 
  ggplot() + geom_point(aes(x=Depth_m, y=N2O_uM))


metadata %>% 
  select(("N2O_nM,Std_N2O_nM,CH4_nM,Std_CH4_nM"))



#shows that you should never put the units in the same cell as the value
metadata %>% 
  select(matches("temp"))



#Exercise 1

metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")
OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names = 1, sep="\t", na.strings="NAN")

#Exercise 2

metadata %>% rownames_to_column('sample') %>% 
  filter(CH4_nM > 100) %>% 
  filter(Temperature_C < 10) %>%
  column_to_rownames('sample') %>% 
  select(Depth_m,CH4_nM,Temperature_C)




#Exercise 3

nM_to_uM_Metadata_coversion <-metadata %>% rownames_to_column('sample') %>% 
  select(matches("nM"), matches('sample')) %>% 
  mutate(N2O_uM = N2O_nM/1000, Std_N2O_uM = Std_N2O_nM/1000, CH4_uM = CH4_nM/1000, Std_CH4_uM = Std_CH4_nM/1000) %>% 
  column_to_rownames('sample') %>% 
  View


  
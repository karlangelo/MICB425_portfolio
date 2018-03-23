## @knitr DS_AssignmentFeb162018

library("tidyverse")

source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")

library("phyloseq")

load("phyloseq_object.RData")

#Exercise 1

ggplot(metadata, aes(x=PO4_uM, y=Depth_m)) + 
  geom_point(color="purple", shape=17)

#Exercise 2
metadata %>% 
  mutate(Temperature_F= Temperature_C*9/5+32) %>% 
  ggplot() + geom_point(aes(x=Temperature_F, y=Depth_m))

#gglot with phyloseq
plot_bar(physeq, fill="Phylum")
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill="Phylum")
plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity")

#Exercise 3
plot_bar(physeq_percent, fill="Phylum", title = "Phyla from 10 to 200 in Saanich Inlet") +
  geom_bar(aes(fill=Phylum), stat="identity") + 
  labs(x="Sample depth", y="Percent relative abundance")

#Faceting
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum)

plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum, scales="free_y") +
  theme(legend.position="none")

#Exercise 4

plot_nutrients= metadata %>% 
  select(Depth_m, NH4_uM,NO2_uM, NO3_uM, O2_uM, PO4_uM, SiO2_uM) %>% 
  gather(Nutrients, Concentration, NH4_uM,NO2_uM, NO3_uM, O2_uM, PO4_uM, SiO2_uM)

ggplot(plot_nutrients, aes(x=Depth_m, y=Concentration)) +
  geom_point() + geom_line() +facet_wrap(~Nutrients, scales="free_y") +
  theme(legend.position = "none") 
  
#Create your own task using Data Wrangling cheat sheet.
# Use the package phyloseq and the following tutorial (http://deneflab.github.io/MicrobeMiseq/demos/mothur_2_phyloseq.html) in combination with the data wrangling cheatsheet to analyze 16S MiSeq data. A relative abundance chart at the phylum level and a principal coordinates analysis graph should be created. Use your own data if possible. 
# Modifiy pipes in tutorial where necessary. 

#Loading required packages
library(phyloseq)
packageVersion("phyloseq")
library(biomformat)
packageVersion("biomformat")
library(ggplot2)
packageVersion("ggplot2")
library(vegan)
library(dplyr)
library(scales)
library(grid)
library(reshape2)

# Assign variables for imported data
sharedfile = "C:/Users/Alexandra Emmons/Dropbox/BoneSurfaceProject/16S_Data/BoneSurface16S/bacteria_allA.unique.good.good.good.filter.good.unique.precluster.pick.rdp.wang.pick.tx.genus.shared"
taxfile = "C:/Users/Alexandra Emmons/Dropbox/BoneSurfaceProject/16S_Data/BoneSurface16S/bacteria_allA.unique.good.good.good.filter.good.unique.precluster.pick.rdp.wang.pick.tx.1.cons.genus.taxonomy"
mapfile = "C:/Users/Alexandra Emmons/Dropbox/BoneSurfaceProject/STAMP/16S/BoneSurface_metadata_all.csv"

# Import mothur data
mothur_data <- import_mothur(mothur_shared_file = sharedfile, mothur_constaxonomy_file = taxfile)

# Import sample metadata
map <- read.csv(mapfile)
head(map)

#This was not in the tutorial, but was required for the PCoA.
#make Cortical.Content into a character vector for later analysis
map <- transform(map, Cortical.Content = as.character(Cortical.Content))

map <- sample_data(map)
# Assign rownames to be Sample ID's
rownames(map) <- map$Sample.Id


# Merge mothurdata object with sample metadata
moth_merge <- merge_phyloseq(mothur_data, map)
moth_merge


colnames(tax_table(moth_merge))

colnames(tax_table(moth_merge)) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

#Now we will filter out Eukaryotes, Archaea, chloroplasts and mitochondria using dplyr 
Bones <- moth_merge %>%
  subset_taxa(
    Kingdom == "Bacteria" &
      Family  != "mitochondria" &
      Class   != "Chloroplast"
  )

Bones

#so far, following tutorial. 
##Stacked bar plots
# melt to long format (for ggploting) 
# prune out phyla below 2% in each sample
Bones_phylum <- Bones %>%
  tax_glom(taxrank = "Phylum") %>%                     # agglomerate at Phylum level
  transform_sample_counts(function(x) {x/sum(x)} ) %>% # Transform to rel. abundance
  psmelt() %>%                                         # Melt to long format
  filter(Abundance > 0.02)                         # Filter out low abundance taxa
#did not arrange by phylum

#Bones are available from 3 individuals. Unlike the tutorial, I want relative abundances to be averaged by bone type across three individuals. This can be done using the data wrangling cheat sheet. 
Bones_phylum_1 <- Bones_phylum %>%
  arrange(Bone.Type, Bone.Region) %>%
  group_by(Bone.Type) %>%
  mutate(avg.rel.abund = mean(Abundance)) 

# Set colors for plotting #set palette instead?
phylum_colors <- c(
  "#CBD588", "#5F7FC7", "orange","#DA5724", "#508578", "#CD9BCD",
  "#AD6F3B", "#673770","#D14285", "#652926", "#C84248", 
  "#8569D5", "#5E738F","#D1A33D", "#8A7C64", "#599861"
)

##This plot needs work. Bar width needs to be uniform. may need to use phylum file
# Plot 
ggplot(Bones_phylum_1, aes(x = Bone.Type, y = avg.rel.abund, fill = Phylum)) + 
  
  facet_grid(~Bone.Region, scale="free_x", drop = TRUE) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = phylum_colors) +
  # Remove x axis title
  theme(axis.title.x = element_blank()) + 
  guides(fill = guide_legend(reverse = TRUE, keywidth = 1, keyheight = 1)) +
  ylab("Relative Abundance (Phylum > 2%)\n") +
  ggtitle("Phylum Level Composition of Bone-Associated Bacterial Communities by Individual") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Scales reads by 
# 1) taking proportions,
# 2) multiplying by a given library size of n
# 3) rounding down
scale_reads <- function(physeq, n) {
  physeq.scale <-
    transform_sample_counts(physeq, function(x) {
      (n * x/sum(x))
    })
  otu_table(physeq.scale) <- floor(otu_table(physeq.scale))
  physeq.scale <- prune_taxa(taxa_sums(physeq.scale) > 0, physeq.scale)
  return(physeq.scale)
}


# Scale reads to even depth  (this seems unclear- 63,127 is the smallest read count)
Bones_scale <- Bones %>%
  scale_reads(63127) 

# Ordinate
Bones_pcoa <- ordinate(
  physeq = Bones_scale, 
  method = "PCoA", 
  distance = "bray"
)
# Plot 
plot_ordination(
  physeq = Bones_scale,
  ordination = Bones_pcoa,
  color = "Bone.Region",
  shape= "Cortical.Content",
  
  title = "PCoA of Bone-Associated bacterial Communities"
) + 
  scale_color_manual(values = c("#a65628", "red", "#ffae19",
                                "#4daf4a", "#1919ff", "darkorchid3", "magenta", "darkmagenta")
  ) +
  geom_point(aes(color = Bone.Region), alpha = 0.7, size = 4) +
  geom_point(colour = "grey90", size = 1.5) 

'#
Topic: Exploring Levels of Hemoglobin for Different Sports
Name: Filippo Guardassoni
University: Unimi
Course: Probabilistic Modeling
Date: 08/2022
#'

'#
if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager") 
BiocManager::install("RBGL") 
BiocManager::install("Rgraphviz")
install.packages("igraph")
install.packages("gRbase")
install.packages("ggm")
install.packages("gRim")
install.packages("mgm")
install.packages("bnlearn")
install.packages("pcalg")
install.packages("deal")
install.packages("gRain")
install.packages("GeneNet")
install.packages("RHugin")
install.packages("BayesNetBP")
install.packages("visNetwork")
install.packages("cleandata")
#'

library(pastecs)
library(ggplot2)
library(dplyr)
library(gridExtra)
library(corrplot)
library(gRim)
library(bnlearn)
library(visNetwork)
library(gRain)
library(cleandata)

#==============================================================================
# DATASET
#==============================================================================

set.seed(1234)
ais <- read.csv("/Users/amministratore/Documents/Data Science/Second Year/Second Semester/Probabilistic Modelling/Project/probabilistic_project/ais.csv")
attach(ais)

#==============================================================================
# EXPLORATORY DATA ANALYSIS
#==============================================================================

# First Look
summary(ais)
str(ais)
stat.desc(ais)

# Analysis over sports
ggplot(ais, aes(x=sport, y=hg, fill=sport)) + 
  geom_boxplot() + 
  scale_fill_manual(values=colorRampPalette(c('blue', 'red', 'yellow'))(10)) + 
  theme_minimal()

sportcount <- ais %>%
  group_by(sport) %>%
  summarize(sport_count = n())

ggplot(sportcount, aes(x=sport, y=sport_count, fill=sport)) +
  geom_bar(stat="identity") + theme_minimal() + 
  scale_fill_manual(values=colorRampPalette(c('blue', 'red', 'yellow'))(10)) + 
  theme_minimal()

ggplot(ais %>% group_by(sport) %>% count(sport, sex) %>% 
         mutate(pct=n/sum(n)), 
       aes(sport, n, fill=sex)) + 
  geom_bar(stat="identity") + 
  geom_text(aes(label=paste0(sprintf("%1.1f", pct*100),"%")), 
            position=position_stack(vjust=0.5)) + 
  theme_minimal()

# Analysis over sex
ggplot(ais, aes(x=sex, y=hg, fill=sex)) + 
  geom_boxplot() + theme_minimal()

# Analysis of variable interactions
s1 <- qplot(data=ais, x=hg, y=wcc, colour=sex) + theme_minimal()                                                           
s2 <- qplot(data=ais, x=hg, y=hc, colour=sex) + theme_minimal()
s3 <- qplot(data=ais, x=hg, y=rcc, colour=sex) + theme_minimal()
s4 <- qplot(data=ais, x=hg, y=ferr, colour=sex) + theme_minimal()
s5 <- qplot(data=ais, x=hg, y=bmi, colour=sex) + theme_minimal()
s6 <- qplot(data=ais, x=hg, y=ssf, colour=sex) + theme_minimal()
s7 <- qplot(data=ais, x=hg, y=pcBfat, colour=sex) + theme_minimal()
s8 <- qplot(data=ais, x=hg, y=lbm, colour=sex) + theme_minimal()
s9 <- qplot(data=ais, x=hg, y=ht, colour=sex) + theme_minimal()
s10 <- qplot(data=ais, x=hg, y=wt, colour=sex) + theme_minimal()

grid.arrange(grobs = list(s1, s2, s3, s4, s5, s6, s7, s8, s9, s10),
             ncol = 3, top = "Scatter Plots")

# Analysis of variable distributions
h1 <- ggplot(data=ais, aes(x=rcc)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 0.1) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h2 <- ggplot(data=ais, aes(x=wcc)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 0.5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h3 <- ggplot(data=ais, aes(x=hc)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 1) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h4 <- ggplot(data=ais, aes(x=hg)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 0.5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h5 <- ggplot(data=ais, aes(x=ferr)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 10) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h6 <- ggplot(data=ais, aes(x=bmi)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 1) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h7 <- ggplot(data=ais, aes(x=ssf)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h8 <- ggplot(data=ais, aes(x=pcBfat)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 1.5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h9 <- ggplot(data=ais, aes(x=lbm)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h10 <- ggplot(data=ais, aes(x=ht)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()
h11 <- ggplot(data=ais, aes(x=wt)) + 
  geom_histogram(aes(y=..density..), fill="#00BFC4", binwidth = 5) + 
  geom_density(alpha = .2, color="black") + 
  theme_minimal()

grid.arrange(grobs = list(h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11),
             ncol = 3, top = "Histograms")


# Correlation Matrix
ais.corr <- select(ais, -c(sex, sport))
ais.corr <- scale(ais.corr, center=TRUE, scale=TRUE)

corr <- cor(ais.corr)
round(corr, 2)

corrplot.mixed(corr, order = "hclust",
               tl.col = "black", tl.srt = 45)

#==============================================================================
# PROBABILISTIC MODELING - BAYES NETWORK
#==============================================================================

#==============================================================================
## MANUALLY INPUTTED STRUCTURES
#==============================================================================

# SIMPLE DISCRETE CASE
# Using hg, hc and sports
# Set boolean variables
ais.disc <- as.data.frame(ais)
ais.disc$high_hc <- as.factor(ais$hc > median(ais$hc))
ais.disc$high_hg <- as.factor(ais$hg > median(ais$hg))

# Create an empty graph
structure <- empty.graph(c("high_hc", "high_hg", "sport"))

# Set relationships manually
modelstring(structure) <- "[high_hc][sport][high_hg|sport:high_hc]"

# Plot network function
plot.network <- function(structure, ht = "400px"){
  nodes.uniq <- unique(c(structure$arcs[,1], structure$arcs[,2]))
  nodes <- data.frame(id = nodes.uniq,
                      label = nodes.uniq,
                      color = "darkturquoise",
                      shadow = TRUE)
  
  edges <- data.frame(from = structure$arcs[,1],
                      to = structure$arcs[,2],
                      arrows = "to",
                      smooth = TRUE,
                      shadow = TRUE,
                      color = "black")
  
  return(visNetwork(nodes, edges, height = ht, width = "100%"))
}


# Observe structure
plot.network(structure)

# Fit model and compute conditional probabilities
ais.sub <- ais.disc[ais.disc$sport %in% c("Netball", "Tennis", "W_Polo"), 
               c("high_hc", "high_hg", "sport")]
ais.sub$sport <- factor(ais.sub$sport)
bn.mod <- bn.fit(structure, data = ais.sub)
bn.mod

cat("P(high hemaglobin levels) =", 
    cpquery(bn.mod, (high_hg=="TRUE"), TRUE), "\n")

# Trying different queries
# 1) High hg | Play wp, high hc
cat("P(High hg | Play wp, high hc) =", 
    cpquery(bn.mod, (high_hg=="TRUE"), (sport=="W_Polo"&high_hc=="TRUE")), "\n")
# 2) Play water polo | high hg, high hc
cat("P(Play water polo | high hg, high hc) =", 
    cpquery(bn.mod, (sport=="W_Polo"), (high_hg=="TRUE"&high_hc=="TRUE")), "\n")
# 3) Play water polo | high hg
cat("P(Play water polo | high hg) =", 
    cpquery(bn.mod, (high_hg=="TRUE"), (sport=="W_Polo")), "\n")



#==============================================================================
# ALGORITHMICALLY DEFINED STRUCTURES
#==============================================================================
#==============================================================================
# Structure Learning
#==============================================================================

# Remove variables that are functions of others
ais.sub.4 <- ais.fm[, c("hc", "hg", "lbm", "rcc", "wcc", "ferr", "ht", "wt", 
                        "ssf", "sex", "sport")]

# Adjust input variables
ais.sub.4 <- ais.sub %>% mutate(
  across(where(is.character), as.factor),
  across(where(is.integer), as.numeric)
)

# Discretize data
ais.disc.2 <- discretize(ais.disc.2, method = "hartemink",
                    breaks = 2, ibreaks = 60, idisc = "quantile")
head(ais.disc.2)

# Compute DAG with a Constraint-based structure learning
dag.hiton = si.hiton.pc(ais.disc.2, undirected = FALSE)
dag.hiton

plot.network(dag.hiton)

# Compute DAG with a Score-based structure learning
dag.hc <- hc(ais.disc.2, score = "bic")
dag.hc

plot.network(dag.hc)

# Compute DAG with a Score-based structure learning with whitelist
dag.hc <- hc(ais.disc.2, whitelist = data.frame(from = c("sport", "sex"), to = c("hg", "hg")) , score = "bic")
dag.hc

plot.network(dag.hc)



# Compute DAG with a Hybrid structure learning
dag.mmhc <- mmhc(ais.disc.2)
dag.mmhc

plot.network(dag.mmhc)

#==============================================================================
# Parameter Learning - Maximum Likelihood Estimate
#==============================================================================

# Addressing problems of the dataset with bootstrap
boot <- boot.strength(ais.disc.2, R = 500, algorithm = "hc", algorithm.args = list(whitelist=data.frame(from = c("sport", "sex"), to = c("hg", "hg"))))
head(boot[(boot$strength > 0.85) & (boot$direction >= 0.5), ], n = 3)

attr(boot, "threshold")

avg.hc = averaged.network(boot)

strength.plot(avg.hc, boot, shape = "ellipse")

par(mfrow = c(1, 2))
graphviz.compare(avg.hc, dag.hc, shape = "ellipse", main = c("averaged DAG", "single DAG"))
compare(avg.hc, dag.hc)

plot.network(avg.hc)

ais.disc.3 = ais.disc.2[, 1:11]
for (i in names(ais.disc.3[, 1:9]))
  levels(ais.disc.3[, i]) = c("LOW", "HIGH")

# Fit the model and create CPTs
fitted <- bn.fit(avg.hc, ais.disc.3, method = "mle")
fitted

fitted$sex
fitted$sport

#==============================================================================
# Model Validation
#==============================================================================
predcor = structure(numeric(9), names = c("hc", "hg", "lbm", "rcc", "wcc", 
                                          "ferr", "ht", "wt", "ssf"))
for (var in names(predcor)) {
  xval = bn.cv(ais.sub.4, bn="hc", fit="mle", loss="cor-lw", 
               loss.args=list(target=var, n=200), method="k-fold", runs = 10)
  predcor[var] = mean(sapply(xval, function(x) attr(x, "mean")))
}

round(predcor, digits = 3)

mean(predcor)

encode_ordinal <- function(x, order = unique(x)) {
  x <- as.numeric(factor(x, levels = order, exclude = NULL))
  x
}

ais.encoded <- as.data.frame(ais.sub.4)
ais.encoded[["sport"]] <- encode_ordinal(ais.sub.4[["sport"]])
ais.encoded[["sex"]] <- encode_ordinal(ais.sub.4[["sex"]])

xval.2 = bn.cv(ais.encoded, bn = "hc", loss = "cor-lw", loss.args = list(target = "sex", n = 200), runs = 10)

err = numeric(10)

for (i in 1:10) {
  tt = table(unlist(sapply(xval.2[[i]], '[[', "observed")),
             unlist(sapply(xval.2[[i]], '[[', "predicted")) > 0.50)
  err[i] = (sum(tt) - sum(diag(tt))) / sum(tt)
}

summary(err)

xval.3 = bn.cv(ais.encoded, bn = "hc", loss = "cor-lw", loss.args = list(target = "sport", n = 200), runs = 10)

err.2 = numeric(10)

for (i in 1:10) {
  tt.2 = table(unlist(sapply(xval.3[[i]], '[[', "observed")),
             unlist(sapply(xval.3[[i]], '[[', "predicted")) > 0.50)
  err.2[i] = (sum(tt.2) - sum(diag(tt.2))) / sum(tt.2)
}

summary(err.2)

# Model Averaging from multiple searches
nodes <- names(ais.disc.2)
start <- random.graph(nodes = nodes, method = "ic-dag",
                      num = 500, every = 50)
netlist <- lapply(start,
                  function(net) {
                    hc(ais.disc.2, score = "bic", iss = 10, start = net)
                  }
)

start <- custom.strength(netlist, nodes = nodes)

avg.start <- averaged.network(start)
plot.network(avg.start)

avg.boot <- averaged.network(boot)
plot.network(avg.boot)

all.equal(cpdag(avg.boot), cpdag(avg.start))

#==============================================================================
# Inference
#==============================================================================
# P(hg = high | sex = f)
cat("P(hg = high | sex = f) =", 
    cpquery(fitted, (hg == "HIGH"), (sex == "f")), "\n")

# P(sex = m | wcc = high)
cat("P(sex = m | wcc = high) =", 
    cpquery(fitted, (sex == "m"), (wcc == "HIGH")), "\n")

# P(BMI = HIGH | hg = HIGH, wcc = HIGH, rcc = HIGH, ht = HIGH, ferr = HIGH)
cat("P(lbm = HIGH  | hg = HIGH, wcc = HIGH, rcc = HIGH, ht = HIGH, ferr = HIGH) =", 
    cpquery(fitted, (lbm == "HIGH"), (hg == "HIGH" & wcc == "HIGH"& rcc == "HIGH" & ht == "HIGH" & ferr == "HIGH")), "\n")

# P(hg = low | sex = f & sport = swim)
cat("P(hg = low | sex = f & sport = swim) =", 
    cpquery(fitted, (hg == "LOW"), (sex == "f" & sport == "Swim")), "\n")

# P(wt = HIGH & ht = LOW | hg = HIGH, lbm = "HIGH")
cat("P(wt = HIGH & ht = LOW | hg = HIGH, lbm = HIGH) =", 
    cpquery(fitted, (wt == "HIGH"  & ht == "LOW"), (hg == "HIGH" & lbm == "HIGH")), "\n")














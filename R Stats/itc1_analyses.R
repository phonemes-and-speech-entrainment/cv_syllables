setwd("/Users/gigel/Documents/Speech EEG/Experiment 2/Experiment 2 datasets 3")

library(car)

dataCond <- read.csv("itc1_cond.csv")
condLevels <-c(1:15)
condFactor <-as.factor(condLevels)
condFrame <- data.frame(condFactor)
condBind <- cbind(dataCond$Vowel,dataCond$B,dataCond$D,dataCond$G,dataCond$K,dataCond$P,dataCond$T,dataCond$M,dataCond$N,dataCond$S,dataCond$Z,dataCond$L,dataCond$R,dataCond$F,dataCond$V)
condModel <- lm(condBind ~ 1)
analysis2 <- Anova(condModel, idata = condFrame, idesign = ~condFactor)

dataConsonants1 <- read.csv("itc1_consonants1.csv")
consonant1Levels <-c(1,2,3,4,5)
cons1Factor <-as.factor(consonant1Levels)
cons1Frame <- data.frame(cons1Factor)
cons1Bind <- cbind(dataConsonants1$Sibilants,dataConsonants1$Nasals,dataConsonants1$Fricatives,dataConsonants1$Rhotics,dataConsonants1$Stops)
cons1Model <- lm(cons1Bind ~ 1)
analysis3 <- Anova(cons1Model, idata = cons1Frame, idesign = ~cons1Factor)

consonants1_ttests=read.csv("itc1_consonants1_ttests.csv")
pairwise.t.test(consonants1_ttests$ITC, consonants1_ttests$Consonant, p.adj = "bonferroni", paired = TRUE)

dataConsonants2 <- read.csv("itc1_consonants2.csv")
consonant2Levels <-c(1,2,3)
cons2Factor <-as.factor(consonant2Levels)
cons2Frame <- data.frame(cons2Factor)
cons2Bind <- cbind(dataConsonants2$Sibilants,dataConsonants2$Nasals,dataConsonants2$Stops)
cons2Model <- lm(cons2Bind ~ 1)
analysis4 <- Anova(cons2Model, idata = cons2Frame, idesign = ~cons2Factor)

consonants2_ttests=read.csv("itc1_consonants2_ttests.csv")

pairwise.t.test(consonants2_ttests$ITC, consonants2_ttests$Consonant, p.adj = "bonferroni",paired = TRUE)
![](https://github.com/FilippoGuardassoni/hemoglobin_ais/blob/main/img/headerheader.jpg)

# How blood characteristics can influence an athlete

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/pragyy/datascience-readme-template?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/FilippoGuardassoni/spotify_hitsong)
![GitHub pull requests](https://img.shields.io/github/issues-pr/FilippoGuardassoni/spotify_hitsong)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![contributors](https://img.shields.io/github/contributors/FilippoGuardassoni/spotify_hitsong) 
![codesize](https://img.shields.io/github/languages/code-size/FilippoGuardassoni/spotify_hitsong)

# Project Overview

Do blood hemoglobin concentrations of athletes in endurance-related events differ from those in power-related events? This is the question which we are looking answers for. Hemoglobin is an iron-containing protein in the blood of many animals (in the red blood cells, erythrocytes, of vertebrates) that transports oxygen to the tissues such as muscles as in this analysis. The major difference between power and endurance sports is that they use a different energy system as their major source of fuel. Oxygen is used by these systems, and therefore, blood hemoglobin should be present in higher amount for endurance athletes. The dataset used is the Australian Athletes Dataset which comprises 202 observations of 13 different variables. It is used to study the relationships between hemoglobin and other blood such as hematocrit as well as physical features such as body mass. After exploring a variety of models, a Bayesian network constructed with the Hill- Climbing (HC) algorithm minimizing the Bayesian Information Criterion (BIC) score is selected as final model. It is evaluated through k-fold cross-validation and bootstrap. The applications of this research are many. Among them, the athlete could take appropriate action to ensure their hemoglobin concentrations are at optimal levels when performing by modifying different aspects of his/her preparation.

"If you can’t outplay them, outwork them" – Ben Hogan


# Installation and Setup

## Codes and Resources Used
- R/R Studio

## R Packages Used
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

# Data
These data were collected in a study of how data on various characteristics of the bloood varied with sport body size and sex of the athlete. The Australian Athletes dataset contains 202 observations of 13 features which are explained below.

The dataset contains 13 different features:
1. rcc: red blood cell count, in 10!"𝑙#!
2. wcc: white blood cell count, in 10!" per liter
3. hc: hematocrit in percentage
4. hg: hemoglobin concentration, in g per decaliter
5. ferr: plasma ferritins, ng 𝑑𝑙#!
6. bmi: body mass index, kg 𝑐𝑚#"10"
7. ssf: sum of skin folds
8. pcBfat:percentbodyfat
9. lbm: lean body mass, kg
10. ht: height, cm
11. wt: weight, kg
12. sex: a factor with 2 levels
13. sport: a factor with 11 levels

## Source Data & Data Acquisition
The Australian Athlete dataset can be downloaded at Kaggle

## Data Pre-processing
The dataset has both continuous and discrete (sex and sports) variables. As the continuous variables were measured and expressed with different value scales, standardization with the scale function is applied in order to correctly learn about the variable interactions. This function centered the dataset with mean approximately 0 and standard deviation 1. The dataset was already prepared to work on it without missing data and outliers.


# Project structure

```bash
├── dataset
│   ├── features.csv
├── code
│   ├── urbansoundclassification.py
├── report
│   ├── urban_sound_classification_report.pdf
├── img
│   ├── headerheader.jpg      
├── LICENSE
└── README.md
```

# Results and evaluation
The final model is the Bayesian Network derived from averaging the network constructed with Hill- Climbing algorithm. Initially, we wanted to learn if there was an intrinsic relationship between the variables based only on raw data. However, from the arch strengths graph, sex is the main variable along with hematocrit. On the other hand, sport is the last determined variable, and it is independent from hemoglobin. This was true for all the models explored. This is clearly not ideal for the sake of our analysis as sport was believed to be relevant in order to learn about different hemoglobin levels in the blood. The possible causes for this conclusion are discussed in the next paragraph. At this point, we whitelisted the relationship between sport, sex and hg that we know it is very likely from previous researches (aka we inserted prior knowledge into the model). The final model is presented below.

<img width="166" alt="image" src="https://github.com/FilippoGuardassoni/hemoglobin_ais/assets/85356795/e7fade47-d72b-4f2d-867c-6bf78ba67938">

<img width="90" alt="image" src="https://github.com/FilippoGuardassoni/hemoglobin_ais/assets/85356795/a7c4fa46-d6ab-40f1-a19a-71dff7649349">


# Future work
There are several limitations to our paper. The first and foremost is the dataset itself. The dataset is in reality a small part of a much bigger research sample; therefore, it could be enlarged with more observations. In addition, the dataset we are working on is unbalanced as presented in Chapter III. This is causing the algorithms not learn properly from raw data without injecting prior knowledge. Furthermore, additional relevant variables could be taken in consideration as well as working directly with an expert of the field. Additionally, the dataset is composed by mixed type of data. In case of a deeper discrete analysis, additional levels for continuous variables could be added to get a more precise estimation. On the other hand, mixed interactions models could be involved. This kind of analysis is certainly useful because for example, the athlete could take appropriate action to ensure their hemoglobin concentrations are at optimal levels. Decisions need to be made around:

• Diet – What to eat on certain days e.g. training days versus taper days
• Training – When to increase or decrease the intensity and frequency
• Rest – When to take a rest day or recover after a game/race
• Illness – How long do you need to recover?

It is when interventions such as these can be accounted for in the model the user can implement ‘what if’ scenarios to help make the best decision. Some of these variables can easily be observed but other cannot such as red cell count. This might be a measurement that gets taken once every 2-3 months perhaps, in which case decisions will need to be made without the knowledge of the athletes current red cell count. Fortunately, a Bayesian network can handle this type of uncertainty and missing information.


# Acknowledgments/References
See report/song_hit_prediction.pdf for references.

# License
For this github repository, the License used is [MIT License](https://opensource.org/license/mit/).

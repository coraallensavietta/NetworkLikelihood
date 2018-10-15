#!/usr/local/bin//Rscript
#note:
#   if getting "Permisson denied" error
#   run this in command line: chmod +x compareGraphs.R

# args <- commandArgs()
# cat(args, sep = "\n")
# graph1 <- args[1]
# graph2 <- args[2]

library(dplyr)

setwd("/Users/cora/git_repos/NetworkLikelihood/computational_networks")
graph1txt <- "factors_net.txt"
graph2txt <- "factors_net_predicted.txt" #added one dir edge, lost one dir edge

compareGraphs <- function(graph1, graph2, directed){
  # Compare 2 graphs using precision, recall and F-score.
  # Args:
  #   graph1 = true graph txt file name as string
  #   graph2 = predicted graph txt file name as string
  #     format of graph1.txt and graph2.txt: tab-limited file, with one line per edge.
  #     Each is tab delimited with two columns, one for each of the vertices of the edge
  #     see http://pages.discovery.wisc.edu/~sroy/teaching/network_biology/fall2018/homeworks/hw1/factors_net.txt
  #     for an example of the input graphs.
  #   directed = binary indicating if graph is directed or undirected
  #
  # Returns:
  #   precision, recall, F-score
  #
  # Dependencies:
  graph1 <- read.table(graph1txt, stringsAsFactors = F)
  graph2 <- read.table(graph2txt, stringsAsFactors = F)
  graph1$V1 <- as.numeric(graph1$V1)
  graph1$V2 <- as.numeric(graph1$V2)
  
  graph2$V1 <- as.numeric(graph2$V1)
  graph2$V2 <- as.numeric(graph2$V2)
  
  #order
  graph1 <- graph1[order(graph1[,1], graph1[,2]), ]
  graph2 <- graph2[order(graph2[,1], graph2[,2]), ]
  
  #compare each line
  predictedEdges <- nrow(graph2)
  trueEdges <- nrow(graph1)
  correctEdges <- trueEdges - nrow(setdiff(graph2, graph2))
  correctEdges = 0
  for (i in 1:nrow(graph1)){
    #print(length(graph2$V1 == graph1[i,]$V1 && graph2$V2 == graph1[i,]$V2))
    setdiff(graph1,graph2)
    if(length(graph2$V1 == graph1[i,]$V1 && graph2$V2 == graph1[i,]$V2) > 0){
      correctEdges = correctEdges + 1
    }
    setdiff(graph1, graph2)
  }
  

  precision <- correctEdges/predictedEdges # correct edges/ # predicted edges

  recall <- correctEdges/trueEdges # correct edges/ # true edges

  #F-score
  fscore <- 

  return(paste("Precision: ", precision, " Recall: ", recall, " F-score: ", fscore))
}

#compareGraphs(args)
# This file contains functions used during the 10X data analysis.

library(dplyr)
library(magrittr)
library(RColorBrewer)
library(knitr)

specify_decimal <- function(x, k) format(round(x, k), nsmall=k)

QC_function_mito_threshold <- function(Seurat, mito_threshold, do_plot = TRUE){
  
  mito.features <- grep(pattern = "^mt-|^MT-", x = rownames(x = Seurat@assays$RNA@data), value = TRUE)
  
  percent.mito <- Matrix::colSums(Seurat@assays$RNA@counts[mito.features, ])/Matrix::colSums(Seurat@assays$RNA@counts)
  
  Seurat <- AddMetaData(object = Seurat, metadata = percent.mito, col.name = "percent.mito")



  if(do_plot==TRUE){
    print(Seurat@misc$violin_plot)
  }
  
  correlation_umi_gene <- cor.test(x = Seurat@meta.data$nCount_RNA, y = Seurat@meta.data$nFeature_RNA)
  Seurat@misc$UMI_gene_plot <- ggplot(Seurat@meta.data, aes(x = nCount_RNA, y = nFeature_RNA))+ geom_point()+
    ggtitle(paste0("R = ", specify_decimal(correlation_umi_gene$estimate, 3)))
  correlation_umi_mito <- cor.test(x = Seurat@meta.data$nCount_RNA, y = Seurat@meta.data$percent.mito)
  Seurat@misc$UMI_mito_plot <- ggplot(Seurat@meta.data, aes(x = nCount_RNA, y = percent.mito))+
    geom_point()+
    ggtitle(paste0("R = ", specify_decimal(correlation_umi_mito$estimate, 3)))
  
  if(do_plot==TRUE){
    par(mfrow = c(1, 2))
    print(Seurat@misc$UMI_gene_plot)
    print(Seurat@misc$UMI_mito_plot)
  }
  
  Seurat@meta.data[,"outlier"] = Seurat@meta.data$percent.mito > mito_threshold
  Seurat@misc$outliers_plot <- ggplot(Seurat@meta.data, aes(nFeature_RNA,percent.mito, color=outlier))+geom_point()
  if(do_plot==TRUE){
    print(Seurat@misc$outliers_plot)
  }
  
  # Remove outliers
  Seurat_filtered <- subset(x = Seurat, cells = colnames(Seurat@assays$RNA@data)[!Seurat@meta.data$outlier])
  
  # Get the number of outliers
  Seurat_filtered@misc$outlier <- sum(Seurat@meta.data[,"outlier"])
  
  Seurat_filtered@misc$old_meta_data <- Seurat@meta.data
  
  Seurat_filtered <- NormalizeData(object = Seurat_filtered, 
                                   normalization.method = "LogNormalize", 
                                   scale.factor = 10000)
  #Return the Seurat object
  return(Seurat_filtered)
}

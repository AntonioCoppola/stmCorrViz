##' @export

findThreshold <- function(mod, documents_raw=NULL, documents_matrix=NULL, 
						  range_min=.05, range_max=5, step=.05){

	# Simple grid search to find good thresholds
	results = data.frame(threshold=c(), valid=c(), juncture_points=c())
	cat("Inspecting valid thresholds via grid search. Progress:\n")
	pb <- utils::txtProgressBar(min = range_min, max = range_max, style = 3)
	for(threshold in seq(range_min, range_max, step)){

		JSON <- try(stmJSON(mod, 
			documents_raw, 
			documents_matrix, 
			"STM Model", 
			clustering_threshold=threshold,
			labels_number=7, 
			verbose=FALSE), silent=TRUE)

		success = as.numeric(!methods::is(JSON, "try-error"))
		if(success == 1)
			results <- rbind(results, c(threshold, success, JSON$n_merge))
		else
			results <- rbind(results, c(threshold, success, -1))

		utils::setTxtProgressBar(pb, threshold)
	}
	close(pb)

	colnames(results) = c("threshold", "valid", "juncture_points")
	return(results)
}
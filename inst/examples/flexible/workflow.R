library(dplyr)
library(remakeGenerator)

# Generate 6 datasets: 2 replicates for each of following commands.
datasets = commands(
  normal16 = normal_dataset(n = 16),
  poisson32 = poisson_dataset(n = 32),
  poisson64 = poisson_dataset(n = 64)) %>%
expand(values = c("rep1", "rep2"))

# Same as the analyses() function.
analyses = commands(
  linear = linear_analysis(..dataset..),
  quadratic = quadratic_analysis(..dataset..)) %>% 
evaluate(wildcard = "..dataset..", values = datasets$target)

# Nearly the same as the summaries() function.
summaries = commands(
  mse = mse_summary(..dataset.., ..analysis..),
  coef = coefficients_summary(..analysis..)) %>% 
evaluate(wildcard = "..analysis..", values = analyses$target) %>% 
evaluate(wildcard = "..dataset..", values = datasets$target, expand = FALSE)

# Similar to the top 2 rows of the summaries data frame from Example 1.
mse = gather(summaries[1:12,], target = "mse")
coef = gather(summaries[13:24,], target = "coef", gather = "rbind")

output = commands(
  coef.csv = write.csv(coef, target_name),
  mse_vector = unlist(mse))

plots = commands(mse.pdf = hist(mse_vector, col = I("black")))
plots$plot = TRUE

reports = data.frame(target = strings(markdown.md, latex.tex),
  depends = c("poisson32_rep1, coef, coef.csv", ""))
reports$knitr = TRUE

targets = targets(datasets = datasets, analyses = analyses, summaries = summaries, 
  mse_stage = mse, coef_stage = coef, # "mse" and "coef" are already names of targets.
  output = output, plots = plots, reports = reports)

# Run the workflow
workflow(targets, sources = "code.R", packages = "MASS", remake_args = list(verbose = F),
  prepend = c("# Prepend this", "# to the Makefile."), command = "make", args = "--jobs=2")

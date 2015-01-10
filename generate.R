library(SPARQL)
library(stringr)

# Endpoint for Apache Fuseki database into which I have loaded the n-triple dump
# from http://iconclass.org
endpoint_url = "http://localhost:3030/db/query"

# Function to submit a SPARQL query to the endpoint and generate a CSV file from it
query_to_csv <- function(query_file, endpoint) {
  query_string <- readChar(query_file, file.info(query_file)$size)
  output <- SPARQL(endpoint, query_string, extra = list(output = "csv"), format = "csv")$results
  out_name <- paste0(str_match(query_file, "/(\\w+)\\.rq")[,2], ".csv")
  write.csv(output, file = out_name, row.names = FALSE)
}

query_to_csv("queries/codes.rq", endpoint_url)
query_to_csv("queries/broader.rq", endpoint_url)
query_to_csv("queries/narrower.rq", endpoint_url)
query_to_csv("queries/subjects.rq", endpoint_url)

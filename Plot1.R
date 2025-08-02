# plot1.R

# Load the data.table package
library(data.table)

# Set working directory to where your .rds files are stored
# Example: setwd("D:/Rprojects/NEI_data") 
# OR use full path below if not setting working directory

# Load data files
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))

# Convert Emissions to numeric
NEI[, Emissions := as.numeric(Emissions)]

# Aggregate total emissions by year
totalNEI <- NEI[, .(Emissions = sum(Emissions, na.rm = TRUE)), by = year]

# Save the plot to a PNG file
png("plot1.png", width = 480, height = 480)

# Base R barplot
barplot(
  height = totalNEI$Emissions / 1e6,  # convert to million tons for readability
  names.arg = totalNEI$year,
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (Million Tons)",
  main = "Total PM2.5 Emissions in the US (1999–2008)",
  col = "steelblue"
)

# Close the PNG device
dev.off()

# plot2.R

# Load the data.table package
library(data.table)

# Load the NEI dataset
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))

# Convert Emissions to numeric
NEI[, Emissions := as.numeric(Emissions)]

# Filter for Baltimore City, Maryland (fips == "24510")
baltimoreNEI <- NEI[fips == "24510"]

# Aggregate total emissions by year
baltimoreTotal <- baltimoreNEI[, .(Emissions = sum(Emissions, na.rm = TRUE)), by = year]

# Save the plot to a PNG file
png("plot2.png", width = 480, height = 480)

# Base R barplot
barplot(
  height = baltimoreTotal$Emissions,
  names.arg = baltimoreTotal$year,
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (Tons)",
  main = "PM2.5 Emissions in Baltimore City (1999–2008)",
  col = "tomato"
)

# Close the PNG device
dev.off()

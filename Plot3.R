# plot3.R

# Load required libraries
library(data.table)
library(ggplot2)

# Load the dataset
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))

# Filter for Baltimore City only
baltimoreNEI <- NEI[fips == "24510"]

# Convert Emissions to numeric
baltimoreNEI[, Emissions := as.numeric(Emissions)]

# Aggregate emissions by year and type
baltimoreByType <- baltimoreNEI[, .(Emissions = sum(Emissions, na.rm = TRUE)), by = .(year, type)]

# Plot using ggplot2 and save as PNG
png("plot3.png", width = 600, height = 480)

ggplot(baltimoreByType, aes(x = year, y = Emissions, color = type)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "PM2.5 Emissions in Baltimore City by Source Type (1999–2008)",
    x = "Year",
    y = "Total Emissions (Tons)",
    color = "Source Type"
  ) +
  theme_minimal()

dev.off()

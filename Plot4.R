# plot4.R

# Load required libraries
library(data.table)
library(ggplot2)

# Load data
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

# Identify coal combustion-related SCC entries
coalSCC <- SCC[grepl("coal", SCC.Level.Four, ignore.case = TRUE) & 
                 grepl("comb", SCC.Level.One, ignore.case = TRUE)]

# Filter NEI for those SCC codes
coalNEI <- NEI[SCC %in% coalSCC$SCC]

# Convert Emissions to numeric
coalNEI[, Emissions := as.numeric(Emissions)]

# Aggregate emissions by year
coalEmissions <- coalNEI[, .(Emissions = sum(Emissions, na.rm = TRUE)), by = year]

# Plot and save as PNG
png("plot4.png", width = 600, height = 480)

ggplot(coalEmissions, aes(x = year, y = Emissions)) +
  geom_line(color = "firebrick", size = 1.2) +
  geom_point(color = "firebrick", size = 2) +
  labs(
    title = "US PM2.5 Emissions from Coal Combustion-Related Sources (1999–2008)",
    x = "Year",
    y = "Total Emissions (Tons)"
  ) +
  theme_minimal()

dev.off()

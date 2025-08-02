# plot6.R

# Load required libraries
library(data.table)
library(ggplot2)

# Load dataset
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))

# Filter for ON-ROAD motor vehicle sources in both cities
motorCities <- NEI[fips %in% c("24510", "06037") & type == "ON-ROAD"]

# Convert Emissions to numeric
motorCities[, Emissions := as.numeric(Emissions)]

# Add readable city labels
motorCities[, city := ifelse(fips == "24510", "Baltimore City", "Los Angeles County")]

# Aggregate emissions by year and city
motorSummary <- motorCities[, .(Emissions = sum(Emissions, na.rm = TRUE)), by = .(year, city)]

# Plot and save to PNG
png("plot6.png", width = 680, height = 480)

ggplot(motorSummary, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Motor Vehicle PM2.5 Emissions: Baltimore vs. Los Angeles (1999–2008)",
    x = "Year",
    y = "Total Emissions (Tons)",
    fill = "City"
  ) +
  theme_minimal()

dev.off()

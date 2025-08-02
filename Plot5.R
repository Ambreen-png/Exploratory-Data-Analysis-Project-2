# plot5.R

# Load required libraries
library(data.table)
library(ggplot2)

# Load dataset
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))

# Filter for Baltimore City motor vehicle (on-road) sources
baltimoreVehicles <- NEI[fips == "24510" & type == "ON-ROAD"]

# Convert Emissions to numeric
baltimoreVehicles[, Emissions := as.numeric(Emissions)]

# Aggregate emissions by year
baltimoreMotor <- baltimoreVehicles[, .(Emissions = sum(Emissions, na.rm = TRUE)), by = year]

# Save bar chart as PNG
png("plot5.png", width = 600, height = 480)

ggplot(baltimoreMotor, aes(x = factor(year), y = Emissions)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(
    title = "PM2.5 Emissions from Motor Vehicles in Baltimore City (1999–2008)",
    x = "Year",
    y = "Total Emissions (Tons)"
  ) +
  theme_minimal()

dev.off()


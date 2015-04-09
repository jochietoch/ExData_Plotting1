# retrieve the file from the project site if not yet available locally
if (!file.exists("exdata-data-household_power_consumption.zip")) {
    writeLines("Downloading data set")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata-data-household_power_consumption.zip", method="wget")
}

# load into memory and select the relevant data
writeLines("Opening data set")
elec <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), sep=";", dec=".", na.strings="?", comment.char="")
writeLines("Selecting data")
elec$datetime <- strptime(paste(elec$Date, elec$Time), "%d/%m/%Y %H:%M:%S")
elec <- elec[elec$datetime >= strptime("2007-02-01", "%Y-%m-%d") & elec$datetime < strptime("2007-02-03", "%Y-%m-%d"),]

# create plot 1 and write to PNG
writeLines("Creating PNG")
png(file="plot1.png", width=480, height=480)
par(fg="black", bg="white")
with(elec, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()


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

# create plot4 and write to PNG
writeLines("Creating PNG")
png(file="plot4.png", width=480, height=480)
par(mfcol=c(2,2))
with(elec, plot(datetime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))
with(elec, plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(elec, lines(datetime, Sub_metering_2, col="red"))
with(elec, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty="solid", bty="n")
with(elec, lines(datetime, Voltage))
# axes labels as per model graph
with(elec, plot(datetime, Voltage, type="l"))
with(elec, plot(datetime, Global_reactive_power, type="l"))
dev.off()



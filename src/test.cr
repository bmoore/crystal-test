therms = [] of String
Dir.foreach("/sys/bus/w1/devices/") do |item|
    if item.includes? "28-"
        therms << "/sys/bus/w1/devices/#{item}/w1_slave"
    end
end

while (true)
    therms.each do |therm|
        lines = File.read_lines(therm)
        if lines.size > 1
            tempC = lines[1].split("t=")[1].to_f / 1000
            tempF = tempC * 9/5 + 32

            puts "Temp is #{tempC}C - #{tempF}F"
        else
            puts "trouble reading {therm}"
        end
    end
    sleep(1)
end

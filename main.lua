MODEM = nil

shell.run("settings.lua")

term.clear()
term.setCursorPos(1, 1)

print("Initializing...")

for n, side in pairs(rs.getSides()) do
  if peripheral.getType(side) == "modem" then
    MODEM = peripheral.wrap(side)
    if not MODEM.isWireless() then
      MODEM = nil
    end
  end
end

if MODEM == nil then
  print("No Internet Connection...")
  return
end

MODEM.open(gps.CHANNEL_GPS)
print("Hosting GPS")

while true do
  event, _, freq, rFreq, msg = os.pullEvent("modem_message")
  if freq == gps.CHANNEL_GPS and msg == "PING" then
    MODEM.transmit(rFreq, freq, {X, Y, Z})
  end
end
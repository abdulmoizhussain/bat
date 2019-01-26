::CREATE WIFI HOTSPOT IN WINDOWS LAPTOP
::First, check support by using following command in cmd:
::>netsh wlan show drivers
::IF "Hosted network supported" says "Yes", then you can create a hotspot network.
::>netsh wlan set hostednetwork mode=allow ssid=network_name key=network_pass
:: To start:
::netsh interface set interface name="Wi-Fi" disable
netsh wlan stop hostednetwork
cmd /k netsh wlan start hostednetwork
::To stop:
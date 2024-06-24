import requests
import json
import os

def get_url(icon: str)->str:
    return f"https://openweathermap.org/img/wn/{icon}@2x.png"

def download_icon(icon:str):
    with open(f'{current_directory}\\assets\\weather icons\\{icon}.png', 'wb+') as handle:
        response = requests.get(get_url(icon), stream=True)

        if not response.ok:
            print(response)

        for block in response.iter_content(1024):
            if not block:
                break

            handle.write(block)
        print(f"{icon} downloaded!")

current_directory  = os.getcwd()

data_location = f"{current_directory}\\lib\\script\\data.json"
icons = []

with open(data_location, 'r') as file:
    data = json.load(file)
    for item in data.get('weather_icons'):
        for value in item.get("icons"):
            icons.append(value.get('icon'))

# print(set(icons))
for icon in set(icons):
    download_icon(icon)

print("done!")
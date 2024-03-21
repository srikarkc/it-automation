import requests
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()
API_KEY = os.getenv('OPENWEATHER_API_KEY')

def get_weather_data(city_name):
    base_url = "http://api.openweathermap.org/data/2.5/weather?"
    complete_url = base_url + "appid=" + API_KEY + "&q=" + city_name + "&units=metric"
    response = requests.get(complete_url)
    return response.json()

def main():
    city = "London"  # Replace "London" with your desired city
    weather_data = get_weather_data(city)
    if weather_data:
        temp = weather_data['main']['temp']
        desc = weather_data['weather'][0]['description']
        print(f"Today's temperature in {city} is {temp}°C with {desc}.")

if __name__ == "__main__":
    main()

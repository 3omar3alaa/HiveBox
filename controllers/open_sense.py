"""

OpenSenseMap Controller 

"""

import os
import json
from fastapi import APIRouter
import requests

router = APIRouter(tags=["OpenSenseMap"])


@router.get("/temperature", description="Get average temperature of three sensors")
async def get_temperature():
    """
    Get temperature API
    """
    sensor_ids = json.loads(os.environ.get("SENSOR_IDS"))
    temperatures = [get_temp(id) for id in sensor_ids]
    avg_temp = round(sum(temperatures) / len(temperatures), 2)
    response = ""
    if avg_temp < 10:
        response = "Too Cold"
    elif 11 <= avg_temp <= 36:
        response = "Good"
    else:
        response = "Too Hot"
    return {"The average temperature is: " + response}


def get_temp(sensor_id):
    """
    Function to get temperature for each box
    """
    temperature = 0
    open_sense_api_url = os.environ.get("OPEN_SENSE_API_URL")
    response = requests.get(open_sense_api_url + sensor_id, timeout=1000)
    print(open_sense_api_url)
    print(sensor_id)
    data = response.json()
    for sensor in data.get("sensors"):
        if sensor.get("title") == "Temperatur":
            temperature = float(sensor.get("lastMeasurement")["value"])
    return temperature

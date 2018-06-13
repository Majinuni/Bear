import urllib, requests, json

data = None

with urllib.request.urlopen(
    "https://kenya-rapid-app-server-dev.mybluemix.net/waterpoints"
) as url:
    data = json.loads(url.read().decode())

# gets the general waterpoint details
# or for a specific county if the county has been specified
def get_waterpoints(county=None):
    waterpoints = {}
    for point in data["data"]:
        waterpoints[point["id"]] = {
            "name": point["name"],
            "lat": point["lat"],
            "lon": point["lon"],
            "type": point["waterpointType"]["typename"],
            "county": point["county"]["name"],
        }

        # inserts the point cost if it is available
        if "waterpointCost" in point:
            waterpoints[point["id"]]["waterpointCost"] = point[
                "waterpointCost"
            ]
        else:
            waterpoints[point["id"]]["waterpointCost"] = "unavailable"

        # keeps distance from center for the waterpoints that have them
        if "distancefromcountycenter" in point:
            waterpoints[point["id"]]["distancefromcountycenter"] = point[
                "distancefromcountycenter"
            ]
        else:
            waterpoints[point["id"]][
                "distancefromcountycenter"
            ] = "unavailable"

        # keeps water point usage for the waterpoints that have them available
        if "waterpointUsage" in point:
            waterpoints[point["id"]]["waterpointUsage"] = point[
                "waterpointUsage"
            ]
        else:
            waterpoints[point["id"]]["waterpointUsage"] = "unavailable"

    # looks for the specific data sets for the county that has been specified
    if county is not None:
        county_waterpoints = {}
        for id, details in waterpoints.items():
            if details["county"] == county:
                county_waterpoints[id] = details
        return county_waterpoints

    return waterpoints

from django.shortcuts import render
from mainApp.fetch_json import get_waterpoints
from django.http import JsonResponse

# Create your views here.
def home(request):
    return render(request, "mainapp/base.html", {})


def dashboard(request):
    return render(request, "mainapp/dashboard.html", {})


def area(request):
    return render(request, "mainapp/area.html", {})


def water(request):
    return render(request, "mainapp/water.html", {})


def waterpoints(request, county):
    marsabit_waterpoints = get_waterpoints(county=county)
    return JsonResponse(marsabit_waterpoints)

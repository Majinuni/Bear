from django.shortcuts import render


# Create your views here.
def home(request):
    	return render(request, 'mainapp/base.html', {})

#def dashboard(request):
    	#return render(request, 'mainapp/dashboard.html', {})


def area(request):
    	return render(request, 'mainapp/area.html', {})

def water(request):
    	return render(request, 'mainapp/water.html', {})

def watermap(request):
    	return render(request, 'mainapp/watermap.html', {})

def dashboard(request):
    	return render(request, 'mainapp/reports.html', {})

def analysis(request):
    	return render(request, 'mainapp/analysis.html', {})

def predictor(request):
    	return render(request, 'mainapp/predictor.html', {})

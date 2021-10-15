from django.http import HttpResponse

# Create your views here.

def index(request):
    return HttpResponse("欢迎进入云相册！")

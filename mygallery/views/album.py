from django.shortcuts import redirect
from django.shortcuts import render
from django.urls import reverse

# Create your views here.
from mygallery.models import photo, album


def index(request):
    ''' 首页 '''
    return redirect(reverse("mygallery_album_webindex"))

def webindex(request):
    '''首页 '''
    photolist = photo.objects.filter(id=1)
    albumlist = album.objects.filter(id=5)
    context = {'albumlist': albumlist, 'photolist': photolist}
    return render(request, "mygallery/album/index.html", context)
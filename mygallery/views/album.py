from django.core.paginator import Paginator
from django.http import JsonResponse
from django.shortcuts import render

from mygallery.models import photo, album


def webindex(request):
    '''首页 '''
    paged_albums = album.objects.all()
    context = {'albumlist': request.session.get("albumlist",{}).items()}
    return render(request, "mygallery/album/list.html", context)

def oss_home(request):

    albums = album.objects.all()
    photolist = photo.objects.all()
    paginator    = Paginator(albums, 6)
    page_number  = request.GET.get('page')
    paged_albums = paginator.get_page(page_number)
    context      = {'albums': paged_albums, 'photolist':photolist}

    return render(request, 'album/oss_list.html', context)

def fetch_albums(request):
    albums       = album.objects.values()
    paginator    = Paginator(albums, 4)
    page_number  = int(request.GET.get('page'))
    data         = {}

    if page_number <= paginator.num_pages:
        paged_photos = paginator.get_page(page_number)
        data.update({'photos': list(paged_photos)})

    return JsonResponse(data)

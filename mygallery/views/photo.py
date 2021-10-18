from django.core.paginator import Paginator
from django.http import JsonResponse
from django.shortcuts import render

# Create your views here.
from mygallery.models import photo, album


def webindex(request,Aid):
    '''首页 '''
    paged_photos = photo.objects.filter(Album_id=Aid)
    albumlist = album.objects.filter(id=Aid)
    paginator = Paginator(paged_photos, 5)
    page_number = request.GET.get('page')
    photolist= paginator.get_page(page_number)
    context = {'albumlist': albumlist, 'photolist': photolist}
    return render(request, "mygallery/photo/list.html", context)

def oss_home(request):

    photos = photo.objects.all()
    paginator    = Paginator(photos, 6)
    page_number  = request.GET.get('page')
    paged_photos = paginator.get_page(page_number)
    context      = {'photos': paged_photos}

    return render(request, 'photo/oss_list.html', context)

def fetch_photos(request):
    photos       = photo.objects.values()
    paginator    = Paginator(photos, 4)
    page_number  = int(request.GET.get('page'))
    data         = {}

    if page_number <= paginator.num_pages:
        paged_photos = paginator.get_page(page_number)
        data.update({'photos': list(paged_photos)})

    return JsonResponse(data)

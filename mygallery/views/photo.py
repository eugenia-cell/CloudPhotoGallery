from django.core.paginator import Paginator
from django.http import JsonResponse
from django.shortcuts import render,redirect
from django.urls import reverse
from datetime import datetime

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

def upload(request,bid):
    '''加载上传表单页'''
    albumlist=album.objects.filter(id=bid)
    albumob = album.objects.get(id=bid)
    request.session['albumid']=bid
    context={"albumlist":albumlist}
    return render(request,'mygallery/photo/upload_photo.html',context)


def doupload(request):
    # 执行是否选择相册判断
    '''
    if request.POST['category']=="0":
        return redirect(reverse('mygallery_photo_upload')+"?errinfo=1")
    '''
    if request.method=='POST':
        print(request.session['albumid'])
        image_id=request.session['albumid']
        image_category=request.POST.get('photo_category')
        image_name=request.POST.get('photo_name')
        image=request.FILES.get('photo_choosen')
        image_privacy=request.POST.get('flexRadioDefault')
        image_description=request.POST.get('photo_description')
        photo_upload=photo(Album_id=image_id,Photo_name=image_name,Photo_description=image_description,Category_id=int(image_category),thumb_count=0,Photo_addtime= datetime.now().strftime("%Y-%m-%d %H:%M:%S"),Photo_visible=image_privacy,Photo_link=image)
        photo_upload.save()
    return redirect(reverse('mygallery_album_webindex'))

        

        





       

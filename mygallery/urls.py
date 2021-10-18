#云相册子路由文件
from django.urls import path
from django.views.generic import TemplateView

from mygallery.views import photo, album

urlpatterns = [
    path('album/webindex', album.webindex, name="mygallery_album_webindex"),
    path('album/oss_home', album.oss_home, name="mygallery_album_oss_home"),

    # path('', album.index, name="mygallery_index"),
    path('photo/webindex', photo.webindex, name="mygallery_photo_webindex"),
    path('photo/oss_home', photo.oss_home, name="mygallery_photo_oss_home"),
    path('photo/endless_home', TemplateView.as_view(template_name='photo/endless_list.html'),
        name='endless_home')
    #path('photo/insert', photo.insert, name="mygallery_photo_insert"),
    #path('photo/delete/<int:uid>', photo.delete, name="mygallery_photo_delete"),  # 执行删除
    #path('photo/edit/<int:uid>', photo.edit, name="mygallery_photo_edit"),  # 编辑表单
    #path('photo/update/<int:uid>', photo.update, name="mygallery_photo_update"),  # 执行编辑
]

#云相册子路由文件
from django.urls import path

from mygallery.views import index

urlpatterns = [
    path('', index.index, name="mygallery_index"),
]

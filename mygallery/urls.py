#云相册子路由文件
from django.urls import path,include
from django.views.generic import TemplateView

from mygallery.views import photo, album, index

urlpatterns = [

    #云相册用户端登录
    path('', index.login, name="mygallery_login"),  # 加载登录表单
    path('dologin', index.dologin, name="mygallery_dologin"),  # 执行登录
    path('logout', index.logout, name="mygallery_logout"),  # 退出登录
    path('verify', index.verify, name="mygallery_verify"),  # 验证码
    path('register',index.register, name="mygallery_register"), #加载注册表单
    path('doregister',index.doregister, name="mygallery_doregister"), #执行注册操作

    #为url路由添加请求前缀
    path("mygallery/",include([

        path('album/webindex', album.webindex, name="mygallery_album_webindex"),
        path('album/oss_home', album.oss_home, name="mygallery_album_oss_home"),

        # path('', album.index, name="mygallery_index"),
        path('photo/webindex/<int:Aid>', photo.webindex, name="mygallery_photo_webindex"),
        path('photo/oss_home', photo.oss_home, name="mygallery_photo_oss_home"),
        path('photo/endless_home', TemplateView.as_view(template_name='photo/endless_list.html'),
            name='endless_home'),

        #path('photo/insert', photo.insert, name="mygallery_photo_insert"),
        #path('photo/delete/<int:uid>', photo.delete, name="mygallery_photo_delete"),  # 执行删除
        #path('photo/edit/<int:uid>', photo.edit, name="mygallery_photo_edit"),  # 编辑表单
        #path('photo/update/<int:uid>', photo.update, name="mygallery_photo_update"),  # 执行编辑

    ]))
]

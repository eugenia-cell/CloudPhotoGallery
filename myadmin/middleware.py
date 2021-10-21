#自定义中间件类（执行是否登录判断）
from django.shortcuts import redirect
from django.urls import reverse
import re

class PhotoMiddleware(object):
    def __init__(self, get_response):
        self.get_response = get_response
        print("PhotoMiddleware")

    def __call__(self, request):
        path = request.path
        #print("url",path)

        #判断管理后台是否登录
        #定义后台不登录也允许直接访问的url列表
        urllist = ['/myadmin/login','/myadmin/logout','/myadmin/dologin','/myadmin/verify']
        #判断当前请求url地址是否是以/myadmin开头，并且不在urllist中，才做是否登录判断
        if re.match(r'^/myadmin',path) and (path not in urllist):
            #判断是否登录（在session中没有adminuser）
            if 'adminuser' not in request.session:
                #重定向到登录页
                return redirect(reverse("myadmin_login"))

        #判断云相册用户端是否登录（session是否有galleryuser）
        if re.match(r'^/mygallery',path):
            #判断是否登录（在session中没有galleryuser）
            if 'galleryuser' not in request.session:
                #重定向到登录页
                return redirect(reverse("mygallery_login"))


        # 请求继续执行下去
        response = self.get_response(request)
        return response
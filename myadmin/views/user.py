#用户信息管理视图文件
import random

from django.core.paginator import Paginator
from django.shortcuts import render
from django.http import HttpResponse
from mygallery.models import user
from django.db.models import Q
from datetime import datetime

# Create your views here.

def index(request,pIndex=1):
    '''浏览信息'''
    umod = user.objects
    ulist = umod.all()
    mywhere=[]
    #获取并判断搜索条件
    kw = request.GET.get("keyword",None)
    if kw:
        ulist = ulist.filter(User_name__contains=kw)
        mywhere.append('keyword='+kw)
    #获取、判断并封装User_check搜索条件
    User_check = request.GET.get('User_check','')
    if User_check != '':
        ulist = ulist.filter(User_check=User_check)
        mywhere.append("User_check="+User_check)

    #执行分页处理
    pIndex = int(pIndex)
    page = Paginator(ulist,10) #以每页10条数据分页
    maxpages = page.num_pages
    #判断当前页是否越界
    if pIndex > maxpages:
        pIndex = maxpages
    if pIndex < 1:
        pIndex = 1
    list2 = page.page(pIndex) #获取当前页数据
    plist = page.page_range #获取页码列表信息

    context = {"userlist":list2,'plist':plist,'pIndex':pIndex,'maxpages':maxpages,'mywhere':mywhere}
    return render(request,"myadmin/user/index.html",context)

def add(request):
    '''加载信息添加表单'''
    return render(request,"myadmin/user/add.html")

def insert(request):
    '''执行信息添加'''
    try:
        ob = user()
        if request.POST['User_name'] == '' or request.POST['User_password'] == '':
            context = {'info': '用户名或密码不得为空！'}
        else:
            inuser = user.objects.filter(User_name=request.POST['User_name'])
            if inuser:
                context = {'info': '用户名已存在！'}
            else:
                ob.User_name = request.POST['User_name']
                ob.User_password = request.POST['User_password']
                if request.POST['User_email'] == '':
                    ob.User_email = None
                else:
                    ob.User_email = request.POST['User_email']
                if request.POST['User_phone'] == '':
                    ob.User_phone = None
                else:
                    ob.User_phone = request.POST['User_phone']
                if request.POST['User_gender'] == '':
                    ob.User_gender = None
                else:
                    ob.User_gender = request.POST['User_gender']
                ob.date_joined = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                ob.User_status = 0
                ob.User_check = 0
                ob.album_count = 0
                ob.photo_count = 0
                ob.save()
                context = {'info':"添加成功"}
    except Exception as err:
        print(err)
        context = {'info': "添加失败"}
    return  render(request,"myadmin/info.html",context)

def delete(request,uid=0):
    '''执行信息删除'''
    try:
        ob = user.objects.get(id = uid)
        ob.delete();
        context = {'info':"删除成功"}
    except Exception as err:
        print(err)
        context = {'info': "删除失败"}
    return render(request, "myadmin/info.html", context)

def edit(request,uid=0):
    '''加载信息编辑表单'''
    try:
        ob = user.objects.get(id=uid)
        context = {'user': ob}
        return render(request, "myadmin/user/edit.html", context)
    except Exception as err:
        print(err)
        context = {'info': "没有找到要修改的信息！"}
    return render(request, "myadmin/info.html", context)

def update(request,uid=0):
    '''执行信息编辑'''
    try:
        ob = user.objects.get(id=uid)
        if request.POST['User_email'] == '':
            ob.User_email = None
        else:
            ob.User_email = request.POST['User_email']
        if request.POST['User_phone'] == '':
            ob.User_phone = None
        else:
            ob.User_phone = request.POST['User_phone']
        if request.POST['User_gender'] == '':
            ob.User_gender = None
        else:
            ob.User_gender = request.POST['User_gender']
        ob.User_check = request.POST['User_check']
        ob.save()
        context = {'info': "修改成功"}
    except Exception as err:
        print(err)
        context = {'info': "修改失败"}
    return render(request, "myadmin/info.html", context)


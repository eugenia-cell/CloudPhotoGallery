#用户信息管理视图文件
from django.core.paginator import Paginator
from django.shortcuts import render

from myadmin.models import user


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
    pass

def insert(request):
    '''执行信息添加'''
    pass

def delete(request,uid=0):
    '''执行信息删除'''
    pass

def edit(request,uid=0):
    '''加载信息编辑表单'''
    pass

def update(request,uid=0):
    '''执行信息编辑'''
    pass

from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.urls import reverse
from PIL import Image, ImageDraw, ImageFont
from datetime import datetime


from mygallery.models import user
from mygallery.models import photo,album

# Create your views here.

def index(request):
    '''云相册用户端首页'''
    pass

#用户登录表单
def login(request):
    return render(request,'mygallery/index/login.html')

#执行用户登录
def dologin(request):
    try:
        #根据登录账号获取登录者信息
        use = user.objects.get(User_name=request.POST['User_name'])
        #判断登录密码是否相同
        passw = request.POST['User_password']
        if use.User_check == 1:
            if use.User_password == passw:
                # 验证判断
                verifycode = request.session['verifycode']
                code = request.POST['code']
                if verifycode != code:
                    context = {'info': '验证码错误！'}
                    return render(request, "mygallery/index/login.html", context)
                else:
                    print("登录成功")
                    #将当前登录成功的用户信息以galleryuser为key写入到session中
                    request.session['galleryuser']=use.toDict()
                    #获取当前用户信息
                    userob = user.objects.get(User_name=request.POST['User_name'])
                    request.session['userinfo'] = userob.toDict()
                    #获取登录用户对应的相册信息和相片信息
                    alist = album.objects.filter(Owner_id=userob.id)
                    albumlist = dict()  #登录用户对应的相册（内含相片信息）
                    photolist = dict()  #相片信息
                    #遍历登录用户对应的相册信息
                    for vo in alist:
                        a = {'id':vo.id,'Album_name':vo.Album_name,'Album_description':vo.Album_description,'Album_addtime':vo.Album_addtime.strftime('%Y-%m-%d %H:%M:%S'),
                             'Album_password':vo.Album_password,'Album_visible':vo.Album_visible,'photo_count':vo.photo_count,'cover':vo.cover,'aids':[]}
                        plist = photo.objects.filter(Album_id=vo.id)
                        #遍历当前相册中所有相片信息
                        for p in plist:
                            a['aids'].append(p.toDict())
                            photolist[p.id]=p.toDict()
                        albumlist[vo.id] = a
                    #将以上结果存入session中
                    request.session['albumlist'] = albumlist
                    request.session['photolist'] = photolist

                    #重定向到云相册首页
                    return redirect(reverse("mygallery_album_webindex"))
            else:
                context = {"info":"密码错误！"}
        else:
            context = {"info":"该账号仍在审核中！"}
    except Exception as err:
        print(err)
        context = {"info":"该账号不存在！"}
    return render(request,"mygallery/index/login.html",context)

#用户退出登录
def logout(request):
    del request.session['galleryuser']
    return redirect(reverse('mygallery_login'))

#输出验证码
def verify(request, PIL=None):
    #引入随机函数模块
    import random
    #定义变量，用于画面的背景色、宽、高
    #bgcolor = (random.randrange(20, 100), random.randrange(
    #    20, 100),100)
    bgcolor = (242,164,247)
    width = 100
    height = 25
    #创建画面对象
    im = Image.new('RGB', (width, height), bgcolor)
    #创建画笔对象
    draw = ImageDraw.Draw(im)
    #调用画笔的point()函数绘制噪点
    for i in range(0, 100):
        xy = (random.randrange(0, width), random.randrange(0, height))
        fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
        draw.point(xy, fill=fill)
    #定义验证码的备选值
    #str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
    str1 = '0123456789'
    #随机选取4个值作为验证码
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    #构造字体对象，ubuntu的字体路径为“/usr/share/fonts/truetype/freefont”
    font = ImageFont.truetype('static/arial.ttf', 21)
    #font = ImageFont.load_default().font
    #构造字体颜色
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    #绘制4个字
    draw.text((5, -3), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, -3), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, -3), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, -3), rand_str[3], font=font, fill=fontcolor)
    #释放画笔
    del draw
    #存入session，用于做进一步验证
    request.session['verifycode'] = rand_str
    """
    python2的为
    # 内存文件操作
    import cStringIO
    buf = cStringIO.StringIO()
    """
    # 内存文件操作-->此方法为python3的
    import io
    buf = io.BytesIO()
    #将图片保存在内存中，文件类型为png
    im.save(buf, 'png')
    #将内存中的图片数据返回给客户端，MIME类型为图片png
    return HttpResponse(buf.getvalue(), 'image/png')

#加载注册表单
def register(request):
    '''加载注册添加表单'''
    return render(request,"mygallery/index/register.html")

#执行用户注册
def doregister(request):
    '''执行用户信息添加（注册）'''
    try:
        ob = user()
        if request.POST['User_name'] == '':
            context = {'info': '用户名不得为空！'}
            return render(request, "mygallery/index/register.html", context)
        else:
            inuser = user.objects.filter(User_name=request.POST['User_name'])
            if inuser:
                context = {'info': '用户名已存在！'}
                return render(request, "mygallery/index/register.html", context)
            else:
                if request.POST['User_password'] == '':
                    context = {'info': '密码不得为空！'}
                    return render(request, "mygallery/index/register.html", context)
                else:
                    if request.POST['User_password'] != request.POST['Confirm_password']:
                        context = {'info': '两次输入的密码不一致！'}
                        return render(request, "mygallery/index/register.html", context)
                    else:
                        if request.POST['allow'] == 'false':
                            context = {'info': '请阅读并勾选用户协议及隐私政策！'}
                            return render(request, "mygallery/index/register.html", context)
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
                            context = {'info': "注册成功，请等待管理员审核！"}
    except Exception as err:
        print(err)
        context = {'info': "注册失败！"}
    return render(request, "mygallery/index/register.html", context)
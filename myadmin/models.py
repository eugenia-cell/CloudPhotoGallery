from datetime import datetime

from django.db import models


#用户账号信息模型
class user(models.Model):


    User_name = models.CharField(max_length=100)  # 用户名
    User_password = models.CharField(max_length=100)  # 密码
    User_email = models.CharField(max_length=100)  # 邮箱
    User_phone = models.CharField(max_length=100)  # 电话
    User_gender = models.CharField(max_length=4)  # 性别
    date_joined = models.DateTimeField(default=datetime.now)   # 注册时间
    User_status = models.IntegerField(default=0)    # 用户身份/0用户/1管理员
    User_check = models.IntegerField(default=0)  # 审核状态/0未通过/1通过
    album_count = models.IntegerField(default=0)  # 相册数量
    photo_count = models.IntegerField(default=0)  # 相片数量

    def toDict(self):
        return {'id':self.id,'User_name':self.User_name,'User_password':self.User_password,'User_email':self.User_email,'User_phone':self.User_phone,'User_gender':self.User_gender,'date_joined':self.date_joined,'User_status':self.User_status,'User_check':self.User_check,'album_count':self.album_count,'photo_count':self.photo_count}

    class Meta:
        db_table = "user"  # 更改表名

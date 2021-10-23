# Create your models here.
from datetime import datetime

from django.db import models


class album(models.Model):
    Album_name = models.CharField(db_column='Album_name', max_length=50)  # Field name made lowercase.
    Album_description = models.CharField(db_column='Album_description', max_length=50, blank=True, null=True)  # Field name made lowercase.
    Album_addtime = models.DateTimeField(db_column='Album_addtime',default=datetime.now)  # Field name made lowercase.
    Owner = models.ForeignKey('user', on_delete=models.CASCADE, db_column='Owner_id')  # Field name made lowercase.
    Album_password = models.CharField(db_column='Album_password', max_length=50, blank=True, null=True)  # Field name made lowercase.
    Album_visible = models.IntegerField(db_column='Album_visible', default=0)  # Field name made lowercase.
    photo_count = models.IntegerField(db_column='photo_count', default=0)
    cover = models.CharField(db_column='cover',max_length=50, default='cover.jpg')

    def toDict(self):
        return {'id':self.id,'Album_name':self.Album_name,'Album_description':self.Album_description,
                'Album_addtime':self.Album_addtime.strftime('%Y-%m-%d %H:%M:%S'),'Owner_id':self.Owner_id,
                'Album_password':self.Album_password,'Album_visible':self.Album_visible,'photp_count':self.photo_count,
                'cover':self.cover}

    class Meta:
        managed = True
        db_table = 'album'



class category(models.Model):
    Category_name = models.CharField(db_column='Category_name', unique=True, max_length=255)  # Field name made lowercase.

    def toDict(self):
        return{'id':self.id,'Category_name':self.Category_name}

    class Meta:
        managed = True
        db_table = 'category'



class comment(models.Model):
    Comment_content = models.CharField(db_column='Comment_content', max_length=255)  # Field name made lowercase.
    Comment_time = models.DateTimeField(db_column='Comment_time', default=datetime.now)  # Field name made lowercase.
    Photo = models.ForeignKey('photo', on_delete=models.CASCADE, db_column='Photo_id')  # Field name made lowercase.
    Commentators = models.ForeignKey('user', on_delete=models.CASCADE, db_column='Commentators_id')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'comment'


class favorites(models.Model):
    Collector = models.ForeignKey('user', on_delete=models.CASCADE, db_column='Collector_id')  # Field name made lowercase.
    Collect_date = models.DateTimeField(db_column='Collect_date', default=datetime.now)  # Field name made lowercase.
    Photo = models.ForeignKey('photo', on_delete=models.CASCADE, db_column='Photo_id')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'favorites'


class photo(models.Model):
    Album = models.ForeignKey('album', on_delete=models.CASCADE, db_column='Album_id')  # Field name made lowercase.
    Photo_name = models.CharField(db_column='Photo_name', max_length=50)  # Field name made lowercase.
    Photo_description = models.CharField(db_column='Photo_description', max_length=50, blank=True, null=True)  # Field name made lowercase.
    Category = models.ForeignKey('category', on_delete=models.SET_NULL, db_column='Category_id', blank=True, null=True)  # Field name made lowercase.
    Photo_addtime = models.DateTimeField(db_column='Photo_addtime', blank=True, null=True,default=datetime.now)  # Field name made lowercase.
    Photo_height = models.FloatField(db_column='Photo_height', blank=True, null=True)  # Field name made lowercase.
    Photo_width = models.FloatField(db_column='Photo_width', blank=True, null=True)  # Field name made lowercase.
    Photo_link = models.CharField(db_column='Photo_link', max_length=100)  # Field name made lowercase.
    thumb_count = models.IntegerField(db_column='thumb_count', default=0)
    Photo_visible = models.IntegerField(db_column='Photo_visible', default=0)  # Field name made lowercase.

    def toDict(self):
        return {'id': self.id, 'Album_id': self.Album_id, 'Photo_name': self.Photo_name,
               'Photo_description': self.Photo_description, 'Category_id': self.Category_id, 'Photo_addtime': self.Photo_addtime.strftime('%Y-%m-%d %H:%M:%S'),
               'Photo_height': self.Photo_height, 'Photo_width': self.Photo_width, 'Photo_link': self.Photo_link,
               'thumb_count': self.thumb_count,'Photo_visible':self.Photo_visible}

    class Meta:
        managed = True
        db_table = 'photo'


class user(models.Model):
    User_name = models.CharField(db_column='User_name', unique=True, max_length=100)  # Field name made lowercase.
    User_password = models.CharField(db_column='User_password', max_length=100)  # Field name made lowercase.
    User_email = models.CharField(db_column='User_email', max_length=100, blank=True, null=True)  # Field name made lowercase.
    User_phone = models.CharField(db_column='User_phone', max_length=100, blank=True, null=True)  # Field name made lowercase.
    User_gender = models.CharField(db_column='User_gender', max_length=4, blank=True, null=True)  # Field name made lowercase.
    date_joined = models.DateTimeField(db_column='date_joined', default=datetime.now)
    User_status = models.IntegerField(db_column='User_status', default=0)  # Field name made lowercase.
    User_check = models.IntegerField(db_column='User_check', default=0)  # Field name made lowercase.
    album_count = models.IntegerField(db_column='album_count', default=0)
    photo_count = models.IntegerField(db_column='photo_count', default=0)

    def toDict(self):
        return {'id':self.id,'User_name':self.User_name,'User_password':self.User_password,
                'User_email':self.User_email,'User_phone':self.User_phone,'User_gender':self.User_gender,
                'date_joined':self.date_joined.strftime('%Y-%m-%d %H:%M:%S'),'User_status':self.User_status,
                'User_check':self.User_check,'album_count':self.album_count,'photo_count':self.photo_count}

    class Meta:
        managed = True
        db_table = 'user'



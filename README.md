###仿新浪微博客户端
---
由于微博开放平台的限制，如果希望在本地运行时能正常获取数据，可以参考新浪微博官方SDK文档的说明修改AppKey等信息。

使用的第三方库

* SDWebImage
* MJRefresh

####实现的主要功能
---
#####1. 首页
	首页微博列表
	详细微博
	评论列表
    推荐好友列表
    好友分组下拉菜单
    下拉刷新、上拉加载更多微博
    微博原图放大浏览

#####2. 消息
	搭建消息界面

#####3. 发布微博
	自定义TabBar
	发布/转发微博

#####4. 发现
    搜索，可以设置搜索范围（用户、学校、公司）
    附近的微博和人，两种显示方式（列表显示、地图显示）
		在tableview中上添加固定位置的子视图
		自定义大头针视图

#####5. 我（个人中心）
    个人主页
    授权及及取消授权


####TODO
---
优化发布微博功能

优化图片放大显示原图细节

适配iPhone 6/6+


####效果图
---
#####1.首页
![sinaWeibo](https://github.com/debolee/WeiboForSina/blob/master/1_Home.gif)
#####2.消息
![sinaWeibo](https://github.com/debolee/WeiboForSina/blob/master/2_Message.gif)
#####3.发布微博
![sinaWeibo](https://github.com/debolee/WeiboForSina/blob/master/3_Send.gif)
#####4. 发现
![sinaWeibo](https://github.com/debolee/WeiboForSina/blob/master/4_Discover.gif)
#####5. 我（个人中心）
![sinaWeibo](https://github.com/debolee/WeiboForSina/blob/master/5_AboutMe.gif)
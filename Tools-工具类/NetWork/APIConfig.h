//
//  APIConfig.h
//  ClassSchedule
//
//  Created by Superme on 2019/10/25.
//  Copyright © 2019 Superme. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h
//测试服
#define  BaseURL          @"https://api.bjzhanbotest.com/"


#define  NET_CACHE           @"NetCache"


//首页接口

#define API_GET_PAGELIST     @"Home/getPageInfo"   //获取首页分类
#define API_GET_LIVE_LIIIST  @"Home/getCateLiveList" //获取分类下的直播或回放
#define API_GET_EXHIBITION   @"Home/getExhibitionList" //获取直播预告分类列表
#define API_GET_EXHIBITION_DETAIL   @"Home/getExhibitionInfo" //获取直播预告详情
#define API_ORDER_EXHIBITION @"Home/setExhibitionMake"//预约展会
#define API_SEARCH           @"Home/userSearchList"  //首页上搜索
#define API_ATTEITON_USER    @"Home/setFollowAnchor"//关注用户
#define API_GET_FOLLOW       @"Home/getFollowList" //获取关注用户列表
#define API_CANCEL_ATTENTION  @"Home/delFollowAnchor"//取消关注
#define API_GET_EXHIBITION_SHARE  @"Home/getExhibitionShare"//获取展会分享详情接口
#define API_GET_RECORD_SHARE   @"Live/getLiveRecordShare" //获取直播回放分享接口
#define API_GET_TYPE_LIST      @"Home/getCategoryList"//分类列表
//回放接口

#define API_GET_RECORD      @"Home/getExTypeList"//获取回放列表
#define API_GET_RECORD_LIST @"Home/getExTyLiveList" //或缺回放二级列表
#define API_GET_RECORD_DETAL @"Live/liveRecordInfo"//获取回放详情
#define API_GET_VIDEO_DETAI  @"Video/getVideoInfo" //获取视频详情j
//登录注册
#define API_LOGIN           @"Login/loginPwd" //登录
#define API_COUSTOMER_REGISTER @"Login/register" //用户注册
#define API_GET_MSG         @"Login/sendSms" //获取验证码
#define API_COMPANY_REGISTER @"Login/exhibitorReg" //参展商注册
#define API_FORGET_PWD      @"Login/forgetUserPwd" //忘记密码
#define API_GET_FOR_MSG     @"Login/forgetSendSms"//忘记密码发送短信验证码
#define API_LOGIN_THIRD     @"Login/loginByThird" //三方登录



//个人中心

#define API_GET_AGREEMENT   @"User/getAgreementList"//获取隐私政策和协议
#define API_VERFI_LIVE      @"User/checkUserLive" //验证是否直播
#define API_GET_LIVE_NOTE   @"User/getLiveRecordList" //获取直播记录
#define API_GET_ORDER_LIVE  @"/User/exhibitionMakeList"//获取我的预约
#define API_GET_INTERSET     @"User/getLabelList"//获取兴趣标签
#define API_UPDATE_USERINDO  @"User/setUserInfo" //修改用户信息
#define API_GET_VIDEOLIKE    @"User/getUserLiket"//获取我的喜欢接口
#define API_MY_VIODEOLIST    @"User/getUserVideoList"//获取我的视频接口
#define API_GET_COMPANYLIST  @"Wall/getWallList"//获取企业墙列表
#define API_UPLOAD_COMPANYIMG @"Wall/uploadWallFile"//上传企业墙单张照片
#define API_ADD_COMPANY       @"Wall/setUserWall"//添加企业墙
#define API_DELETE_COMPANY    @"Wall/delUserWall"//删除企业墙
#define API_EDIT_COMPANY      @"Wall/setExInfo"//编辑企业墙
#define API_GET_COMPANYDETAIL @"Wall/getWallInfo"//湖区企业墙详情
#define API_PRAISE_COMPANY    @"Wall/setUserWallSpot"//点赞企业墙
#define API_GET_INFO_SHARE    @"User/getUserShare"//获取个人信息分享
#define API_GET_QINIUTOKEN    @"Video/getQiniuTOken"//获取七牛云token
#define API_PUBLISH_VIDEO     @"Video/userReleaseVideo"//用户发布视频
//视频模块
#define API_GET_VIDEO_LIST   @"Video/getVideoDetailsList" //获取短视频列表
#define API_GET_OTHER_INFO   @"User/setUserVisit" //获取被访问用户信息
#define API_GET_COMMENT_LIST @"Video/getVideoComment" //获取视频评论列表
#define API_SEND_JUDGE       @"Video/setVideoComment"//视频发布评论
#define API_GET_VIDEO_SHARE  @"Video/getVideoShare"//获取短视频分享链接
#define APII_PRAISE_VIDEO    @"Video/setVideoSpot"//给短视频点赞
#define API_CANCEL_PRAISE    @"Video/cancelVideoSpot"//取消点赞
#define API_GET_SHARE_COUNT  @"Video/videoShareCount"//获取视频分享总次数
//直播模块

#define API_GET_LIVE_EXHIBITION @"Live/getExList" //获取直播展会分类
#define API_CTEATE_LIVE     @"Live/creatLiveRoom"//创建直播
#define API_CLOSE_LIVE      @"Live/userCloseLive"//关闭直播
#define API_GET_LIVE_SHARE   @"Live/getLiveShare"//获取直播分享标题
#define API_USER_IN_LIVE    @"Live/userEnterLive"//用户进入直播间
#define API_UPDATE_LIVETYPE @"Live/setChangeLive"//修改状态为正在直播
#endif /* APIConfig_h */

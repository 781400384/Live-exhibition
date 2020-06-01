//
//  ExhibitionDetaiilViewController.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/8.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "ExhibitionDetaiilViewController.h"
#import "MainHandle.h"
#import "ExhibitionDetailImageModel.h"
#import "ExhibitionDetailVideoModel.h"
#import "RecordVideoPlayViewController.h"
#import "ExhibitionImageBigViewController.h"
#import "ExhibitionVideoPlayViewController.h"
#import "bottomAlertView.h"
#import "SettingDetailViewController.h"
#define BarHeight           [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavHeight           (37.0+BarHeight)
#define TopViewHeight       229.0
@interface ExhibitionDetaiilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView       *       tableView;
@property (nonatomic, strong) UIImageView       *       bgImage;
@property (nonatomic, strong) UIView            *       bgView;
@property (nonatomic, strong) UIImageView       *       radiusImg;
@property (nonatomic, strong) UILabel           *       titleLabel;
@property (nonatomic, strong) UIButton          *       backBtn;
@property (nonatomic, strong) UIButton          *       shareBtn;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) NSDictionary      *       dictionary;
@property (nonatomic,strong) UIScrollView                 *            judgeScrollViewOne;
@property (nonatomic,strong) UIScrollView                 *            judgeScrollViewTwo;
@property (nonatomic, strong) NSMutableArray    *       videoList;
@property (nonatomic, strong) NSMutableArray    *       imageList;


@end

@implementation ExhibitionDetaiilViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.naviView.rightItemButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.naviView.rightItemButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self   lodData];
    
}
-(void)share{
    [MainHandle getExhibitionShreWithExhibition_id:self.exhibitionId  Uid:[[UserInfoDefaults userInfo].uid intValue] success:^(id  _Nonnull obj) {
        NSDictionary  *  dic=(NSDictionary *)obj;
               if ([dic[@"code"] intValue]==200) {
                   bottomAlertView * alertV = [[bottomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                               [[UIApplication sharedApplication].keyWindow addSubview:alertV];
                   alertV.shareTitle=dic[@"data"][@"title"];
                   alertV.shareDesc=dic[@"data"][@"desc"];
                   alertV.imageUrl=dic[@"data"][@"thumb"];
                   alertV.url=dic[@"data"][@"url"];
               }else{
//                   [self.view toast:dic[@"msg"]];
               }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)lodData{
    [MainHandle getExhibitionDetailWithExhibitionId:self.exhibitionId uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        NSLog(@"dic==%@",dic);
        self.videoList=[ExhibitionDetailVideoModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"video_list"]];
        self.imageList=[ExhibitionDetailImageModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"picture_list"]];
        self.dictionary=dic;
        [self configUI];
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)configUI{
    [self.view addSubview:self.tableView];
        

      self.bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopViewHeight)];
      self.bgImage.clipsToBounds=YES;
      self.bgImage.userInteractionEnabled=YES;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:self.dictionary[@"data"][@"thumb"]]];
      [self.view addSubview:self.bgImage];
    #pragma mark - 顶部悬浮View
        //悬浮的view
          UIButton  *  back=[[UIButton alloc]initWithFrame:CGRectMake(14*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 24*KScaleW, 24*KScaleW)];
            [back setImage:[UIImage imageNamed:@"main_navi_back"] forState:UIControlStateNormal];
            [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            [self.bgImage addSubview:back];
    
    UIButton  *  share=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-38*KScaleW, IS_X?NAVI_SUBVIEW_Y_iphoneX:NAVI_SUBVIEW_Y_Normal, 24*KScaleW, 24*KScaleW)];
    [share setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImage addSubview:share];
        
          self.bgView=[[UIView alloc]initWithFrame:CGRectMake(0, self.bgImage.height-NavHeight, SCREEN_WIDTH, NavHeight)];
          self.bgView.userInteractionEnabled=YES;
          [self.bgImage addSubview:self.bgView];
          self.bgView.backgroundColor=[UIColor clearColor];
        
          self.radiusImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_radius"]];
          self.radiusImg.frame=CGRectMake(0, BarHeight, SCREEN_WIDTH, 37.0);
          self.radiusImg.contentMode=UIViewContentModeScaleToFill;
          self.radiusImg.userInteractionEnabled=YES;
          self.radiusImg.clipsToBounds=YES;
          [self.bgView addSubview:self.radiusImg];

           
            self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14*KScaleW,6.5*KScaleH, SCREEN_WIDTH-28*KScaleW, 24*KScaleH)];
            self.titleLabel.font=APP_BOLD_FONT(18.0);
            self.titleLabel.textAlignment=NSTextAlignmentLeft;
            self.titleLabel.text=self.dictionary[@"data"][@"title"];
            self.titleLabel.userInteractionEnabled=YES;
            [self.radiusImg addSubview:self.titleLabel];
    
            self.backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24*KScaleW, 24*KScaleH)];
            [self.backBtn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
            [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            [self.titleLabel addSubview:self.backBtn];
    self.shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(_titleLabel.width-24*KScaleW, 0, 24*KScaleW, 24*KScaleH)];
    [self.shareBtn setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.titleLabel addSubview:self.shareBtn];
            self.backBtn.hidden=YES;
    self.shareBtn.hidden=YES;
        
    #pragma mark - 底部视图
     
        UIView  *  lineView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50*KScaleH, SCREEN_WIDTH, 0.5*KScaleH)];
        lineView.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
        [self.view addSubview:lineView];
        
        UILabel   *   timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(15*KScaleW,SCREEN_HEIGHT-32.25*KScaleH, SCREEN_WIDTH-15*KScaleW-164.5*KScaleW, 14.5*KScaleH)];
        timeLabel.textAlignment=NSTextAlignmentLeft;
        timeLabel.font=APP_NORMAL_FONT(14.0);
        timeLabel.textColor=[UIColor colorWithHexString:@"#323232"];
    
        [self.view addSubview:timeLabel];
        
        UIButton  *  orderBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-164.5*KScaleW, SCREEN_HEIGHT-42.5*KScaleH, 150*KScaleW, 35*KScaleH)];
    if ([self.dictionary[@"data"][@"is_make"] intValue]==0) {
         orderBtn.backgroundColor=APP_NAVI_COLOR;
         [orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    }else{
         orderBtn.backgroundColor=[UIColor colorWithHexString:@"#E5E5E5"];
         [orderBtn setTitle:@"已预约" forState:UIControlStateNormal];
         orderBtn.userInteractionEnabled=NO;
    }
        orderBtn.titleLabel.font=APP_BOLD_FONT(15.0);
    [orderBtn addTarget:self action:@selector(orderClick) forControlEvents:UIControlEventTouchUpInside];
        [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [orderBtn setRadius:17.5*KScaleW];
        [self.view addSubview:orderBtn];
    
    if ([self.dictionary[@"data"][@"day"] intValue]==-1) {
           NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"已结束"];
                  NSRange range1 = [[str string] rangeOfString:@"已结束"];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#323232"] range:range1];
            timeLabel.attributedText = str;
        orderBtn.hidden=YES;
       }else   if ([self.dictionary[@"data"][@"day"] intValue]==0) {
              NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"进行中"];
                     NSRange range1 = [[str string] rangeOfString:@"进行中"];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#323232"] range:range1];
               timeLabel.attributedText = str;
           orderBtn.hidden=YES;
       }else{
           NSString  *  time=[NSString stringWithFormat:@"%@" ,self.dictionary[@"data"][@"day"]];
           NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"倒计时：还有%@天",time]];
           NSRange range1 = [[str string] rangeOfString:@"倒计时：还有天"];
           [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#323232"] range:range1];
           NSRange range2 = [[str string] rangeOfString:time];
           [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
           timeLabel.attributedText = str;
           orderBtn.hidden=NO;
           
       }
}
-(void)orderClick{
    
    [MainHandle orderExhibitionWithExhibitionId:self.exhibitionId uid:[[UserInfoDefaults userInfo].uid intValue] token:[UserInfoDefaults userInfo].token success:^(id  _Nonnull obj) {
        NSDictionary * dic=(NSDictionary *)obj;
        if ([dic[@"code"] intValue]==200) {
            [self.view toast:@"预约成功"];
            [self lodData];
            SettingDetailViewController  *  vc=[[ SettingDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
            vc.url=dic[@"data"][@"url"];
        }else{
            [self.view toast:self.dictionary[@"msg"]];
        }
    } failed:^(id  _Nonnull obj) {
        
    }];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50*KScaleH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator =NO;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //拉高tableView的内边距
        _tableView.contentInset = UIEdgeInsetsMake(TopViewHeight, 0, 0, 0);
        //监听tableView的contentOffset的改变
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
         return 100*KScaleH;
    }else{
        return 0;
    }
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
         return UITableViewAutomaticDimension;
    }else if(indexPath.row==1){
        return 251.5*KScaleH;
    }else if(indexPath.row==2){
        return 165.5*KScaleH;
    }else{
        return 260*KScaleH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.textLabel.text=self.dictionary[@"data"][@"content"];
        cell.textLabel.numberOfLines=0;
        cell.textLabel.font=APP_NORMAL_FONT(14.0);
        cell.textLabel.textColor=[UIColor colorWithHexString:@"#666666"];
    }
    if (indexPath.row==1) {
        UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 30*KScaleH, SCREEN_WIDTH-14.5*KScaleW, 15.5*KScaleH)];
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.font=APP_BOLD_FONT(16.0);
        titleLabel.textColor=COLOR_333;
        titleLabel.text=@"宣传视频";
        [cell addSubview:titleLabel];
        
        self.judgeScrollViewOne = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+14.5*KScaleH,SCREEN_WIDTH, 161.5*KScaleH)];
        self.judgeScrollViewOne.backgroundColor = [UIColor whiteColor];
        self.judgeScrollViewOne.showsHorizontalScrollIndicator = NO;
        self.judgeScrollViewOne.userInteractionEnabled=YES;
        [cell addSubview:self.judgeScrollViewOne];
        self.judgeScrollViewOne.contentSize = CGSizeMake(15*KScaleW+150*KScaleW*self.videoList.count, 0);

        for (int i=0; i<self.videoList.count; i++) {
            ExhibitionDetailVideoModel  *  model=self.videoList[i];
           
            UIImageView  *    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(15*KScaleW+150*KScaleH*i, 0, 139.5*KScaleW, 161.5*KScaleH)];
            [bgImage setRadius:7.5*KScaleH];
            bgImage.clipsToBounds=YES;
            [self.judgeScrollViewOne addSubview:bgImage];
            UIImageView  *  playImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"video_play"]];
                       playImg.contentMode=UIViewContentModeScaleAspectFit;
                       [bgImage addSubview:playImg];
            [playImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(bgImage.mas_centerX);
                make.centerY.mas_equalTo(bgImage.mas_centerY);
            }];
            [bgImage sd_setImageWithURL:[NSURL URLWithString:model.path]];
            bgImage.userInteractionEnabled=YES;
            UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                ExhibitionVideoPlayViewController  *  vc=[[ExhibitionVideoPlayViewController alloc]init];
                vc.url=model.url;
                vc.path=model.path;
                NSLog(@"11111");
                [self.navigationController pushViewController:vc animated:NO];
            }];
            [bgImage addGestureRecognizer:tap];
            
        }
        
        
    }
    if (indexPath.row==2) {
         UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 0, SCREEN_WIDTH-14.5*KScaleW, 15.5*KScaleH)];
               titleLabel.textAlignment=NSTextAlignmentLeft;
               titleLabel.font=APP_BOLD_FONT(16.0);
               titleLabel.textColor=COLOR_333;
               titleLabel.text=@"参展商风采";
               [cell addSubview:titleLabel];
               
               self.judgeScrollViewTwo = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+14.5*KScaleH,SCREEN_WIDTH, 105.5*KScaleH)];
               self.judgeScrollViewTwo.backgroundColor = [UIColor whiteColor];
               self.judgeScrollViewTwo.showsHorizontalScrollIndicator = NO;
          self.judgeScrollViewOne.userInteractionEnabled=YES;
               [cell addSubview:self.judgeScrollViewTwo];
               self.judgeScrollViewTwo.contentSize = CGSizeMake(15*KScaleW+200*KScaleW*self.imageList.count, 0);

               for (int i=0; i<self.imageList.count; i++) {
                   UIImageView  *    bgImage=[[UIImageView alloc]initWithFrame:CGRectMake(15*KScaleW+200*KScaleH*i, 0, 190*KScaleW, 105.5*KScaleH)];
                   [bgImage setRadius:7.5*KScaleH];
                   bgImage.clipsToBounds=YES;
                   bgImage.userInteractionEnabled=YES;
                   [self.judgeScrollViewTwo addSubview:bgImage];
                   ExhibitionDetailImageModel   *  model=self.imageList[i];
                  [bgImage sd_setImageWithURL:[NSURL URLWithString:model.path]];
                   UITapGestureRecognizer   *  tap=[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                                   ExhibitionImageBigViewController   *  vc=[[ExhibitionImageBigViewController alloc]init];
                                                 [self.navigationController pushViewController:vc animated:NO];
                       vc.url=model.path;
                             }];
                             [bgImage addGestureRecognizer:tap];
                
               }
    }
    if (indexPath.row==3) {
          UILabel  *  titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(14.5*KScaleW, 0, SCREEN_WIDTH-14.5*KScaleW, 15.5*KScaleH)];
                     titleLabel.textAlignment=NSTextAlignmentLeft;
                     titleLabel.font=APP_BOLD_FONT(16.0);
                     titleLabel.textColor=COLOR_333;
                     titleLabel.text=@"展会详情";
                     [cell addSubview:titleLabel];
        for (int i=0; i<8; i++) {
            UILabel  *   detail=[[UILabel alloc]initWithFrame:CGRectMake(35*KScaleW, titleLabel.bottom+15*KScaleH+24*KScaleH*i, SCREEN_WIDTH-35*KScaleW, 13*KScaleH)];
            switch (i) {
                case 0:
                    detail.font=APP_BOLD_FONT(14.0);
                    detail.textColor=COLOR_333;
                    break;
               case 3:
               detail.font=APP_BOLD_FONT(14.0);
               detail.textColor=COLOR_333;
                break;
                case 5:
                detail.font=APP_BOLD_FONT(14.0);
                detail.textColor=COLOR_333;
                break;
                    
                default:
                    detail.font=APP_NORMAL_FONT(14.0);
                    detail.textColor=[UIColor colorWithHexString:@"#666666"];
                    break;
            }
            detail.textAlignment=NSTextAlignmentLeft;
            detail.text=@[[NSString stringWithFormat:@"展会时间:%@-%@",self.dictionary[@"data"][@"startTime"],self.dictionary[@"data"][@"endTime"]],[NSString stringWithFormat:@"所属行业:%@",self.dictionary[@"data"][@"industry"]],[NSString stringWithFormat:@"展出城市:%@",self.dictionary[@"data"][@"city"]],@"展会地址",self.dictionary[@"data"][@"address"],@"联系方式",[NSString stringWithFormat:@"联系人:%@",self.dictionary[@"data"][@"contact"]],[NSString stringWithFormat:@"联系方式:%@",self.dictionary[@"data"][@"contact_number"]]][i];
            [cell addSubview:detail];
            
            UIImageView  *  image=[[UIImageView alloc]initWithFrame:CGRectMake(13.5*KScaleW, detail.centerY-7*KScaleH, 18*KScaleW, 18*KScaleH)];
            image.contentMode=UIViewContentModeScaleAspectFit;
            NSArray  *  imageName=@[@"main_time",@"",@"",@"main_adress",@"",@"main_phone",@"",@""];
            image.image=[UIImage imageNamed:imageName[i]];
            [cell addSubview:image];
            
            
            
        }
    }
    
   

    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if (-offset.y >= TopViewHeight) {
            self.bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, TopViewHeight);
            self.titleLabel.textAlignment=NSTextAlignmentLeft;
            self.backBtn.hidden=YES;
            self.shareBtn.hidden=YES;
            self.bgView.backgroundColor=[UIColor clearColor];
        }
        else if (-offset.y > NavHeight && -offset.y < TopViewHeight) {
               self.bgImage.frame = CGRectMake(0, -offset.y-TopViewHeight, SCREEN_WIDTH, TopViewHeight);
            self.titleLabel.textAlignment=NSTextAlignmentCenter;
            self.backBtn.hidden=NO;
            self.shareBtn.hidden=NO;
            self.bgView.backgroundColor=[UIColor whiteColor];
        }
        else if (-offset.y <= NavHeight) {
              self.bgImage.frame = CGRectMake(0, NavHeight-TopViewHeight, SCREEN_WIDTH, TopViewHeight);
            self.titleLabel.textAlignment=NSTextAlignmentCenter;
            self.backBtn.hidden=NO;
            self.shareBtn.hidden=NO;
            self.bgView.backgroundColor=[UIColor whiteColor];
        }
    }
}

- (void)dealloc {
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}
-(NSMutableArray *)videoList{
    if (!_videoList) {
        _videoList=[NSMutableArray array];
    }
    return _videoList;
}
-(NSMutableArray *)imageList{
    if (!_imageList) {
        _imageList=[NSMutableArray array];
    }
    return _imageList;
}

@end

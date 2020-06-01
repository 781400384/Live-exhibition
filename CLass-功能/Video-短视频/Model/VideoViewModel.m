//
//  VideoViewModel.m
//  VideoLive
//
//  Created by 纪明 on 2020/1/21.
//  Copyright © 2020 纪明. All rights reserved.
//

#import "VideoViewModel.h"
#import "VideoHandle.h"
@interface VideoViewModel()
@property (nonatomic, assign) int page;
@end
@implementation VideoViewModel
//- (void)refreshNewListWithTypeId:(int)TypeId Success:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
//    self.page = 1;
//    [VideoHandle getVideoListWuthPage:self.page uid:[[UserInfoDefaults userInfo].uid intValue] cateId:TypeId success:^(id  _Nonnull obj) {
//        NSDictionary  *  dic=(NSDictionary *)obj;
//        if ([dic[@"code"] intValue]==200) {
//            NSMutableArray   *  dataList=[[NSMutableArray alloc]init];
//            [dataList addObjectsFromArray:[VideoViewModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
//            success(dataList);
//        }
//    } failed:^(id  _Nonnull obj) {
//        failure(obj);
//    }];
//   
//}
//
//- (void)refreshMoreListWithTypeId:(int)TypeId Success:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure  {
//  self.page ++;
//       [VideoHandle getVideoListWuthPage:self.page uid:[[UserInfoDefaults userInfo].uid intValue] cateId:TypeId success:^(id  _Nonnull obj) {
//           NSDictionary  *  dic=(NSDictionary *)obj;
//           if ([dic[@"code"] intValue]==200) {
//               NSMutableArray   *  dataList=[[NSMutableArray alloc]init];
//               [dataList addObjectsFromArray:[VideoViewModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
//               success(dataList);
//           }
//       } failed:^(id  _Nonnull obj) {
//           failure(obj);
//       }];
//}
@end

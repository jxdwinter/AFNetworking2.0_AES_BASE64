//
//  HttpClient.h
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/6/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HttpClient : AFHTTPRequestOperationManager

+ (instancetype)sharedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

/**
 *  访问网络公共方法
 *
 *  @param dic          参数字典
 *  @param info         提示语
 *  @param isCache      是否使用缓存数据
 *  @param view         在哪个页面条用此方法
 *  @param success      成功返回数据
 *  @param failure      返回数据失败
 *  @param networkerror 没有网络
 *
 *  @return 数据字典
 */
- (NSDictionary *)getDataWithDictionary : (NSDictionary *) dic
                           withShowInfo : (NSString *) info
                         withIsUseCache : (BOOL) isCache
                   withUIViewController : (UIViewController *)viewController
                                success : (void (^)(NSDictionary* dictionary))success
                                failure : (void (^)(NSError *error))failure;


@end

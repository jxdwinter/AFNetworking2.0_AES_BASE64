//
//  HttpClient.m
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/6/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

static NSString * const kReachability = @"http://e.m-365.com";

#import "HttpClient.h"
#import "AESenAndDe.h"
#import "MBProgressHUD.h"
#import "CustomView.h"
#import "Global.h"
#import "CheckNetwork.h"

@interface HttpClient ()

@property (nonatomic, assign) int countNum;
@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation HttpClient


+ (instancetype)sharedHTTPClient{

    static HttpClient *_sharedHTTPClient = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kReachability]];
    });
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url{

    self = [super initWithBaseURL:url];

    if (self) {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}


/**
 *  访问网络公共方法
 *
 *  @param dic          参数字典
 *  @param info         提示语
 *  @param isCache      是否使用缓存数据
 *  @param view         在哪个页面条用此方法
 *  @param success      成功返回数据
 *  @param failure      返回数据失败
 *
 *  @return 数据字典
 */
- (NSDictionary *)getDataWithDictionary : (NSDictionary *) dic
                           withShowInfo : (NSString *) info
                         withIsUseCache : (BOOL) isCache
                   withUIViewController : (UIViewController *)viewController
                                success : (void (^)(NSDictionary* dictionary))success
                                failure : (void (^)(NSError *error))failure
{
    if ([CheckNetwork isExistenceNetwork]) {

        if (!_currentViewController) {
            _currentViewController = viewController;
        }else{
            if (_currentViewController != viewController) {
                [MBProgressHUD hideHUDForView:_currentViewController.view animated:YES];
                _currentViewController = viewController;
                _countNum = 0;
            }
        }

        NSString *jsonString = nil;
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                           options:0
                                                             error:&error];
        if (error) {
            return nil;
        }
    
        if (jsonData){
            jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        }

        NSString *str_64 = [AESenAndDe En_AESandBase64EnToString:jsonString];
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:str_64,@"para", nil];

        if (_countNum == 0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[CustomView alloc] initWithFrame:CGRectMake(0.0, 0.0, 24.0, 24.0)];
            hud.labelText = info;
            [hud show:YES];
        }

        _countNum++;

        [self POST:[NSString stringWithFormat:@"%@%@",kReachability,@"/Interface/"]
        parameters:parameters
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSDictionary *dictionary = [AESenAndDe De_Base64andAESToDictionary:responseStr];
                  NSLog(@"JSON: %@", dictionary);
                  if (dictionary){
                      success(dictionary);
                      /*!
                       *  如果使用缓存数据,把成功返回的数据加密保存
                       */
                      /*
                      if ([dictionary[@"result"] isEqualToString:@"0"]) {
                          if (isCache) {
                              NSString *md5str = [Global getMD5Value:[dic description]];
                              NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                              NSString *filename = [Path stringByAppendingPathComponent:md5str];
                              [NSKeyedArchiver archiveRootObject:responseStr toFile:filename];
                          }
                      }
                       */
                  }else{

                  }

                  if (_countNum > 0) _countNum--;
                  if (_countNum == 0) {
                      [MBProgressHUD hideHUDForView:viewController.view animated:YES];
                  }

          }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);

              if (_countNum > 0) _countNum--;
              if (_countNum == 0) {
                  [MBProgressHUD hideHUDForView:viewController.view animated:YES];
              }
              }];
    }else{
        /*
        if (isCache) {
            NSString *md5str = [Global getMD5Value:[dic description]];
            NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            NSString *filename = [Path stringByAppendingPathComponent:md5str];
            NSDictionary *dictionary = [AESenAndDe De_Base64andAESToDictionary :[NSKeyedUnarchiver unarchiveObjectWithFile:filename]];
            if (dictionary){
                success(dictionary);
            }
        }
         */
    }
    return nil;
}

@end

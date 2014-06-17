//
//  Global.h
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/10/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject
/*!
 *  get MD5 value
 *
 *  @param input 字符串
 *
 *  @return md5字符串
 */
+ (NSString *) getMD5Value:(NSString *) input;

@end

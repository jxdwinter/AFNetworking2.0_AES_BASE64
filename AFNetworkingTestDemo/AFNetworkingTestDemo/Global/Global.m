//
//  Global.m
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/10/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

#import "Global.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Global

+ (NSString *) getMD5Value:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;
}
@end

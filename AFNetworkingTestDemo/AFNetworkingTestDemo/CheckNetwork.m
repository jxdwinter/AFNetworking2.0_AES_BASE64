#import "CheckNetwork.h"
#import "Reachability.h"

@implementation CheckNetwork

/**
 *  判断网络
 *
 *  @return 是否存在网络
 */
+(BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostname:@"http://e.m-365.com"];
    
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
			isExistenceNetwork = FALSE;
         //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
			isExistenceNetwork = TRUE;
         //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
			isExistenceNetwork = TRUE;
          //  NSLog(@"正在使用wifi网络");        
            break;
    }
	return isExistenceNetwork;
}
@end

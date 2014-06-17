//
//  NextViewController.m
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/10/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

#import "NextViewController.h"
#import "HttpClient.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"action"] = @"doTest";
    dic[@"content"] = @"HelloWorld";
    HttpClient *httpClient = [HttpClient sharedHTTPClient];

    for (int i = 0; i < 10; i++) {
        [httpClient getDataWithDictionary:dic
                             withShowInfo:@"123123123123123123123"
                           withIsUseCache:NO
                     withUIViewController:self
                                  success:^(NSDictionary *dictionary) {

                                  } failure:^(NSError *error) {

                                  }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

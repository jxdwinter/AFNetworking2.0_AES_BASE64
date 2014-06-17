//
//  ViewController.m
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/5/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "HttpClient.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[@"action"] = @"doTest";
    dic[@"content"] = @"HelloWorld";
    HttpClient *httpClient = [HttpClient sharedHTTPClient];

    for (int i = 0; i < 1; i++) {
        [httpClient getDataWithDictionary:dic
                             withShowInfo:@"afjasl;dkfjas;dlkfja;skdlf"
                           withIsUseCache:NO
                     withUIViewController:self
                                  success:^(NSDictionary *dictionary) {

                                  } failure:^(NSError *error) {
                                      
                                  }];
    }
}
- (IBAction)nextButtonClicked:(UIBarButtonItem *)sender {
    [self.navigationController pushViewController:[[NextViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

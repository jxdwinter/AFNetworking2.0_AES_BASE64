//
//  CustomView.m
//  AFNetworkingTestDemo
//
//  Created by JiangXiaodong on 6/10/14.
//  Copyright (c) 2014 jxdwinter. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 24.0, 24.0)];
        logoImageView.image = [UIImage imageNamed:@"loading"];
        [self addSubview:logoImageView];

        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
        rotationAnimation.duration = 3.0;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;

        [logoImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

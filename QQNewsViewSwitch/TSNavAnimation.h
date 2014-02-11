//
//  TSNavAnimation.h
//  Test
//
//  Created by ludawei on 14-2-10.
//  Copyright (c) 2014年 ludawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TsNavAnimation : NSObject<UIViewControllerAnimatedTransitioning>

-(void)modifyFrameXwithView:(UIView *)view value:(float)value;

@end

@interface TSPushNavAnimation : TsNavAnimation

@end

@interface TSPopNavAnimation : TsNavAnimation

@end

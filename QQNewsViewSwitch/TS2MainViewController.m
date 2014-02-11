//
//  TS2MainViewController.m
//  Test
//
//  Created by ludawei on 14-2-10.
//  Copyright (c) 2014年 ludawei. All rights reserved.
//

#import "TS2MainViewController.h"
#import <EventKit/EventKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TSModelViewController.h"
#import "TSNavAnimation.h"

@interface TS2MainViewController ()<UIViewControllerTransitioningDelegate,UICollisionBehaviorDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) UIDynamicAnimator *animator;

@property (nonatomic,strong) TSPushNavAnimation *pushNavAnimation;
@property (nonatomic,strong) TSPopNavAnimation *popNavAnimation;

@end

@implementation TS2MainViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    aView.backgroundColor = [UIColor lightGrayColor];
    aView.transform = CGAffineTransformRotate(aView.transform, 45);
    [self.view addSubview:aView];
    
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[aView]];
    [animator addBehavior:gravityBeahvior];
    
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[aView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    collisionBehavior.collisionDelegate = self;
    
    self.animator = animator;
    
    self.title = @"testTitle";
//    self.navigationItem.leftBarButtonItem.t
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"present" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 初始化动画方案
    self.pushNavAnimation = [[TSPushNavAnimation alloc] init];
    self.popNavAnimation  = [[TSPopNavAnimation alloc] init];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftButtonClick
{
    TSModelViewController *toViewController = [[TSModelViewController alloc] init];
    
//    UIView *fromSnapshot = [self.view snapshotViewAfterScreenUpdates:NO];
//    toViewController.fromView = fromSnapshot;
    
    [self.navigationController pushViewController:toViewController animated:YES];
}

-(void)rightButtonClick
{
    TSModelViewController *toViewController = [[TSModelViewController alloc] init];
    toViewController.transitioningDelegate = self;
    
    [self.navigationController presentViewController:toViewController animated:YES completion:nil];
}

#pragma mark - Transitioning Delegate (Modal)
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.pushNavAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.popNavAnimation;
}

#pragma mark - Navigation Controller Delegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:
            return self.pushNavAnimation;
            break;
        case UINavigationControllerOperationPop:
            return self.popNavAnimation;
            break;
            
        default:
            break;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return nil;
}
@end

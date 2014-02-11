//
//  TSModelViewController.m
//  Test
//
//  Created by ludawei on 14-2-10.
//  Copyright (c) 2014年 ludawei. All rights reserved.
//

#import "TSModelViewController.h"

@interface TSModelViewController ()

@property (nonatomic,weak) IBOutlet UIButton *button;

@end

@implementation TSModelViewController

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
    
    if (self.fromView) {
        [self.view addSubview:self.fromView];
        [self.view bringSubviewToFront:self.button];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickPopButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickDissButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

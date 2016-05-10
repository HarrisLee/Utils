//
//  ViewController.m
//  UncaughtExceptions
//
//  Created by JianRongCao on 5/10/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSelector:NSSelectorFromString(@"errorMessage") withObject:nil afterDelay:1.0];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

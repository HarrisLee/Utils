//
//  ViewController.m
//  Demo
//
//  Created by JianRongCao on 1/16/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import "ViewController.h"
#import <Libraries/Utils.h>
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[Utils shareInstance] showMessage:@"你好！"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

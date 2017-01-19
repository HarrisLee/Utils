//
//  SNViewController.m
//  Libraries
//
//  Created by JianRongCao on 1/19/17.
//  Copyright © 2017 JianRongCao. All rights reserved.
//

#import "SNViewController.h"

@interface SNViewController ()

@end

@implementation SNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *viewc = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    viewc.backgroundColor = [UIColor redColor];
    [viewc registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"12sss"];
    viewc.delegate = self;
    viewc.dataSource = self;
    [self.view addSubview:viewc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(100, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 60;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"12sss" forIndexPath:indexPath];
    CGFloat color = (arc4random()%10)/10.0;
    cell.backgroundColor = [UIColor colorWithWhite:color alpha:1.0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

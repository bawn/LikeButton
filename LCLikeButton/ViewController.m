//
//  ViewController.m
//  LCLikeButton
//
//  Created by bawn on 4/8/16.
//  Copyright © 2016 bawn. All rights reserved.
//

#import "ViewController.h"
#import "LCLikeButton.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) LCLikeButton *likeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeButton = [[LCLikeButton alloc] init];
    [self.view addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [self.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)likeButtonAction:(id)sender{
    self.likeButton.selected = !self.likeButton.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

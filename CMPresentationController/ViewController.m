//
//  ViewController.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/29.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "ViewController.h"
#import "FromViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FromViewController *vc = [[FromViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end

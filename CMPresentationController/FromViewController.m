//
//  FromViewController.m
//  CMPresentationController
//
//  Created by Liziqiang on 2019/9/30.
//  Copyright © 2019 Liziqiang. All rights reserved.
//

#import "FromViewController.h"
#import "ToViewController.h"
#import "CMPresentationController.h"


@interface FromViewController ()

@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];

    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 200, 40, 30)];
    [btn addTarget:self action:@selector(selectorpush) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];

}

- (void)selectorpush{
    ToViewController *vc = [[ToViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
    [self CMmodal:vc controllerHeight:500];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

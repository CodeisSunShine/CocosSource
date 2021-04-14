//
//  ViewController.m
//  Cocos_Study
//
//  Created by 宫傲 on 2021/4/12.
//

#import "ViewController.h"
#import "CCEAGLView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CCEAGLView *view = [[CCEAGLView alloc] init];
    [view setupGLContext];
}


@end

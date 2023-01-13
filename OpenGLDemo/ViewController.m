//
//  ViewController.m
//  OpenGLDemo
//
//  Created by haoshuai on 2021/9/16.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import "HSMapView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HSMapView *view = [HSMapView new];
    view.frame = UIScreen.mainScreen.bounds;
    [view draw:self.view];
    [self.view addSubview:view];
    // Do any additional setup after loading the view.
}





@end

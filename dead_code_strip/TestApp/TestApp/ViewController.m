//
//  ViewController.m
//  TestApp
//
//  Created by ZP on 2021/2/14.
//

#import "ViewController.h"
#import <HPStaticFramework/HPTestObject.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HPTestObject *hpObject = [HPTestObject new];
    [hpObject hp_test];
}


@end

//
//  ExampleListViewController.m
//  XJMapSDK_Demo
//
//  Created by zhangty on 2018/12/25.
//  Copyright © 2018 xunji. All rights reserved.
//

#import "ExampleListViewController.h"
#import <XJmapSDK/XJmapSDK.h>
#import "APIKey.h"
#import "ExampleLocationViewController.h"


@interface XJExample : NSObject
    
    @property (nonatomic, copy) NSString *title;
    @property (nonatomic, assign) SEL selector;
    
    @end


@implementation XJExample
    
+ (instancetype)exampleWithTitle:(NSString *)title selector:(SEL)selector {
    XJExample *example = [[self class] new];
    example.title = title;
    example.selector = selector;
    return example;
}
    
    @end

@interface ExampleListViewController ()<UITableViewDelegate, UITableViewDataSource>
    
    @property (nonatomic, strong)UITableView *tableView;
    @property (nonatomic, strong)NSArray *aryExample;
    
    @end

@implementation ExampleListViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"XJmapSDK";
    
    [self.view addSubview:self.tableView];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self.navigationController setNavigationBarHidden:YES];
}
    
- (void)mapExample {
    //设置需要分享的平台
//    [XJShareConfig showSharePlatforms:@[@(XJShareTypeWeChat), @(XJShareTypeQQ), @(XJShareTypeSMS)]];
    
    XJMapViewController *vc = [[XJMapViewController alloc] initWithMapId:(NSString *)MapId];
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (void)navigationExample {
    XJMapViewController *vc = [[XJMapViewController alloc] initWithMapId:(NSString *)MapId targetName:@"服务台" targetId:@"10000"];
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (void)locationExample {
    ExampleLocationViewController *vc = [[ExampleLocationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
    
    //- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 80;
    //}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.aryExample count];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"exampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    XJExample *example = [self.aryExample objectAtIndex:indexPath.row];
    cell.textLabel.text = example.title;
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XJExample *example = [self.aryExample objectAtIndex:indexPath.row];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}
    
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44) style:UITableViewStylePlain];
        _tableView.rowHeight = 80;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
    
- (NSArray *)aryExample {
    if (_aryExample == nil) {
        _aryExample = @[[XJExample exampleWithTitle:@"显示地图" selector:@selector(mapExample)],
                        [XJExample exampleWithTitle:@"导航到具体位置" selector:@selector(navigationExample)],
                        [XJExample exampleWithTitle:@"判断是否在地图内" selector:@selector(locationExample)],];
    }
    return _aryExample;
}
    
    @end

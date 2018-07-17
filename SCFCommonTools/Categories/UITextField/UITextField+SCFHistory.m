//
//  UITextField+SCFHistory.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/28.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UITextField+SCFHistory.h"
#import <objc/runtime.h>

#define history_x(view) (view.frame.origin.x)
#define history_y(view) (view.frame.origin.y)
#define history_w(view) (view.frame.size.width)
#define history_h(view) (view.frame.size.height)

#define ANIMATION_DURATION 0.3f
#define ITEM_HEIGHT 40.0f
#define CLEAR_BUTTON_HEIGHT 45.0f
#define MAX_HEIGHT 300.0f

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryViewIdentifyKey;

@interface UITextField ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *historyTableView;

@end

@implementation UITextField (SCFHistory)

#pragma mark - public methods
- (NSArray *)loadHistory {
    if (!self.identify) {
        return nil;
    }
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"UITextField+SCFHistory"];
    if (dic) {
        return [dic objectForKey:self.identify];
    }
    
    return nil;
}

- (void)synchronize {
    if (!self.identify || self.text.length <= 0) {
        return;
    }
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"UITextField+SCFHistory"];
    NSArray *histories = [dic objectForKey:self.identify];
    
    NSMutableArray *mutHistories = [NSMutableArray arrayWithArray:histories];
    
    __block BOOL haveSameRecord = NO;
    __weak typeof(self) weakSelf = self;
    [mutHistories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([(NSString *)obj isEqualToString:weakSelf.text]) {
            *stop = YES;
            haveSameRecord = YES;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [mutHistories addObject:self.text];
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutDic setObject:mutHistories forKey:self.identify];
    
    [[NSUserDefaults standardUserDefaults] setObject:[mutDic copy] forKey:@"UITextField+SCFHistory"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)showHistory {
    NSArray *histories = [self loadHistory];
    
    if (!self.historyTableView.superview || !histories || histories.count <= 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(history_x(self),
                               history_y(self) + history_h(self) + 1,
                               history_w(self),
                               1);
    CGRect frame2 = CGRectMake(history_x(self),
                               history_y(self) + history_h(self) + 1,
                               history_w(self),
                               MIN(MAX_HEIGHT, ITEM_HEIGHT * histories.count + CLEAR_BUTTON_HEIGHT));
    
    self.historyTableView.frame = frame1;
    [self.superview addSubview:self.historyTableView];
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.historyTableView.frame = frame2;
    }];
}

- (void)hideHistory {
    if (!self.historyTableView.superview) {
        return;
    }
    
    CGRect frame1 = CGRectMake(history_x(self),
                               history_y(self) + history_h(self) + 1,
                               history_w(self),
                               1);
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.historyTableView removeFromSuperview];
    }];
}

- (void)clearHistory {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"UITextField+SCFHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - private methods
- (void)clearHistoryButtonClick:(UIButton *)button {
    [self clearHistory];
    [self hideHistory];
}

#pragma mark - tableView datasource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self loadHistory].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self loadHistory][indexPath.row];
    
    return cell;
}
#pragma clang diagnostic pop

#pragma mark - tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.text = [self loadHistory][indexPath.row];
    [self hideHistory];
}

#pragma mark - setters / getters
- (void)setIdentify:(NSString *)identify {
    objc_setAssociatedObject(self,
                             &kTextFieldIdentifyKey,
                             identify,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (UITableView *)historyTableView {
    UITableView *tableView = objc_getAssociatedObject(self, &kTextFieldHistoryViewIdentifyKey);
    
    if (!tableView) {
        tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.layer.borderColor = [UIColor grayColor].CGColor;
        tableView.layer.borderWidth = 1.0f;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        
        objc_setAssociatedObject(self,
                                 &kTextFieldHistoryViewIdentifyKey,
                                 tableView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return tableView;
}


@end

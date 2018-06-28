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

#define scf_history_x(view) (view.frame.origin.x)
#define scf_history_y(view) (view.frame.origin.y)
#define scf_history_w(view) (view.frame.size.width)
#define scf_history_h(view) (view.frame.size.height)

#define SCF_ANIMATION_DURATION 0.3f
#define SCF_ITEM_HEIGHT 40.0f
#define SCF_CLEAR_BUTTON_HEIGHT 45.0f
#define SCF_MAX_HEIGHT 300.0f

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryViewIdentifyKey;

@interface UITextField ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *scf_historyTableView;

@end

@implementation UITextField (SCFHistory)

#pragma mark - public methods
- (NSArray *)scf_loadHistory {
    if (!self.scf_identify) {
        return nil;
    }
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"UITextField+SCFHistory"];
    if (dic) {
        return [dic objectForKey:self.scf_identify];
    }
    
    return nil;
}

- (void)scf_synchronize {
    if (!self.scf_identify || self.text.length <= 0) {
        return;
    }
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"UITextField+SCFHistory"];
    NSArray *histories = [dic objectForKey:self.scf_identify];
    
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
    [mutDic setObject:mutHistories forKey:self.scf_identify];
    
    [[NSUserDefaults standardUserDefaults] setObject:[mutDic copy] forKey:@"UITextField+SCFHistory"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)scf_showHistory {
    NSArray *histories = [self scf_loadHistory];
    
    if (!self.scf_historyTableView.superview || !histories || histories.count <= 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(scf_history_x(self),
                               scf_history_y(self) + scf_history_h(self) + 1,
                               scf_history_w(self),
                               1);
    CGRect frame2 = CGRectMake(scf_history_x(self),
                               scf_history_y(self) + scf_history_h(self) + 1,
                               scf_history_w(self),
                               MIN(SCF_MAX_HEIGHT, SCF_ITEM_HEIGHT * histories.count + SCF_CLEAR_BUTTON_HEIGHT));
    
    self.scf_historyTableView.frame = frame1;
    [self.superview addSubview:self.scf_historyTableView];
    
    [UIView animateWithDuration:SCF_ANIMATION_DURATION animations:^{
        self.scf_historyTableView.frame = frame2;
    }];
}

- (void)scf_hideHistory {
    if (!self.scf_historyTableView.superview) {
        return;
    }
    
    CGRect frame1 = CGRectMake(scf_history_x(self),
                               scf_history_y(self) + scf_history_h(self) + 1,
                               scf_history_w(self),
                               1);
    
    [UIView animateWithDuration:SCF_ANIMATION_DURATION animations:^{
        self.scf_historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.scf_historyTableView removeFromSuperview];
    }];
}

- (void)scf_clearHistory {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"UITextField+SCFHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - private methods
- (void)scf_clearHistoryButtonClick:(UIButton *)button {
    [self scf_clearHistory];
    [self scf_hideHistory];
}

#pragma mark - tableView datasource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self scf_loadHistory].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self scf_loadHistory][indexPath.row];
    
    return cell;
}
#pragma clang diagnostic pop

#pragma mark - tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(scf_clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCF_ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SCF_CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.text = [self scf_loadHistory][indexPath.row];
    [self scf_hideHistory];
}

#pragma mark - setters / getters
- (void)setScf_identify:(NSString *)scf_identify {
    objc_setAssociatedObject(self,
                             &kTextFieldIdentifyKey,
                             scf_identify,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)scf_identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (UITableView *)scf_historyTableView {
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

//
//  STScrollTabView.m
//  ScrollTabDemo
//
//  Created by Jasonzb on 16/3/23.
//  Copyright © 2016年 vx173. All rights reserved.
//

#import "STScrollTabView.h"
#import "STMacro.h"

@implementation STScrollTabView

@synthesize delegate;

// 选择了某个按钮
- (void)buttonDidClick:(UIButton *)sender {
    if ([self.scrollTabViewDelegate respondsToSelector:@selector(scrollTabView:didSelectedPage:)]) {
        [self.scrollTabViewDelegate scrollTabView:self didSelectedPage:[self.buttonArray indexOfObject:sender]];
    }
}

// 设置索引
- (void)setTabIndex:(CGFloat)index {
    NSInteger firstIndex = (NSInteger)index;
    CGFloat firstScale = index - firstIndex;
    NSInteger secondIndex = -1;
    if (firstScale > 0) {
        secondIndex = firstIndex + 1;
    }
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * __nonnull stop) {
        if (idx == firstIndex) {
            UIColor *color = RGBA(230 - (firstScale * 230), 153 - (firstScale * 153), 153 - (firstScale * 153), 1);
            [button setTitleColor:color forState:UIControlStateNormal];
            button.transform = CGAffineTransformMakeScale(1.2 - firstScale * 0.1, 1.2 - firstScale * 0.1);
        } else if (idx == secondIndex) {
            UIColor *color = RGBA(0 + (firstScale * 230), 0 + (firstScale * 153), 0 + (153 * firstScale), 1);
            [button setTitleColor:color forState:UIControlStateNormal];
            button.transform = CGAffineTransformMakeScale(1.0 + firstScale * 0.2, 1.0 + firstScale * 0.2);
        } else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }
    }];
}

- (void)scrollToCenterWithIndex:(NSUInteger)index {
    if (index > 2 && index < self.buttonArray.count - 2) {
        [self setContentOffset:CGPointMake((index - 2) * 80, 0) animated:YES];
    } else if (index <= 2) {
        [self setContentOffset:CGPointZero animated:YES];
    } else {
        CGPoint bottomOffset = CGPointMake(self.contentSize.width - self.bounds.size.width, 0);
        [self setContentOffset:bottomOffset animated:YES];
    }
}

- (NSArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [[NSArray alloc] init];
    }
    return _buttonArray;
}

@end

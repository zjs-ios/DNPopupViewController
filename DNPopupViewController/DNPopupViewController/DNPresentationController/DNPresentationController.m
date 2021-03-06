//
//  DNPresentationController.m
//  DNPopupViewController
//
//  Created by zjs on 2018/9/30.
//  Copyright © 2018 zjs. All rights reserved.
//

#import "DNPresentationController.h"


#define SCREEN_W    [UIScreen mainScreen].bounds.size.width
#define SCREEN_H    [UIScreen mainScreen].bounds.size.height

@interface DNPresentationController ()
{
    CGFloat positionX;
    CGFloat positionY;
}

@end

@implementation DNPresentationController

- (void)containerViewWillLayoutSubviews {

    [super containerViewWillLayoutSubviews];
    
    self.presentedView.layer.cornerRadius = 6.f;
    
    if (self.contrllerPosition == DNPresentationControllerPositionCenter) {
        self.presentedView.frame = CGRectMake(SCREEN_W*0.5-self.controlSize.width*0.5,
                                              SCREEN_H*0.5-self.controlSize.height*0.5,
                                              self.controlSize.width,
                                              self.controlSize.height);
        
    } else if (self.contrllerPosition == DNPresentationControllerPositionSheet) {
        self.presentedView.frame = CGRectMake(SCREEN_W*0.5-self.controlSize.width*0.5,
                                              SCREEN_H-self.controlSize.height,
                                              self.controlSize.width,
                                              self.controlSize.height);
        
    } else if (self.contrllerPosition == DNPresentationControllerPositionLeading) {
        self.presentedView.frame = CGRectMake(0, 0, self.controlSize.width, self.controlSize.height);
        
    } else if (self.contrllerPosition == DNPresentationControllerPositionTrailing) {
        self.presentedView.frame = CGRectMake(SCREEN_W-self.controlSize.width,
                                              0,
                                              self.controlSize.width,
                                              self.controlSize.height);
    } else {
        self.presentedView.frame = CGRectMake(self.controlPoint.x,
                                              self.controlPoint.y,
                                              self.controlSize.width,
                                              self.controlSize.height);
    }
    
    UITapGestureRecognizer * tapgesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(dismissClick)];
    [_bgLayerView addGestureRecognizer:tapgesture];
    
    [self.containerView insertSubview:self.bgLayerView atIndex:0];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    [self.bgLayerView removeFromSuperview];
}

- (void)dismissClick {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        [self.bgLayerView removeFromSuperview];
    }];
}

#pragma mark -------- Setter --------

- (void)setControlSize:(CGSize)controlSize {
    _controlSize = controlSize;
}

- (void)setContrllerPosition:(DNPresentationControllerPosition)contrllerPosition {
    _contrllerPosition = contrllerPosition;
}

#pragma mark -------- Getter --------

- (UIView *)bgLayerView {
    if (!_bgLayerView) {
        _bgLayerView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        _bgLayerView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];
        _bgLayerView.userInteractionEnabled = YES;
    }
    return _bgLayerView;
}

@end

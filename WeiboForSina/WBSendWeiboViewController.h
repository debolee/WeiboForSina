//
//  WBSendWeiboViewController.h
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "WBWeiboView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface WBSendWeiboViewController : UIViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *weiboTextView;
@property (strong, nonatomic) UIView *toolbarAccView;
@property (weak, nonatomic) IBOutlet UIImageView *weiboImageView;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (nonatomic, strong) WBWeibo *repostWeibo;

@property (weak, nonatomic) IBOutlet UIView *reWeiboView;
@property (weak, nonatomic) IBOutlet UITextView *reWeiboTextView;
@property (weak, nonatomic) IBOutlet UIImageView *reWeiboImageView;
@end

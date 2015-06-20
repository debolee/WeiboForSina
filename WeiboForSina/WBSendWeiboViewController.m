//
//  WBSendWeiboViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBSendWeiboViewController.h"

@interface WBSendWeiboViewController ()

@end

@implementation WBSendWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    创建inputAccessoryView
    if (!self.repostWeibo) {
        self.toolbarAccView = [[UIView alloc]init];
        self.toolbarAccView.backgroundColor = [UIColor clearColor];
        self.toolbarAccView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 62);
        
        //显示位置按钮
        UIButton *locationButton = [[UIButton alloc]init];
        locationButton.frame = CGRectMake(8, 0, 60, 20);
        [locationButton setTitle:@"显示位置" forState:UIControlStateNormal];
        [locationButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [locationButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        locationButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
        locationButton.layer.cornerRadius = 10;
        locationButton.layer.masksToBounds = YES;
        
        //是否公开按钮
        UIButton *pubButton = [[UIButton alloc]init];
        pubButton.frame = CGRectMake(252, 0, 60, 20);
        [pubButton setTitle:@"公开" forState:UIControlStateNormal];
        [pubButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [pubButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [pubButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        pubButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
        pubButton.layer.cornerRadius = 10;
        pubButton.layer.masksToBounds = YES;
        
        UIView *toolBarView =[[UIView alloc]initWithFrame:CGRectMake(0, 22, self.view.bounds.size.width, 40)];
        toolBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
        
        UIButton *pictureButton = [[UIButton alloc]init];
        pictureButton.frame = CGRectMake(8, 0, 40, 40);
        [pictureButton setImage:[UIImage imageNamed:@"toolbar_send_picturebutton"] forState:UIControlStateNormal];
        [pictureButton setImage:[UIImage imageNamed:@"toolbar_send_picturebutton_selected"] forState:UIControlStateHighlighted];
        [pictureButton addTarget:self action:@selector(pictureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBarView addSubview:pictureButton];
        
        [self.toolbarAccView addSubview:locationButton];
        [self.toolbarAccView addSubview:pubButton];
        [self.toolbarAccView addSubview:toolBarView];
        self.weiboTextView.inputAccessoryView = self.toolbarAccView;
    } else {
        self.reWeiboView.hidden = NO;
        self.reWeiboTextView.text = self.repostWeibo.text;
        [self.reWeiboImageView sd_setImageWithURL:[NSURL URLWithString:self.repostWeibo.thumbnailImage] placeholderImage:[UIImage imageNamed:@"placeholder_picture"]];
    }

    
    [self.weiboTextView becomeFirstResponder];
}


/**
 *  如果设备的sourceType同时支持相机拍照和相册，则弹出一个UIActionSheet让用户选择，如果只支持其中一种sourceType,则直接弹出相应的视图控制器
 *
 *  @param button 点击的按钮对象
 */
- (void)pictureButtonClick:(UIButton *)button {
    
    UIActionSheet *sheetView;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
        imagePickerVC.delegate = self;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    } else {
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
        imagePickerVC.delegate = self;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    }
    

    [sheetView showInView:self.view];

}

- (IBAction)addButtonClick:(UIButton *)sender {
    [self pictureButtonClick:sender];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
    switch (buttonIndex) {
        case 0:
            NSLog(@"0000000000");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            break;
        case 1:
            NSLog(@"11111111111");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:imagePickerVC animated:YES completion:nil];
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.weiboImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.weiboImageView setHidden:NO];
    [self.addImageButton setHidden:NO];
    [self.weiboTextView becomeFirstResponder];
}

- (IBAction)cannelButtonClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  点击按钮使用新浪微博官方SDK中的方法发送带一张图片的微博
 *
 *  @param sender 当前点击的按钮对象
 */
- (IBAction)sendButtonClick:(UIBarButtonItem *)sender {
    NSString *statusText = self.weiboTextView.text;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    if (!self.repostWeibo) {
        WBImageObject *imageObj= [[WBImageObject alloc]init];
        imageObj.imageData = UIImageJPEGRepresentation(self.weiboImageView.image, 1);

        [WBHttpRequest requestForShareAStatus:statusText contatinsAPicture:imageObj orPictureUrl:nil withAccessToken:accessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
            NSLog(@"微博发送成功。。。httpRequest :%@", httpRequest);
        }];
    } else {
        NSString *statusID = self.repostWeibo.weiboId;
        [WBHttpRequest requestForRepostAStatus:statusID repostText:statusText withAccessToken:accessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
            NSLog(@"微博转发成功。。。。httpRequest :%@", httpRequest);
        }];
        
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

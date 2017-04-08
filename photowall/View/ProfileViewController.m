//
//  ProfileViewController.m
//  photowall
//
//  Created by Spirit on 4/2/17.
//  Copyright © 2017 Picowork. All rights reserved.
//

#import "ProfileViewController.h"

#import "User.h"

@implementation ProfileViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.nicknameField.text = self.accountManager.me.nickname;
	[self.rootViewController setTitle:@"Profile"];
}

- (IBAction)changePortraitButtonPressed:(id)sender {
	UIImagePickerController* picker = [UIImagePickerController new];
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	picker.delegate = self;
	[self.rootViewController presentViewController:picker animated:YES completion:nil];
}

- (IBAction)updateButtonPressed:(id)sender {
	self.accountManager.editDelegate = self;
	[self.accountManager changeNickname:self.nicknameField.text];
}

- (IBAction)textFieldValueChanged:(id)sender {
	BOOL notEmpty = self.nicknameField.text.length > 0;
	BOOL hasChange = notEmpty && ![self.nicknameField.text isEqualToString:self.accountManager.me.nickname];
	[self.updateButton setEnabled:hasChange];
}

- (IBAction)logoutButtonPressed:(id)sender {
	[self.accountManager logout];
}

- (void)accountUpdated {
	self.nicknameField.text = self.accountManager.me.nickname;
	[self.updateButton setEnabled:NO];
}

- (void)updateFailed:(NSError*)error {
	
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString*, id> *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	UIImage* image = [info valueForKey:UIImagePickerControllerOriginalImage];
	NSData* pngData = UIImagePNGRepresentation(image);
	[self.accountManager changePortrait:pngData];
}

@end

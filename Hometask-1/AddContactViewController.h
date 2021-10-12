//
//  AddContactViewController.h
//  Hometask-1
//
//  Created by Aliaksei Safronau EPAM on 17.08.21.
//

#import <UIKit/UIKit.h>
@class ContactInfo;

@interface AddContactViewController : UIViewController

- (instancetype _Nonnull)initWithContact:(nullable ContactInfo *)contact;

@end

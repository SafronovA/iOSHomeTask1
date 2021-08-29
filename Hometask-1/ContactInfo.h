//
//  ContactItem.h
//  Hometask-1
//
//  Created by Aliaksei Safronau EPAM on 16.08.21.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

- (instancetype)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName;

@end

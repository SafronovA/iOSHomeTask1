//
//  ContactItem.m
//  Hometask-1
//
//  Created by Aliaksei Safronau EPAM on 16.08.21.
//

#import "ContactInfo.h"

@implementation ContactInfo

- (instancetype)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName {
    self = [self init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
    }
    return self;
}

@end

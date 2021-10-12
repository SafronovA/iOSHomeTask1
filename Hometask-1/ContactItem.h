//
//  ContactItem.h
//  Hometask-1
//
//  Created by Aliaksei Safronau EPAM on 16.08.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactInfo : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

- (instancetype)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName;

@end

NS_ASSUME_NONNULL_END

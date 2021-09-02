//
//  AddContactViewController.m
//  Hometask-1
//
//  Created by Aliaksei Safronau EPAM on 17.08.21.
//

#import "AddContactViewController.h"
#import "ContactInfo.h"

// MARK: - AddContactViewController
@interface AddContactViewController ()

@property (strong, nonatomic, nullable) ContactInfo *contact;
@property (strong, nonatomic) UITextField *firstName;
@property (strong, nonatomic) UITextField *lastName;
@property (strong, nonatomic) UIButton *add;
@property (weak, nonatomic) NSLayoutConstraint *firstNameTopAnchor;
@property (weak, nonatomic) NSLayoutConstraint *lastNameTopAnchor;
@property (weak, nonatomic) NSLayoutConstraint *addTopAnchor;

@end

// MARK: - Keyboard category
@interface AddContactViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents;
- (void)updateTopContraintWith:(CGFloat)constant andVerticalMargin:(CGFloat)margin;
- (void)hideWhenTappedAround;
@end

// MARK: - AddContactViewController
@implementation AddContactViewController

- (instancetype)initWithContact:(nullable ContactInfo *)contact{
    self = [self init];
    if (self) {
        _contact = contact;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupNavigationBar];
    [self setupFirstNameField];
    [self setupLastNameField];
    [self setupAddButton];
    [self fillInContactData];
    
    // Subscrube on keyboard events
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Title";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(goBack)];
}

- (void)setupFirstNameField {
    self.firstName = [UITextField new];
    self.firstName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.firstName.autocorrectionType = UITextAutocorrectionTypeNo;
    self.firstName.placeholder = @"First name";
    self.firstName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.firstName.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.firstName];
    self.firstName.translatesAutoresizingMaskIntoConstraints = NO;
    self.firstName.layer.cornerRadius = 5;
    self.firstName.layer.borderWidth = 1.5;
    self.firstNameTopAnchor = [self.firstName.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:150];
    [NSLayoutConstraint activateConstraints:@[
        [self firstNameTopAnchor],
        [self.firstName.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50],
        [self.firstName.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50],
        [self.firstName.heightAnchor constraintEqualToConstant:40]
    ]];
    
}

- (void)setupLastNameField {
    self.lastName = [UITextField new];
    self.lastName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.lastName.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lastName.placeholder = @"Last name";
    self.lastName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.lastName.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.lastName];
    self.lastName.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastName.layer.cornerRadius = 5;
    self.lastName.layer.borderWidth = 1.5;
    self.lastNameTopAnchor = [self.lastName.topAnchor constraintEqualToAnchor:self.firstName.bottomAnchor constant:30];
    [NSLayoutConstraint activateConstraints:@[
        [self lastNameTopAnchor],
        [self.lastName.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:50],
        [self.lastName.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-50],
        [self.lastName.heightAnchor constraintEqualToConstant:40]
    ]];
}

- (void)setupAddButton {
    self.add = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.add addTarget:self
                 action:@selector(addContact)
       forControlEvents:UIControlEventTouchDown];
    [self.add setTitle:@"Add" forState:UIControlStateNormal];
    self.add.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.view addSubview:self.add];
    self.add.translatesAutoresizingMaskIntoConstraints = NO;
    self.add.layer.cornerRadius = 20;
    self.add.layer.borderWidth = 2;
    self.addTopAnchor = [self.add.topAnchor constraintEqualToAnchor:self.lastName.bottomAnchor constant:30];
    [NSLayoutConstraint activateConstraints:@[
        [self addTopAnchor],
        [self.add.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.add.heightAnchor constraintEqualToConstant:50],
        [self.add.widthAnchor constraintEqualToConstant:200]
    ]];
}

- (void)fillInContactData{
    if (self.contact) {
        self.firstName.text = self.contact.firstName;
        self.lastName.text = self.contact.lastName;
    }
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hide {
    [self.view endEditing:YES];
}

- (void)addContact {
    [self hide];
}

@end

// MARK: - Keyboard category
@implementation AddContactViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
    // Keyboard will show
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)keybaordWillShow:(NSNotification *)notification {
    if ([self isLandscape]) {
        [self updateTopContraintWith:50.0 andVerticalMargin:10.0];
    }
}

- (void)keybaordWillHide:(NSNotification *)notification {
    if ([self isLandscape]) {
        [self updateTopContraintWith:150.0 andVerticalMargin:30.0];
    }
}

- (void)updateTopContraintWith:(CGFloat)constant andVerticalMargin:(CGFloat)margin{
    self.firstNameTopAnchor.constant = constant;
    self.lastNameTopAnchor.constant = margin;
    self.addTopAnchor.constant = margin;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (BOOL)isLandscape{
    return UIDeviceOrientationIsLandscape(UIDevice.currentDevice.orientation);
}

@end

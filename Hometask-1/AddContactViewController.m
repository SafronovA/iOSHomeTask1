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
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *firstName;
@property (strong, nonatomic) UITextField *lastName;
@property (strong, nonatomic) UIButton *add;
//@property (strong, nonatomic) void (^setScrollViewContentSize)(void);

@end

// MARK: - Keyboard category
@interface AddContactViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents;
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
    
    [self setupScrollView];
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

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    //            __weak __typeof(self) weakSelf = self;
    //            self.setScrollViewContentSize = ^(void){
    //                __strong __typeof(self) strongSelf = weakSelf;
    //                 [strongSelf.scrollView setContentSize:CGSizeMake(strongSelf.view.frame.size.width, strongSelf.view.frame.size.height)];
    //            };
    //            self.setScrollViewContentSize();
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView setBackgroundColor:UIColor.yellowColor];
    [self.view addSubview:self.scrollView];
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.scrollView.widthAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.widthAnchor],
        [self.scrollView.heightAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.heightAnchor]
    ]];
}

- (void)setupFirstNameField {
    self.firstName = [UITextField new];
    self.firstName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.firstName.autocorrectionType = UITextAutocorrectionTypeNo;
    self.firstName.placeholder = @"First name";
    self.firstName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.firstName.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:self.firstName];
    self.firstName.translatesAutoresizingMaskIntoConstraints = NO;
    self.firstName.layer.cornerRadius = 5;
    self.firstName.layer.borderWidth = 1.5;
    [NSLayoutConstraint activateConstraints:@[
        [self.firstName.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:100],
        [self.firstName.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.firstName.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.firstName.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8],
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
    [self.scrollView addSubview:self.lastName];
    self.lastName.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastName.layer.cornerRadius = 5;
    self.lastName.layer.borderWidth = 1.5;
    [NSLayoutConstraint activateConstraints:@[
        [self.lastName.topAnchor constraintEqualToAnchor:self.firstName.bottomAnchor constant:30],
        [self.lastName.widthAnchor constraintEqualToAnchor:self.firstName.widthAnchor],
        [self.lastName.heightAnchor constraintEqualToAnchor:self.firstName.heightAnchor],
        [self.lastName.centerXAnchor constraintEqualToAnchor:self.firstName.centerXAnchor]
    ]];
}

- (void)setupAddButton {
    self.add = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.add addTarget:self
                 action:@selector(addContact)
       forControlEvents:UIControlEventTouchDown];
    [self.add setTitle:@"Add" forState:UIControlStateNormal];
    self.add.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.scrollView addSubview:self.add];
    self.add.translatesAutoresizingMaskIntoConstraints = NO;
    self.add.layer.cornerRadius = 20;
    self.add.layer.borderWidth = 2;
    [NSLayoutConstraint activateConstraints:@[
        [self.add.topAnchor constraintEqualToAnchor:self.lastName.bottomAnchor constant:30],
        [self.add.centerXAnchor constraintEqualToAnchor:self.lastName.centerXAnchor],
        [self.add.heightAnchor constraintEqualToConstant:50],
        [self.add.widthAnchor constraintEqualToConstant:200],
        [self.add.bottomAnchor constraintLessThanOrEqualToAnchor:self.scrollView.contentLayoutGuide.bottomAnchor]
    ]];
}

- (void)fillInContactData{
    if (self.contact) {
        self.firstName.text = self.contact.firstName;
        self.lastName.text = self.contact.lastName;
    }
}

//-(void) traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
//        self.setScrollViewContentSize();
//}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hide {
    [self.scrollView endEditing:YES];
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
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hide)];
    [self.scrollView addGestureRecognizer:gesture];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    int keyboardHeight = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, keyboardHeight - self.view.safeAreaInsets.bottom + 10, 0)];
    
    CGRect firstResponderRect = self.firstName.isFirstResponder? self.firstName.frame: self.lastName.frame;
    [self.scrollView setContentOffset:CGPointMake(0, (self.scrollView.safeAreaLayoutGuide.layoutFrame.origin.y + firstResponderRect.origin.y - (self.scrollView.frame.size.height - keyboardHeight) + firstResponderRect.size.height + 10)) animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end

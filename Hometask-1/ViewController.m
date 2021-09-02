//
//  ViewController.m
//  Hometask-1
//
//  Created by Aliaksei Safronau EPAM on 16.08.21.
//

#import "ViewController.h"
#import "ContactInfo.h"
#import "AddContactViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<ContactInfo *> *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillInitialDataSource];
    [self setupNavigationBar];
    [self setupTableView];
}

#pragma mark - Setup Views

- (void) setupNavigationBar {
    self.navigationItem.title = @"Contact Info";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addContact)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void) setupTableView {
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:self.tableView];
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    ContactInfo *contact = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContactInfo *contact = self.dataSource[indexPath.row];
    [self navigateToAddContactVC:contact];
}

#pragma mark - Handlers

- (void)addContact {
    [self navigateToAddContactVC:nil];
}

- (void) navigateToAddContactVC:(nullable ContactInfo *) contactInfo {
    AddContactViewController *addContactViewController = [[AddContactViewController alloc] initWithContact:contactInfo];
    [self.navigationController pushViewController:addContactViewController animated:YES];
}

#pragma mark - Data source init

- (void)fillInitialDataSource {
    self.dataSource = [NSMutableArray arrayWithArray:@[
        [[ContactInfo alloc] initWithFirstName:@"Aliaksei" andLastName:@"Safronau"],
        [[ContactInfo alloc] initWithFirstName:@"Diana" andLastName:@"Tynkovan"]
    ]];
}
@end

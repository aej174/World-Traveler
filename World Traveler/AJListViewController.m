//
//  AJListViewController.m
//  World Traveler
//
//  Created by Allan Jones on 8/19/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import "AJListViewController.h"
#import "AJFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"

static NSString *const kCLIENTID = @"VBFKYAPS32GOGN5HULNNA1CZ2SR4YVIMBQWI4UCWK0H4QJTD";
static NSString *const kCLIENTSECRET = @"FDYVPVWILLZS1PNPKEHLIYY34DWMY4XX0QKASKSD5IURQ0MJ";

@interface AJListViewController ()

@property (strong, nonatomic) NSArray *venues;

@end

@implementation AJListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AJFourSquareSessionManager *sessionManager = [AJFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [[AJFourSquareSessionManager sharedClient] GET:@"venues/search?ll=30.25,-97.75" parameters:@{@"client_id" : kCLIENTID, @"client_secret" : kCLIENTSECRET, @"v" : @"20140830"} success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSArray *venues = responseObject;
        self.venues = venues;
        //NSLog(@"Number of venues: %i", [self.venues count]);
        [self.tableView reloadData];
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Number of venues: %i", [self.venues count]);
    return [self.venues count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    
    return cell;
}


@end

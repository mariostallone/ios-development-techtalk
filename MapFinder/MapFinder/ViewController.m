//
//  ViewController.m
//  MapFinder
//
//  Created by Mario on 24/07/13.
//  Copyright (c) 2013 Compassites. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"

@interface ViewController ()
{
    NSMutableArray *_locationArray;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if(_locationArray==nil){
        _locationArray = [[NSMutableArray alloc] initWithArray:@[@"Bangalore"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addLocation:(id)sender {
    [_locationArray addObject:[_locationField text]];
    NSLog(@"Location Array : %@",_locationArray);
    [_locationField setText:@""];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_locationArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *reusableCell =[tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    if(reusableCell==nil){
        reusableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationCell"];
    }
    reusableCell.textLabel.text = (NSString*)[_locationArray objectAtIndex:indexPath.row];
    return reusableCell;
}

#pragma mark UITableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __block NSData *responseData = nil;
    __block UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{     
        NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@,India&sensor=false",[_locationArray objectAtIndex:indexPath.row]];
        NSURL *url = [NSURL URLWithString:urlString];
        responseData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: nil];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            MapViewController *mapViewController = [storyboard instantiateViewControllerWithIdentifier:@"MapView"];
            NSArray *locationArray = [[[jsonData valueForKey:@"results"] valueForKey:@"geometry"] valueForKey:@"location"];
            CLLocation *location = nil;
            if(locationArray==nil||[locationArray count]<=0) {
                location = [[CLLocation alloc] initWithLatitude:0 longitude:0];
            }
            else {
                location = [[CLLocation alloc] initWithLatitude:[[[locationArray objectAtIndex:0] valueForKey:@"lat"] longValue] longitude:[[[locationArray objectAtIndex:0] valueForKey:@"lng"] longValue]];
            }
            [spinner stopAnimating];
            mapViewController.location = location;
            mapViewController.place = [_locationArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:mapViewController animated:YES];
        });
    });
}

-(IBAction)hideKeyBoard:(id)sender{
    [_locationField resignFirstResponder];
}

@end

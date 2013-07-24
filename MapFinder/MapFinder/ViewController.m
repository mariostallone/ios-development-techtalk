//
//  ViewController.m
//  MapFinder
//
//  Created by Mario on 24/07/13.
//  Copyright (c) 2013 Compassites. All rights reserved.
//

#import "ViewController.h"

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
        _locationArray = [[NSMutableArray alloc] init];
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

-(IBAction)hideKeyBoard:(id)sender{
    [_locationField resignFirstResponder];
}

@end

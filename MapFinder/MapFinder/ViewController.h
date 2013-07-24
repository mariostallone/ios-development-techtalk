//
//  ViewController.h
//  MapFinder
//
//  Created by Mario on 24/07/13.
//  Copyright (c) 2013 Compassites. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addLocation:(id)sender;

@end

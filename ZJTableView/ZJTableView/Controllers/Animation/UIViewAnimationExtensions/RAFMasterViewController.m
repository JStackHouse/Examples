//
//  RAFMasterViewController.m
//  UIViewAnimationExtensions
//
//  Created by Rafal Sroka on 10/04/14.
//
//  License CC0.
//  This is free and unencumbered software released into the public domain.
//
//  Anyone is free to copy, modify, publish, use, compile, sell, or
//  distribute this software, either in source code form or as a compiled
//  binary, for any purpose, commercial or non-commercial, and by any means.
//


#import "RAFMasterViewController.h"
#import "RAFDetailViewController.h"


@implementation RAFMasterViewController


static NSIndexPath *selectedIndexPath = nil;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                         bundle:nil];
//    
//    RAFDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RAFDetailViewController"];
//    
//    vc.mode = (RAFDetailViewControllerMode)indexPath.row;
//    
//    [self.navigationController pushViewController:vc
//                                         animated:YES];
    selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"AnimationDetail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (segue.identifier && NSOrderedSame == [segue.identifier compare:@"AnimationDetail"])
    {
        RAFDetailViewController *detail = (RAFDetailViewController *)segue.destinationViewController;
        detail.mode = selectedIndexPath.row;
    }
}

@end
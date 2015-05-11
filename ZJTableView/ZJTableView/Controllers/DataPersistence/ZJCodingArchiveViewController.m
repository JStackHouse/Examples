//
//  ZJCodingArchiveViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-14.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJCodingArchiveViewController.h"



@interface ZJCodingArchiveViewController ()
{
    Book *book;
}
@property (strong, nonatomic) NSString *path;

//@property (strong, nonatomic) Book *book;

@end

@implementation ZJCodingArchiveViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//static Book *book = nil;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        book = [[Book alloc]init];
//    });

    switch (self.type) {
        case keyedArchiver:
        {
            self.path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/bookArchive"];
            NSLog(@"path is %@",self.path);

            NSFileManager *fileManager = [[NSFileManager alloc]init];
            BOOL isExist = [fileManager fileExistsAtPath:self.path];
            if (isExist)
            {
                book = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
                
                self.autherField.text = book.auther;
                self.priceField.text = [NSString stringWithFormat:@"%d",book.num];
                self.availableSeg.selectedSegmentIndex = (book.available == YES) ? 0 : 1;
            }
        }
            break;
        case keyedArchiverUserDefault:
        {
            NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"book"];
            book = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (book)
            {
                self.autherField.text = book.auther;
                self.priceField.text = [NSString stringWithFormat:@"%d",book.num];
                self.availableSeg.selectedSegmentIndex = (book.available == YES) ? 0 : 1;
            }
            else
            {
                self.autherField.text = @"";
                self.priceField.text = @"";
                self.availableSeg.selectedSegmentIndex = 1;
            }
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonClick:(id)sender
{
    if (nil == book)
    {
        book = [[Book alloc]init];
    }
    book.auther = self.autherField.text;
    book.num = [self.priceField.text integerValue];
    book.available = (0 == self.availableSeg.selectedSegmentIndex) ? YES : NO;
    
    switch (self.type) {
        case keyedArchiver:
        {
            [NSKeyedArchiver archiveRootObject:book toFile:self.path];
        }
            break;
        case keyedArchiverUserDefault:
        {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:book];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"book"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation Book

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.auther = nil == [aDecoder decodeObjectForKey:@"auther"] ? @"xxAuther" : [aDecoder decodeObjectForKey:@"auther"];
        self.num = [aDecoder decodeIntegerForKey:@"num"];
        self.available = [aDecoder decodeBoolForKey:@"available"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.auther forKey:@"auther"];
    [aCoder encodeInteger:self.num forKey:@"num"];
    [aCoder encodeBool:self.available forKey:@"available"];
}

@end

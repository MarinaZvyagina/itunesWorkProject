//
//  ViewController.m
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "ViewController.h"
#import "IWPSongList.h"
#import "IWPDataBase.h"
#import "IWPNetworkDataBase.h"
#import "IWPSong.h"
#import "IWPCell.h"
@import Masonry;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>//., UISearchResultsUpdating>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) IWPSongList * songs;
@property (nonatomic, strong) id<IWPDataBase> songManager;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ViewController

static IWPSongList * staticContacts;
+ (IWPSongList *) staticContacts
{ @synchronized(self) { return staticContacts; } }
+ (void) setstaticContacts:(IWPSongList *)val
{ @synchronized(self)
    { staticContacts = val; } }


- (void)viewDidLoad {
    staticContacts = [IWPSongList new];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.searchController = [UISearchController new];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
   // CGFloat * height = self.searchController.searchBar.frame.size.height;
    self.tableView.contentOffset = CGPointMake(0, self.searchController.searchBar.frame.size.height);     
    

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.songManager = [IWPNetworkDataBase new];
    NSString * text = self.searchController.searchBar.text;

    
    self.songs=[self.songManager getSongs:text withUpdate:self.songs];
    staticContacts = self.songs;
    [self.tableView registerClass:[IWPCell class] forCellReuseIdentifier:IWPCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return staticContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (IWPCell *)[tableView dequeueReusableCellWithIdentifier:IWPCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[IWPCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IWPCellIdentifier];
    }
    IWPSong * song = [staticContacts objectAtIndexedSubscript:indexPath.row];
    [(IWPCell *)cell addArtist:song];
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IWPSong * song = [self.songs objectAtIndexedSubscript:indexPath.row];

}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

/*
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString * text = self.searchController.searchBar.text;
    [self.songManager getSongs:text withUpdate:self.songs];
}*/
@end

//
//  IWPCell.m
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "IWPCell.h"
#import "IWPSong.h"
@import Masonry;

NSString *const IWPCellIdentifier = @"IWPCellIdentifier";

@interface IWPCell()
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * artist;
@property (nonatomic, strong) UIImageView * songImage;
@property (nonatomic, strong) UILabel * price;

@end

@implementation IWPCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self createSubviews];
    }
    return self;
}

-(void) loadImage: (NSString *) url {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:url];
                       __block NSData *imageData;
                       
                       dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                     ^{
                                         imageData = [NSData dataWithContentsOfURL:imageURL];
                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                             __strong typeof(self) strongSelf = weakSelf;
                                             if (strongSelf) {
                                                 strongSelf.songImage.image = [UIImage imageWithData:imageData];
                                             }
                                         });
                                     });
                   });
}

-(void) addAllSubviews {
    [self addSubview:self.name];
    [self addSubview:self.artist];
    [self addSubview:self.songImage];
    [self addSubview:self.price];
}

-(void)setTextAlignmentForAllFields {
    [self.name setTextAlignment:NSTextAlignmentCenter];
    [self.artist setTextAlignment:NSTextAlignmentCenter];
    [self.price setTextAlignment:NSTextAlignmentCenter];
}

-(void)createSubviews {
    self.songImage = [UIImageView new];
    self.name = [UILabel new];
    self.artist = [UILabel new];
    self.price = [UILabel new];
    [self addAllSubviews];
    [self makeConstrantsForView:self.songImage WithLeft:self.mas_left Top:self.mas_top Right:self.name.mas_left AndBottom:self.mas_bottom];
    [self.songImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(3);
        make.width.equalTo(@45);
        make.bottom.equalTo(self.mas_bottom).with.offset(-3);
        make.height.equalTo(@45);
    }];
    
    self.songImage.layer.cornerRadius = self.frame.size.height / 2;
    self.songImage.clipsToBounds = YES;
    
    [self setTextAlignmentForAllFields];
    
    [self makeConstrantsForView:self.name WithLeft:self.songImage.mas_right Top:self.mas_top Right:self.artist.mas_left AndBottom:self.mas_bottom];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@100).width.priorityHigh();
    }];
    [self makeConstrantsForView:self.artist WithLeft:self.name.mas_right Top:self.mas_top Right:self.price.mas_left AndBottom:self.mas_bottom];
    [self makeConstrantsForView:self.price WithLeft:self.artist.mas_right Top:self.mas_top Right:self.mas_right AndBottom:self.mas_bottom];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@50);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
}

-(void)makeConstrantsForView:(UIView *)view WithLeft: (MASConstraint *)left Top:(MASConstraint *)top Right:(MASConstraint *)right AndBottom:(MASConstraint *)bottom {
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left);
        make.top.equalTo(top);
        make.right.equalTo(right);
        make.bottom.equalTo(bottom);
    }];
}

- (void)addArtist:(IWPSong *)song {
    self.name.text = song.trackName;
    self.artist.text = song.artist;
    self.price.text = song.price.description;
    
    NSString * initUrl = song.urlForPicture ? song.urlForPicture : @"https://lh3.googleusercontent.com/-NmcPm_QhFzw/AAAAAAAAAAI/AAAAAAAAAAA/AHalGho6R0sfDXYGc7TOb35Svg_uk5h6Ug/mo/photo.jpg?sz=46";
    [self loadImage:initUrl];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end

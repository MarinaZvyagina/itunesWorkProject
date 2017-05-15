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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:url];
                       __block NSData *imageData;
                       
                       dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                     ^{
                                         imageData = [NSData dataWithContentsOfURL:imageURL];
                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                             self.songImage.image = [UIImage imageWithData:imageData];
                                         });
                                     });
                   });
}

-(void)createSubviews {
    self.songImage = [UIImageView new];
    self.name = [UILabel new];
    self.artist = [UILabel new];
    
    [self addSubview:self.name];
    [self addSubview:self.artist];
    [self addSubview:self.songImage];
    
    [self.songImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(3);
        make.width.equalTo(@40);
        make.bottom.equalTo(self.mas_bottom).with.offset(-3);
        make.height.equalTo(@40);
    }];
    
    self.songImage.layer.cornerRadius = self.frame.size.height / 2;
    self.songImage.clipsToBounds = YES;
    
    [self.name setTextAlignment:NSTextAlignmentCenter];
    [self.artist setTextAlignment:NSTextAlignmentCenter];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.songImage.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.artist.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.greaterThanOrEqualTo(@100).width.priorityHigh();
    }];
    
    [self.artist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.name.mas_width);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
}

- (void)addArtist:(IWPSong *)song {
    self.name.text = song.trackName;
    self.artist.text = song.artist;
    
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

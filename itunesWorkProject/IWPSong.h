//
//  IWPSong.h
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWPSong : NSObject

@property (nonatomic, strong) NSString * trackName;
@property (nonatomic, strong) NSString * artist;
@property (nonatomic, strong) NSString * album;
@property (nonatomic, strong) NSString * urlForPicture;
@property (nonatomic, strong) NSString * price;



@end

//
//  IWPSongList.h
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWPSong.h"

@interface IWPSongList : NSObject

@property(nonatomic, copy, readwrite) NSArray *songs;
- (instancetype)initWithArray:(NSArray< IWPSong *> *)songs;
- (NSUInteger)count ;
- (IWPSong*)objectAtIndexedSubscript:(NSUInteger)index;

@end

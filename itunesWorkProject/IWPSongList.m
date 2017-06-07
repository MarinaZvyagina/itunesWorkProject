//
//  IWPSongList.m
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "IWPSongList.h"

@implementation IWPSongList


- (instancetype)initWithArray:(NSArray< IWPSong *> *)songs {
    self = [super init];
    if (self) {
        self.songs = songs;
    }
    return self;
}

- (NSUInteger)count {
    return self.songs.count;
}

- (IWPSong*)objectAtIndexedSubscript:(NSUInteger)index {
    return self.songs[index];
}


@end

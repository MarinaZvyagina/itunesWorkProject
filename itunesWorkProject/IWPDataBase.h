//
//  IWPDataBase.h
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IWPSongList;
@protocol IWPDataBase <NSObject>


-(IWPSongList *)getSongs: (NSString *)artist withUpdate: (IWPSongList *)songs;
@end

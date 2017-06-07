//
//  IWPViewManager.h
//  itunesWorkProject
//
//  Created by Марина Звягина on 07.06.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWPSongList;

@protocol IWPViewManager <NSObject>
-(void)reloadViewWithNewSongs:(IWPSongList *)songs;
@end

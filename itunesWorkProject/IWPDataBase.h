//
//  IWPDataBase.h
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IWPSongList;
@protocol IWPViewManager;

@protocol IWPDataBase <NSObject>
-(void)getSongs: (NSString *)artist withManager: (id<IWPViewManager>)viewManager;
@end

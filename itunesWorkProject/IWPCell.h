//
//  IWPCell.h
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWPSong.h"
@import UIKit;

extern NSString *const IWPCellIdentifier;


@interface IWPCell : UITableViewCell

- (void)addArtist:(IWPSong *)song;

@end

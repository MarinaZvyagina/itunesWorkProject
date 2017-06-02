//
//  IWPNetworkDataBase.m
//  itunesWorkProject
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "IWPNetworkDataBase.h"
#import "IWPSongList.h"

@implementation IWPNetworkDataBase

-(NSString *)addPlusBetweenWords: (NSString *)artist {
    if (artist == nil )
        artist = @"";
    
    NSArray <NSString *> *terms = [NSArray new];
    terms = [artist componentsSeparatedByString:@" "];
    NSString * artistString = [NSString new];
    
    for (NSString *term in terms) {
        if (term.length >= 1) {
            artistString = [artistString stringByAppendingString:term];
            artistString = [artistString stringByAppendingString:@"+"];
        }
    }
    if (artistString.length > 0) {
        artistString = [artistString substringToIndex:artistString.length - 1];
    }
    return artistString;
}

-(IWPSongList *)getSongs: (NSString *)artist withUpdate: (IWPSongList *)songs  {
    NSString * artistString = [self addPlusBetweenWords:artist];
    __block NSMutableArray *resultSongs = [NSMutableArray new];
    NSString * stringWithoutArtist = @"https://itunes.apple.com/search?term=";
    NSString * stringWithArtist = [stringWithoutArtist stringByAppendingString:artistString];
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:stringWithArtist]];
    __block NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:nsurlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    responseData = data;
                }] resume];
  
    if ( responseData == nil ) {
        return [IWPSongList new];
    }
    NSDictionary * JSONObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
     
    IWPSong* (^createSong)(NSString *, NSString *, NSString *, NSString *, NSString *);
    createSong = ^IWPSong*(NSString *trackName,
                           NSString * artist,
                           NSString * album,
                           NSString * urlForPicture,
                           NSString * price) {
        IWPSong *song = [IWPSong new];
        song.trackName = trackName;
        song.artist = artist;
        song.album = album;
        song.urlForPicture = urlForPicture;
        song.price = price;
        return song;
    };
    
    NSDictionary * songss = [JSONObject objectForKey:@"results"];
    
    for (NSDictionary * object in songss ) {
        NSString *name = [object objectForKey:@"trackName"];
        NSString *artist = [object objectForKey:@"artistName"];
        NSString *album = [object objectForKey:@"collectionName"];
        NSString *urlForPicture = [object objectForKey:@"artworkUrl60"];
        NSString *price = [object objectForKey:@"trackPrice"];
        
        [resultSongs addObject:createSong(name, artist, album, urlForPicture, price)];
    }

    return [[IWPSongList alloc] initWithArray:resultSongs];
}


@end

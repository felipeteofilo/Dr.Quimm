//
//  DQControleUserDefalts.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 31/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQControleUserDefalts : NSObject

+(NSUserDefaults*)userDefalts;
+(float)volumeMusica;
+(float)volumeSons;
+(BOOL)sonsMudo;
+(BOOL)musicaMuda;
+(void)setVolumeMusica:(float)volume;
+(void)setVolumeSons:(float)volume;
+(void)setMusicaMuda:(BOOL)mudo;
+(void)setSonsMudo:(BOOL)mudo;

@end

//
//  DQControleUserDefalts.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 31/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQControleUserDefalts.h"

@implementation DQControleUserDefalts

+(NSUserDefaults*)userDefalts{
    return [NSUserDefaults standardUserDefaults];
}

+(float)volumeMusica{
    return [[self userDefalts]floatForKey:@"volumeMusica"];
}

+(float)volumeSons{
    return [[self userDefalts]floatForKey:@"volumeSons"];
}

+(BOOL)sonsMudo{
    return [[self userDefalts]boolForKey:@"somMudo"];
}

+(BOOL)musicaMuda{
    return [[self userDefalts]boolForKey:@"musicaMuda"];
}

+(void)setVolumeMusica:(float)volume{
    [[self userDefalts]setFloat:volume forKey:@"volumeMusica"];
}

+(void)setVolumeSons:(float)volume{
    [[self userDefalts]setFloat:volume forKey:@"volumeSons"];
}

+(void)setMusicaMuda:(BOOL)mudo{
    [[self userDefalts]setBool:mudo forKey:@"musicaMuda"];
}

+(void)setSonsMudo:(BOOL)mudo{
    [[self userDefalts]setBool:mudo forKey:@"somMudo"];
}

@end

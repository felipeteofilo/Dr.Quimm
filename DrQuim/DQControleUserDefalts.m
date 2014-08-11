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

+(NSDictionary*)estadosJogador{
    NSMutableDictionary *estadosJogador=[NSMutableDictionary dictionary];
    
    [estadosJogador setObject:[NSNumber numberWithFloat:[[self userDefalts]floatForKey:@"Vida"]] forKey:@"Vida"];
    [estadosJogador setObject:[NSNumber numberWithFloat:[[self userDefalts]floatForKey:@"Fome"]] forKey:@"Fome"];
    [estadosJogador setObject:[NSNumber numberWithFloat:[[self userDefalts]floatForKey:@"Sede"]] forKey:@"Sede"];
    [estadosJogador setObject:[NSNumber numberWithFloat:[[self userDefalts]floatForKey:@"Respeito"]] forKey:@"Respeito"];
    
    return estadosJogador;
}

+(int)faseAtual{
    return (int)[[self userDefalts]integerForKey:@"FaseAtual"];
}

+(int)parteFaseAtual{
    return (int)[[self userDefalts]integerForKey:@"parteAtual"];
}
+(NSString*)missaoAtualJogador{
    return [[self userDefalts]objectForKey:@"MissaoJogador"];
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
+(void)setEstadoJogadorVida:(float)vida Fome:(float)fome Sede:(float)sede Respeito:(float)respeito{
    [[self userDefalts]setFloat:vida forKey:@"Vida"];
    [[self userDefalts]setFloat:fome forKey:@"Fome"];
    [[self userDefalts]setFloat:sede forKey:@"Sede"];
    [[self userDefalts]setFloat:respeito forKey:@"Respeito"];
}
+(void)setFaseAtual:(int)fase{
    [[self userDefalts]setInteger:fase forKey:@"FaseAtual"];
}
+(void)setParteFaseAtual:(int)parte{
    [[self userDefalts]setInteger:parte forKey:@"ParteAtual"];
}

+(void)setMissaoAtualJogador:(NSString*)missaoAtual{
    [[self userDefalts]setObject:missaoAtual forKey:@"MissaoJogador"];
}
@end

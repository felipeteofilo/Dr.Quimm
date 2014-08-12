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
+(NSDictionary*)estadosJogador;
+(int)faseAtual;
+(int)parteFaseAtual;
+(NSString*)missaoAtualJogador;

+(void)setVolumeMusica:(float)volume;
+(void)setVolumeSons:(float)volume;
+(void)setMusicaMuda:(BOOL)mudo;
+(void)setSonsMudo:(BOOL)mudo;
+(void)setEstadoJogadorVida:(float)vida Fome:(float)fome Sede:(float)sede;
+(void)setFaseAtual:(int)fase;
+(void)setParteFaseAtual:(int)parte;
+(void)setMissaoAtualJogador:(NSString*)missaoAtual;

@end

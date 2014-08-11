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
+(BOOL)rodouCutSceneFase:(int)fase;

+(void)setVolumeMusica:(float)volume;
+(void)setVolumeSons:(float)volume;
+(void)setMusicaMuda:(BOOL)mudo;
+(void)setSonsMudo:(BOOL)mudo;
+(void)setEstadoJogadorVida:(float)vida Fome:(float)fome Sede:(float)sede Respeito:(float)respeito;
+(void)setFaseAtual:(int)fase;
+(void)setParteFaseAtual:(int)parte;
+(void)setMissaoAtualJogador:(NSString*)missaoAtual;
+(void)setRodouCutSceneFase:(int)fase Valor:(BOOL)valor;

+(BOOL)estadoJogadorAtualizado;
+(void)setEstadoInicialJogador:(BOOL)valor;
+(void)setEstadoInicialJogador;
@end

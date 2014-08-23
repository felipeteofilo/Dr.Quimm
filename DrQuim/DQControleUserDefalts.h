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
+(NSDictionary*)missaoAtualJogador;
+(NSMutableDictionary*)itensAtuaisJogador;
+(NSMutableArray*)armadilhasAtuaisJogador;
+(BOOL)rodouCutSceneFase:(int)fase;
+(BOOL)primeiraExecucaoDispositivo;
+(BOOL)estadoJogadorAtualizado;

+(void)setVolumeMusica:(float)volume;
+(void)setVolumeSons:(float)volume;
+(void)setMusicaMuda:(BOOL)mudo;
+(void)setSonsMudo:(BOOL)mudo;
+(void)setFaseAtual:(int)fase;
+(void)setParteFaseAtual:(int)parte;
+(void)setMissaoAtualJogador:(NSDictionary*)missaoAtual;
+(void)setItensAtuaisJogador:(NSDictionary*)inventario;
+(void)setArmadilhasAtuaisJogador:(NSArray*)armadilhas;
+(void)setRodouCutSceneFase:(int)fase Valor:(BOOL)valor;
+(void)setEstadoInicialJogador:(BOOL)valor;
+(void)setEstadoInicialJogador;
+(void)setEstadoJogadorVida:(float)vida Fome:(float)fome Sede:(float)sede Respeito:(float)respeito;
+(void)atualizarPrimeiraExecucao;
+(BOOL)falouCurandeiroCacadaCoelho;
+(void)setFalouCurandeiroCacadaCoelho:(BOOL)valor;
@end

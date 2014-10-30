//
//  DQCoreDataController.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 21/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQAppDelegate.h"
#import "Usuario.h"
#import "FaseConfigurada.h"

@interface DQCoreDataController : NSObject


+(Usuario*)procurarJogador :(NSString*)nome;
+(void)salvarVida:(int)vida respeito:(int)respeito fome:(int)fome sede:(int)sede doJogador:(NSString*)nome;
+(void)salvarItens :(NSDictionary*)itens doJogador:(NSString*)nome;
+(void)salvarArmadilhas :(NSMutableArray*)armadilhas doJogador:(NSString*)nome;
+(void)salvarMissao:(NSMutableDictionary*)missao doJogador:(NSString*)nome;
+(void)salvarFaseAtual:(int)fase parte:(int)parte doJogador:(NSString*)nome;
+(void)novaFaseID:(int)idFase comRequisitos:(NSArray*)requisitosFase;
+(FaseConfigurada*)procurarFase:(int)idFase;
+(int)nFasesCoreData;
+(NSArray*)pegarTodasFases;

@end

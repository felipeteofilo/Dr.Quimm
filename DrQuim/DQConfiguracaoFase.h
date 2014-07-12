//
//  DQConfiguracaoFase.h
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 05/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQConfiguracaoFase : NSObject

+(int)nPartesFase:(int)_fase;
+(NSString*)coberturaBackgroundParte:(int)_parte daFase:(int)_fase;
+(NSArray*)configParteFase:(int)_fase;
+(NSDictionary*)configParteFase:(int)_fase parte:(int)_parte;
+(NSArray*)arquivoPlist;
+(CGPoint)posicaoInicialJogadorFase:(int)_fase;
@end

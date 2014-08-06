//
//  DQFalasNoJogoControle.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 06/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQFala.h"

@interface DQFalasNoJogoControle : NSObject

@property DQFala * caixaDeFala;

@property NSMutableDictionary *dicionarioDeFalas;

@property int falaAtual;


-(id)initComFaseAtual:(int)faseAtual;
-(SKNode*)mostrarAlerta :(NSString*)key;
-(SKNode*)mostrarFala :(NSString*)npc :(NSString*)keyFala;
-(SKNode*)proximaFala;
-(void)fimFala;

@end

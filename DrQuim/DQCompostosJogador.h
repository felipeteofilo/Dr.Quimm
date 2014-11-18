//
//  DQCompostosJogador.h
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 18/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQCompostosJogador : NSObject

@property NSMutableDictionary *compostos;

-(void)receberComposto:(NSString*)composto quantidade:(int)quantidade;
-(void)perderComposto:(NSString*)composto quantidade:(int)quantidade;
-(NSArray*)arrayCompostosJogador;


@end

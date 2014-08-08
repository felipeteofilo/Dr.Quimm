//
//  DQMissao.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQMissao.h"

@implementation DQMissao

-(id)initMissao :(int)missao{
    if (self = [super init]) {
        NSString *caminhoArrayList =[[NSBundle mainBundle] pathForResource:@"Missoes" ofType:@"plist"];
        NSArray *arquivo =[NSArray arrayWithContentsOfFile:caminhoArrayList];
        
        self.nome = [arquivo objectAtIndex:missao]
        
        
    }
    return self;
    
}
-(Boolean)podePassarComNPC :(NSString*)nomeNPC Item:(NSString*)item;
-(Boolean)podeIniciarComNPC :(NSString*)nomeNPC;


@end

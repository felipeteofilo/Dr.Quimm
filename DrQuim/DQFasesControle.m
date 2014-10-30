//
//  DQFasesControle.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 24/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFasesControle.h"
#import "DQFase.h"

@implementation DQFasesControle

-(id)init{
    if (self = [super init]) {
        NSString *caminhoArquivo = [[NSBundle mainBundle] pathForResource:@"Fases" ofType:@"plist"];
        self.fases = [NSArray arrayWithContentsOfFile:caminhoArquivo];
    }
    return self;
}


+(id)sharedFasesControle
{
    static DQFasesControle *controlador= nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controlador = [[self alloc]init];
    });
    
    return controlador;
}


-(void)mudarDeFase :(int)fase Scene:(SKScene*)scene{
    SKScene *faseRetorno;
    
    for (int i = 0; i < self.fases.count ; i++) {
        if ([[[self.fases objectAtIndex:i]objectForKey:@"ID"]intValue] == fase) {
            NSString *nomeDaClasse = [[self.fases objectAtIndex:i]objectForKey:@"Nome"];
            faseRetorno = [[NSClassFromString(nomeDaClasse) alloc]initWithSize:scene.size];
            break;
        }
    }
    if (faseRetorno == nil) {
        faseRetorno = [[DQFase alloc]initFase:fase Size:scene.size];
    }
    
    [scene.view presentScene:faseRetorno];
}

@end

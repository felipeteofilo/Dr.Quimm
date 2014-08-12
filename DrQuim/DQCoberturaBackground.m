//
//  DQCoberturaBackground.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 15/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCoberturaBackground.h"

@implementation DQCoberturaBackground

-(id)initCoberturaParte:(int)_parte daFase:(int)_fase{
    NSDictionary *configCobertura=[DQConfiguracaoFase coberturaBackgroundParte:_parte daFase:_fase];
    NSString *nomeImagemCobertura;
    
    if (!configCobertura) {
        return nil;
    }else{
        nomeImagemCobertura =[configCobertura objectForKey:@"NomeImagem"];

        if ([nomeImagemCobertura length]==0) {
            return nil;
            
        }else{
            
            if (self=[super initWithImageNamed:nomeImagemCobertura]) {
                
                [self setTexture:[SKTexture textureWithImageNamed:nomeImagemCobertura]];
                
                CGPoint posInicial=CGPointFromString([configCobertura objectForKey:@"PosInicial"]);
                CGPoint posFinal=CGPointFromString([configCobertura objectForKey:@"PosFinal"]);
                
                //Salva a posFinal para verificar qndo o jogador estiver saindo da caverna
                NSMutableDictionary *dicionarioDadosNode=[NSMutableDictionary dictionaryWithObject:[NSValue valueWithCGPoint:posFinal] forKey:NomePosFinal];
                
                [self setName:NomeNodeCobertura];
                [self setAnchorPoint:CGPointMake(0, 0)];
                [self setPosition:posInicial];
                [self setZPosition:100];
                [self setUserData:dicionarioDadosNode];
                
                self.posFinal=CGPointFromString([configCobertura objectForKey:@"PosFinal"]);
            }
        }
    }
    return self;
}

//Será usado para dar fadeOut, na cobertura do background
-(void)manipulaCobertura:(CGPoint)posJogador{
    
//    //Fazer validacao da posicao jogador
//    NSLog(@"PosCobertura X:%f Y:%f",self.position.x,self.position.y);
    
    //Valida se esta dentro em X e em Y
    if ((posJogador.x >= self.position.x && posJogador.x < self.posFinal.x) && (posJogador.y >= self.position.y)){// && posJogador.y < self.posFinal.y))  {
        [self mostrarBackground];
    }
    
    if((posJogador.x > self.posFinal.x && posJogador.y > self.posFinal.y) || (posJogador.x < self.position.x && posJogador.y <= self.position.y)){
        [self esconderBackground];
    }
    
}

-(void)mostrarBackground{
    if (!self.hasActions) {
        SKAction *fadeOut=[SKAction fadeOutWithDuration:0.5];
        [self runAction:fadeOut withKey:@"fadeOut"];
    }
}

-(void)esconderBackground{
    if (self.hasActions) {
        SKAction *fadeIn=[SKAction fadeInWithDuration:0.5];
        [self runAction:fadeIn withKey:@"fadeIn"];
    }
}
@end

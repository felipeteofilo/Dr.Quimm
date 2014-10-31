//
//  DQAlertasControle.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 28/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQAlertasControle.h"
#import "DQFase.h"

@implementation DQAlertasControle


-(id)initComFaseAtual :(int)fase{
    if (self = [super init]) {
        
        self.arquivo = [DQConfiguracaoFase alertasFase:fase];
        self.referenciaAlertaAtual =0;
        if(self.arquivo != nil){
            self.alertaAtual = [self.arquivo objectAtIndex:self.referenciaAlertaAtual];
        }
    }
    return self;
}

-(void)atualizarAlerta :(SKScene*)cena{
    if(self.podeMudar && self.arquivo != nil){
        
        NSString *keyDaFala = [self.alertaAtual objectForKey:@"KeyDoAlerta"];
            
            CGPoint ponto = CGPointFromString([self.alertaAtual objectForKey:@"Posicao"]);
            DQFase *fase = (DQFase*)cena;
            
            [self adicionaIconeRadiacao:keyDaFala naPosicao:ponto fase:fase];
        self.referenciaAlertaAtual++;
        if(self.referenciaAlertaAtual < self.arquivo.count){
            self.alertaAtual = [self.arquivo objectAtIndex:self.referenciaAlertaAtual];
        }
        else{
            self.alertaAtual = nil;
        }
        
        self.podeMudar = NO;
    }
    
}

-(void)verificarAlerta :(CGPoint)pontoJogador fase:(SKScene*)cena{
    
    for (int i = 0; i < self.arquivo.count; i++) {
        NSDictionary *alerta= [self.arquivo objectAtIndex:i];
        
        CGPoint pontoAnalisar = CGPointFromString([alerta objectForKey:@"Posicao"]);
        
        if(pontoJogador.x > pontoAnalisar.x  && pontoJogador.x < pontoAnalisar.x+100 && pontoJogador.y >= pontoAnalisar.y -20){
            
            NSString *keyFalaRadiacao=[alerta objectForKey:@"KeyDoAlerta"];
            DQFase *cenaRecebida = (DQFase*)cena;
            [cenaRecebida addChild:[cenaRecebida.controleDeFalas mostrarAlertaComKey:keyFalaRadiacao Tamanho:cenaRecebida.size]];
            self.podeMudar = YES;
            
        }
    }
}
-(void)adicionaIconeRadiacao:(NSString*)nomeRadiacao naPosicao:(CGPoint)posicao fase:(DQFase*)fase{
    
    //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
    SKSpriteNode * iconeRadiacaoAlpha = [[ SKSpriteNode alloc]initWithImageNamed:@"BalaoAlerta"];
    iconeRadiacaoAlpha.size = CGSizeMake(50, 50);
    [iconeRadiacaoAlpha setAnchorPoint:CGPointMake(0, 0)];
    [iconeRadiacaoAlpha setPosition:CGPointMake(posicao.x, posicao.y + 80.0)];
    
    NSMutableDictionary *keyFala = [[NSMutableDictionary alloc]init];
    [keyFala setValue:nomeRadiacao forKey:@"KeyDoAlerta"];
    
    [iconeRadiacaoAlpha setUserData:keyFala];
    
    
    [iconeRadiacaoAlpha setName:@"Alerta"];
    
    [iconeRadiacaoAlpha setScale:0.9];
    
    SKAction *fadeOut=[SKAction fadeOutWithDuration:0.3];
    SKAction *fadeIn=[SKAction fadeInWithDuration:0.3];
    
    
    [iconeRadiacaoAlpha runAction:[SKAction repeatAction:[SKAction sequence:@[fadeOut,fadeIn]] count:5]];
    
    [fase.mundo insertChild:iconeRadiacaoAlpha atIndex:0];
}



@end

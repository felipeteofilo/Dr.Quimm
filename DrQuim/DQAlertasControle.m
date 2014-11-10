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
        self.falouAlerta = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}

-(void)atualizarAlerta :(SKScene*)cena{
    if(self.podeMudar && self.arquivo != nil){
        DQFase *fase = (DQFase*)cena;
        NSString *keyDaFala = [self.alertaAtual objectForKey:@"KeyDoAlerta"];
        if ([self.alertaAtual objectForKey:@"Aleatoria"]) {
            [self afastarJogador:fase];
            
        }else {
            CGPoint ponto = CGPointFromString([self.alertaAtual objectForKey:@"Posicao"]);
            
            [self adicionaIconeRadiacao:keyDaFala naPosicao:ponto fase:fase];
        }
        self.podeMudar = NO;
    }
    
}

-(void)verificarAlerta :(CGPoint)pontoJogador fase:(SKScene*)cena{
    if(!self.podeMudar){
        for (int i = 0; i < self.arquivo.count; i++) {
            self.alertaAtual = [self.arquivo objectAtIndex:i];
            
            
            
            CGPoint pontoAnalisar = CGPointFromString([self.alertaAtual objectForKey:@"Posicao"]);
            
            if(pontoJogador.x > pontoAnalisar.x  && pontoJogador.x < pontoAnalisar.x+10 && pontoJogador.y <= pontoAnalisar.y -20){
                NSString *keyFalaRadiacao;
                
                if ([self.alertaAtual objectForKey:@"Aleatoria"]) {
                    int numeroAleatorio = arc4random() % [[self.alertaAtual objectForKey:@"Aleatoria"]count]-1;
                    numeroAleatorio++;
                    
                    keyFalaRadiacao= [[self.alertaAtual objectForKey:@"Aleatoria"]objectAtIndex:numeroAleatorio];
                    
                    
                    
                }else{
                    keyFalaRadiacao=[self.alertaAtual objectForKey:@"KeyDoAlerta"];
                    if ([[self.falouAlerta objectForKey:keyFalaRadiacao]boolValue]) {
                        return;
                    }
                    
                }
                
                DQFase *cenaRecebida = (DQFase*)cena;
                [cenaRecebida addChild:[cenaRecebida.controleDeFalas mostrarAlertaComKey:keyFalaRadiacao Tamanho:cenaRecebida.size]];
                [cenaRecebida.jogador pararAndar];
                [self.falouAlerta setObject:[NSNumber numberWithBool:YES] forKey:keyFalaRadiacao];
                self.podeMudar = YES;
                
                break;
            }
        }
    }
}

-(void)afastarJogador :(DQFase*)fase{
    
    //[fase.jogador andarParaDirecao:'E' eVelocidade:0.5f];
    [fase.jogador runAction:[SKAction moveToX:fase.jogador.position.x-20 duration:0] withKey:@"saindoDePerto"];
}


-(void)adicionaIconeRadiacao:(NSString*)nomeRadiacao naPosicao:(CGPoint)posicao fase:(DQFase*)fase{
    
    //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
    SKSpriteNode * iconeRadiacaoAlpha = [[ SKSpriteNode alloc]initWithImageNamed:@"BalaoAlerta"];
    iconeRadiacaoAlpha.size = CGSizeMake(50, 50);
    [iconeRadiacaoAlpha setAnchorPoint:CGPointMake(0, 0)];
    [iconeRadiacaoAlpha setPosition:CGPointMake(posicao.x, posicao.y - 200)];
    
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

//
//  DQContadorGeiger.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 11/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQContadorGeiger.h"

@implementation DQContadorGeiger

-(id)initContadorNivelRadicao:(int)nivelRadiacao{
    if (self=[super initWithImageNamed:@"NivelRadicao0-1"]) {
        self.nivelPerigo=nivelRadiacao;
        
        [self setScale:0.2];
        [self setName:@"Contador"];
        [self setAnchorPoint:CGPointMake(1, 0.5)];
        
        [self configurarFundoSprite];
    }
    return self;
}

-(void)configurarFundoSprite{
    SKTextureAtlas *pastaImagens=[SKTextureAtlas atlasNamed:@"ContadorGeiger"];
    
    framesAnimacao=[[NSMutableArray alloc]init];
    
    NSString *nomeTextura;
    for (int i=1; i <= 2; i++) {
        nomeTextura = [NSString stringWithFormat:@"NivelRadicao%i-%i",self.nivelPerigo,i];
        SKTexture *temp = [pastaImagens textureNamed:nomeTextura];
        [framesAnimacao addObject:temp];
    }
    
    [self definirVelocidadePiscar];
    [self animar];
}

-(void)definirVelocidadePiscar{
    switch (self.nivelPerigo) {
        case 0:
            self.velocidadeAnimacao=0.5;
            break;
            
        case 1:
            self.velocidadeAnimacao=0.3;
            break;
            
        case 2:
            self.velocidadeAnimacao=0.1;
            break;
            
        default:
            self.velocidadeAnimacao=0.0;
            break;
    }
}

-(void)animar{
    
    [self removeActionForKey:@"piscar"];
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAnimacao timePerFrame:self.velocidadeAnimacao]]withKey:@"piscar"];
}

-(void)aumentarNivelPerigo{
    self.nivelPerigo++;
    
    if (self.nivelPerigo>2) {
        self.nivelPerigo=2;
    }
    
    [self tocarSomNivelPerigo];
}

-(void)diminuirNivelPerigo{
    self.nivelPerigo--;
    
    if (self.nivelPerigo<0) {
        self.nivelPerigo=0;
    }
    
    [self tocarSomNivelPerigo];
}

-(void)setarNivelPerigo:(int)valor{
    if (valor < 0) {
        self.nivelPerigo=0;
    }else if (valor >2){
        self.nivelPerigo=2;
    }else{
        self.nivelPerigo=valor;
    }
    
    [self tocarSomNivelPerigo];
}

-(void)tocarSomNivelPerigo{
    [self configurarFundoSprite];
    
    if (self.nivelPerigo >0) {
        if (![self actionForKey:@"tocarSom"]) {
            NSString *nomeSom=[NSString stringWithFormat:@"ContadorGeiger-%i.mp3",self.nivelPerigo];
            
            [self removeActionForKey:@"tocarSom"];
            [self runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:nomeSom waitForCompletion:YES]]withKey:@"tocarSom"];
        }
        
    }
}
@end

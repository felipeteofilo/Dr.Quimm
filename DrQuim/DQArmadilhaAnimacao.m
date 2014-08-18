//
//  DQArmadilhaAnimacao.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 18/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQArmadilhaAnimacao.h"

@implementation DQArmadilhaAnimacao

-(id)initArmadilha: (DQArmadilha*)armadilha animal:(NSString*)nomeAnimal Isca:(DQIsca*)isca chance:(float)chance cenaRetornar:(SKScene*)cena{
    if (self =[super initWithSize:cena.size]) {
        SKSpriteNode *imagemFundo = [[SKSpriteNode alloc]initWithImageNamed:armadilha.imagemFundo];
        
        [imagemFundo setSize:self.size];
        [imagemFundo setAnchorPoint:CGPointZero];
        [imagemFundo setPosition:CGPointZero];
        
        [self addChild:imagemFundo];
        
        self.cenaRetornar = cena;
        self.capturado =false;
        if ([nomeAnimal isEqualToString:@"Coelho"]) {
            DQAnimalCoelho *coelho = [[DQAnimalCoelho alloc]initCoelho];
            self.animal = coelho;
            self.capturado = [coelho serCapturaChance:chance :isca];
        }
        if ([nomeAnimal isEqualToString:@"Leopardinho"]) {
            DQAnimalLeopardinho *leopardo = [[DQAnimalLeopardinho alloc]initLeopardinho];
            self.animal = leopardo;
            self.capturado = [leopardo serCapturaChance:chance :isca];
        }
        if ([nomeAnimal isEqualToString:@"Toupeira"]) {
            DQAnimalToupeira *toupera = [[DQAnimalToupeira alloc]initToupeira];
            self.animal = toupera;
            self.capturado = [toupera serCapturaChance:chance :isca];
        }
        
        self.armadilha = armadilha;
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    [self animarCapturando];
}

-(NSMutableArray*)lerFrames :(SKTextureAtlas*)pastaFrames{
    NSInteger numImagens = pastaFrames.textureNames.count;
    NSMutableArray *frames =[[NSMutableArray alloc]init];
    
    for (int i=1; i <= numImagens; i++) {
        NSString *textureName = [NSString stringWithFormat:@"%d", i];
        SKTexture *temp = [pastaFrames textureNamed:textureName];
        [frames addObject:temp];
    }
    
    return frames;
}


-(void)animarCapturando{
    
    SKTextureAtlas * atlasAnimacao = [SKTextureAtlas atlasNamed:self.armadilha.animacao];
    
    NSMutableArray *arrayFrames = [self lerFrames:atlasAnimacao];
    
    SKSpriteNode *armadilha = [[SKSpriteNode alloc]initWithTexture:[atlasAnimacao textureNamed:[NSString stringWithFormat:@"%d", 1]]];
    
    
    
    
    
    [self.view presentScene:self.cenaRetornar];
    
}

@end

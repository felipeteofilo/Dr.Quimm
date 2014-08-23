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
        [[[DQJogador sharedJogador]itens]entregarItem:isca.objeto quantidade:1];
        self.imagemIsca =isca.imagem;
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
        
        self.animacaoArmadilha = armadilha.animacao;
        [self iniciarTela];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    if (self.capturado) {
        [self animarCapturando];
    }
    else{
        [self animarFalhando];
    }
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

-(void)iniciarTela{
    SKTextureAtlas * atlasAnimacao = [SKTextureAtlas atlasNamed:self.animacaoArmadilha];
    
    self.framesAnimacao = [self lerFrames:atlasAnimacao];
    
    CGPoint lugarIsca=CGPointMake(750, 50);
    
    self.armadilha = [[SKSpriteNode alloc]initWithTexture:[atlasAnimacao textureNamed:[NSString stringWithFormat:@"%d", 1]]];
    
    [self.armadilha setSize:self.size];
    [self.armadilha setAnchorPoint:CGPointZero];
    [self.armadilha setPosition:CGPointZero];
    
    
    SKSpriteNode *jogador = [[SKSpriteNode alloc]initWithImageNamed:@"JogadorEscondido"];
    [jogador setAnchorPoint:CGPointZero];
    [jogador setSize:CGSizeMake(150, 250)];
    [jogador setPosition:CGPointMake(8, 60)];
    
    SKSpriteNode *isca = [[SKSpriteNode alloc]initWithTexture:self.imagemIsca];
    
    [isca setAnchorPoint:CGPointZero];
    [isca setSize:CGSizeMake(150,150)];
    [isca setPosition:lugarIsca];
    [isca setZPosition:90];
    [isca setName:@"Isca"];
    
    [self.animal setAnchorPoint:CGPointZero];
    [self.animal setZPosition:100];
    [self.animal setPosition:CGPointMake(CGRectGetMidX(self.frame)-(self.animal.size.width/2), 135)];
    [self addChild:isca];
    [self addChild:jogador];
    
    [self addChild:self.armadilha];
    [self addChild:self.animal];
    
}

-(void)voltarParaFase{
    [NSThread sleepForTimeInterval:1.0f];
    [self.view presentScene:self.cenaRetornar];
}


-(void)animarCapturando{
    [self.animal setDirCaminhada:'D'];
    
    [[[DQJogador sharedJogador] itens]receberItem:self.animal.nomeAnimal quantidade:1];
    
    
    SKAction * andar = [self.animal andarPara:CGPointMake(750, 135)];
    
    [self.animal runAction:andar completion:^{
        [self.animal pararAnimacao];
        
        [self.animal setZPosition:60];
        [self.armadilha setZPosition:65];
        [[self childNodeWithName:@"Isca"]removeFromParent];
        [self.animal runAction:[SKAction moveTo:CGPointMake(770, 200) duration:1.0]];
        [self.armadilha runAction:[SKAction animateWithTextures:self.framesAnimacao timePerFrame:0.3 resize:NO restore:NO] completion:^{
            
            [self voltarParaFase];
            
        }];
    }];
}
-(void)animarFalhando{
    
    [self.animal setDirCaminhada:'E'];
    
    SKAction * andar = [self.animal andarPara:CGPointMake(-60, 135)];
    
    [self.animal runAction:andar completion:^{
        [self.animal pararAnimacao];
        [self voltarParaFase];
    }];
    
    
}

@end

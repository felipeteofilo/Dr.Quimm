//
//  DQJogador.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQJogador.h"

@implementation DQJogador

-(instancetype)initWithImageNamed:(NSString *)name{
    if(self = [super initWithImageNamed:name]){
        [self setSize:CGSizeMake(50, 100)];
        self.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:self.size];
        [self setPosition:CGPointMake(40, 180)];
        
        self.physicsBody.usesPreciseCollisionDetection=YES;
        self.physicsBody.affectedByGravity = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.density = 0.6f;
        self.physicsBody.restitution = 0;
        
        SKTextureAtlas *pastaFramesAndando= [SKTextureAtlas atlasNamed:@"Andando"];
        SKTextureAtlas *pastaFramesPulando= [SKTextureAtlas atlasNamed:@"Pulando"];
        SKTextureAtlas *pastaFramesParado= [SKTextureAtlas atlasNamed:@"Parado"];
        
        framesAndando = [[NSMutableArray alloc]init];
        framesPulando = [[NSMutableArray alloc]init];
        framesParado = [[NSMutableArray alloc]init];
        
        int numImagens = pastaFramesAndando.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Running%d", i];
            SKTexture *temp = [pastaFramesAndando textureNamed:textureName];
            [framesAndando addObject:temp];
        }
        
        numImagens = pastaFramesPulando.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Jumping%d", i];
            SKTexture *temp = [pastaFramesPulando textureNamed:textureName];
            [framesPulando addObject:temp];
        }
        
        numImagens = pastaFramesParado.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Standing%d", i];
            SKTexture *temp = [pastaFramesParado textureNamed:textureName];
            [framesParado addObject:temp];
        }
        
        [self animarParado];
        
        
    }
    
    return self;
    
}

+(id)sharedJogador
{
    static DQJogador *jogador = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jogador = [[self alloc]initWithImageNamed:@"Standing"];
    });
    return jogador;
}



//metodo com retorno void - faz o jogador andar
-(void)andarParaDirecao:(NSString*)direcao{
    
    
    
    //variavel SKAction- define a direcao do movimento
    SKAction *movimentar =[[SKAction alloc]init];
    
    //se a direcao for para direita
    if ([direcao isEqual:@"D"]) {
        
        movimentar =[SKAction moveByX:70 y:0 duration:1.0];
        self.xScale = fabs(self.xScale)*1;
    }else{
        movimentar =[SKAction moveByX:-70 y:0 duration:1.0];
        self.xScale = fabs(self.xScale)* -1;
    }
    if (![self hasActions]) {
        [self removeActionForKey:@"animandoPulo"];
        [self animarAndando];
    }
    
    //anda para direcao
    [self runAction:[SKAction repeatActionForever: movimentar] withKey:@"andar"];
}

-(void)animarAndando{
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando
                                                                   timePerFrame:0.1f
                                                                         resize:NO
                                                                        restore:YES]] withKey:@"animandoAndando"];
}
-(void)pular{
    if (self.podePular < 1) {
        
        
        self.physicsBody.dynamic = YES;
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, 35)];
        self.podePular += 1;
        
        [self removeActionForKey:@"animandoAndando"];
        
        [self animarPular];
    }
}
-(void)animarPular{
    [self runAction:[SKAction animateWithTextures:framesPulando timePerFrame:0.25f
                                           resize:NO
                                          restore:YES] withKey:@"animandoPulo"];
}



-(void)interagir{
    
}
-(void)animarParado{
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesParado
                                                                   timePerFrame:0.1f
                                                                         resize:NO
                                                                        restore:YES]]];
}


@end

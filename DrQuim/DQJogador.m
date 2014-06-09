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
        self.physicsBody.dynamic=NO;
        self.physicsBody.usesPreciseCollisionDetection=YES;
        self.physicsBody.affectedByGravity = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.density = 0.6f;
        self.physicsBody.restitution = 0;
        
        SKTextureAtlas *pastaFramesAndando= [SKTextureAtlas atlasNamed:@"Andando"];
        
        framesAndando = [[NSMutableArray alloc]init];
        
        int numImagens = pastaFramesAndando.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Running%d", i];
            SKTexture *temp = [pastaFramesAndando textureNamed:textureName];
            [framesAndando addObject:temp];
        }

        
    }
    
    return self;
    
}



//metodo com retorno void - faz o jogador andar
-(void)andarParaDirecao:(NSString*)direcao{
    
    //variavel SKAction- define a direcao do movimento
    SKAction *movimentar =[[SKAction alloc]init];
    
    //se a direcao for para direita
    if ([direcao isEqual:@"D"]) {
        
        movimentar =[SKAction moveByX:50 y:0 duration:1.0];
        self.xScale = fabs(self.xScale)*1;
    }else{
        movimentar =[SKAction moveByX:-50 y:0 duration:1.0];
        self.xScale = fabs(self.xScale)* -1;
    }
    
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando
                                                                   timePerFrame:0.1f
                                                                         resize:NO
                                                                        restore:YES]] withKey:@"animando"];
    
    //anda para direcao
    [self runAction:[SKAction repeatActionForever: movimentar] withKey:@"andar"];
    
}
-(void)pular{
    
    self.physicsBody.dynamic = YES;
    self.physicsBody.velocity = CGVectorMake(0, 0);
    [self.physicsBody applyImpulse:CGVectorMake(0, 25)];
    self.estaNoChao = false;

}
-(void)interagir{
    
}


@end

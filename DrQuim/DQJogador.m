//
//  DQJogador.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQJogador.h"

@implementation DQJogador

//funcao para iniciar e alocar tudo que for necessario para o player
-(instancetype)initWithImageNamed:(NSString *)name{
    if(self = [super initWithImageNamed:name]){
        
        //Inicia o jogador com o phisics Body e o tamanho
        [self setSize:CGSizeMake(50, 100)];
        self.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:self.size];
        [self setPosition:CGPointMake(40, 180)];
        
        self.physicsBody.usesPreciseCollisionDetection=YES;
        self.physicsBody.affectedByGravity = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.density = 0.6f;
        self.physicsBody.restitution = 0;
        
        
        //le as pastas atlas de animacoes
        SKTextureAtlas *pastaFramesAndando= [SKTextureAtlas atlasNamed:@"Andando"];
        SKTextureAtlas *pastaFramesPulando= [SKTextureAtlas atlasNamed:@"Pulando"];
        SKTextureAtlas *pastaFramesParado= [SKTextureAtlas atlasNamed:@"Parado"];
        
        
        //inicia os arrays com os frames das animacoes
        framesAndando = [[NSMutableArray alloc]init];
        framesPulando = [[NSMutableArray alloc]init];
        framesParado = [[NSMutableArray alloc]init];
        
        
        
        //adiciona as texturas no array de frames
        NSInteger numImagens = pastaFramesAndando.textureNames.count;
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
        
        
        //apos ler tudo anima o jogador
        [self animarParado];
        
        
    }
    
    
    //retorna o jogador
    return self;
    
}


//Singleton do jogador
+(id)sharedJogador
{
    static DQJogador *jogador = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jogador = [[self alloc]initWithImageNamed:@"Standing"];
    });
    return jogador;
}

//funcao para animar o jogador andando
-(void)animarAndando{
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando
                                                                   timePerFrame:0.1f
                                                                         resize:NO
                                                                        restore:YES]] withKey:@"animandoAndando"];
}
//anima ele parado
-(void)animarParado{
    [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesParado
                                                                   timePerFrame:0.1f
                                                                         resize:NO
                                                                        restore:YES]]];
}
//funcao para animar jogador pulando
-(void)animarPular{
    [self runAction:[SKAction animateWithTextures:framesPulando timePerFrame:0.25f
                                           resize:NO
                                          restore:YES] withKey:@"animandoPulo"];
}

//funcao da acao de pulo do jogador
-(void)pular{
    
    //verifica se ele esta no ar, se ja estiver nao pula
    if (self.podePular < 1) {
        
        // aplica um impulso para cima , ou seja o pulo e seta que ele esta no ar
        self.physicsBody.dynamic = YES;
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, 35)];
        self.podePular += 1;
        
        
        // anima ele pulando
        [self animarPular];
    }
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
    
    //verifica se nao esta animando o pulo e anima o jogador andando
    if (![self actionForKey:@"animandoPulo"]) {
        [self animarAndando];
    }
    
    
    
    //anda para direcao
    [self runAction:[SKAction repeatActionForever: movimentar] withKey:@"andar"];
}




//funcao a fazer para ele interagir com pessoas e elementos do cenario
-(void)interagir{
    
}




@end

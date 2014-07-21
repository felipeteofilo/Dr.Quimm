//
//  DQJogador.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 26/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQJogador.h"

@implementation DQJogador

//Leonardo 13/06/2014 - Alterado a função de inicialização do node para que carregue o sprite na propriedade spriteNode
//Funcao para iniciar e alocar tudo que for necessario para o player
-(id)initJogadorSprite: (NSString*)name{

    if(self = [super init]){
        
        //Leonardo 13/06/2014 - Inicia o sprite
        self.spriteNode=[SKSpriteNode spriteNodeWithImageNamed:name];
        
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        [self.spriteNode setSize:CGSizeMake(90, 160)];
        
        [self.spriteNode setZPosition:10.0f];
        //Deixar o corpo fisico mais prox ao sprite
        self.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.spriteNode.size.width, self.spriteNode.size.height-12)];

        self.physicsBody.usesPreciseCollisionDetection=YES;
        self.physicsBody.affectedByGravity = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.density = 0.6f;
        self.physicsBody.restitution = 0;
        
        [self addChild:self.spriteNode];
        
        //le as pastas atlas de animacoes
        SKTextureAtlas *pastaFramesAndando= [SKTextureAtlas atlasNamed:@"Andando"];
        SKTextureAtlas *pastaFramesPulando= [SKTextureAtlas atlasNamed:@"Pulando"];
        SKTextureAtlas *pastaFramesParado= [SKTextureAtlas atlasNamed:@"Parado"];
        SKTextureAtlas *pastaFramesEscalando= [SKTextureAtlas atlasNamed:@"Escalando"];
        
        
        
        //inicia os arrays com os frames das animacoes
        framesAndando = [[NSMutableArray alloc]init];
        framesPulando = [[NSMutableArray alloc]init];
        framesParado = [[NSMutableArray alloc]init];
        framesEScalando = [[NSMutableArray alloc]init];
        
    
        //adiciona as texturas no array de frames
        NSInteger numImagens = pastaFramesAndando.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Andando%d", i];
            SKTexture *temp = [pastaFramesAndando textureNamed:textureName];
            [framesAndando addObject:temp];
        }
        
        numImagens = pastaFramesPulando.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Pulando%d", i];
            SKTexture *temp = [pastaFramesPulando textureNamed:textureName];
            [framesPulando addObject:temp];
        }
        
        numImagens = pastaFramesParado.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"Parado%d", i];
            SKTexture *temp = [pastaFramesParado textureNamed:textureName];
            [framesParado addObject:temp];
        }
        
        numImagens = pastaFramesEscalando.textureNames.count;
        for (int i=1; i <= numImagens; i++) {
            NSString *textureName = [NSString stringWithFormat:@"escalando%d", i];
            SKTexture *temp = [pastaFramesEscalando textureNamed:textureName];
            [framesEScalando addObject:temp];
        }
        
        //Seta que ele ainda nao pode escalar
        self.podeEscalar = NO;
        
        
        //apos ler tudo anima o jogador
        [self animarParado];
        
        
        //USADO COMO TESTE
        self.fome = 10;
        self.sede = 40;
        self.vida = 100;
        self.respeito = 0;
        
        //Inicia a instância da classe itensJogador
        self.itens = [[DQItensJogador alloc] init];
        
        //Inicia a instância da classe missoesJogador
        self.missoes = [[DQMissoesJogador alloc] init];
        
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
        jogador = [[self alloc]initJogadorSprite:@"Jogador"];
    });
    
    return jogador;
}


//funcao para animar o jogador andando
-(void)animarAndando{
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesAndando
                                                                   timePerFrame:0.1f
                                                                         resize:NO
                                                                        restore:YES]] withKey:@"animandoAndando"];
}

//funcao para animar o jogador escalando
-(void)animarEscalando{
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesEScalando
                                                                              timePerFrame:0.1f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"animandoEscalada"];
}
//anima ele parado
-(void)animarParado{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesParado
                                                                              timePerFrame:0.9f
                                                                                    resize:NO
                                                                                   restore:YES]]];
}
//funcao para animar jogador pulando
-(void)animarPular{
    
    //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
    [self.spriteNode runAction:[SKAction animateWithTextures:framesPulando timePerFrame:0.33f                                           resize:NO restore:YES] withKey:@"animandoPulo"];
}

//funcao da acao de pulo do jogador
-(void)pular{
    
    //verifica se ele esta no ar, se ja estiver nao pula
    if (self.podePular < 1 && ![self.spriteNode actionForKey:@"animandoEscalada"]) {
        
        // aplica um impulso para cima , ou seja o pulo e seta que ele esta no ar
        self.physicsBody.dynamic = YES;
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, 140)];
        self.podePular += 1;
        
        
        // anima ele pulando
        [self animarPular];
    }
}

//metodo com retorno void - faz o jogador andar
-(void)andarParaDirecao:(NSString*)direcao{
    if (![self.spriteNode actionForKey:@"animandoEscalada"]) {
        
        
        //variavel SKAction- define a direcao do movimento
        SKAction *movimentar =[[SKAction alloc]init];
        
        //se a direcao for para direita
        if ([direcao isEqual:@"D"]) {
            
            self.andandoParaDirecao = @"D";
            movimentar =[SKAction moveByX:90 y:0 duration:1.0];
            
            if(self.physicsBody.velocity.dx > 10 && self.physicsBody.velocity.dy < -10){
                [self.physicsBody setVelocity:CGVectorMake(10, -10)];
            }
            
            //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
            self.spriteNode.xScale = fabs(self.spriteNode.xScale)*1;
        }else{
            
            self.andandoParaDirecao = @"E";
            movimentar =[SKAction moveByX:-90 y:0 duration:1.0];
            
            //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
            self.spriteNode.xScale = fabs(self.spriteNode.xScale)*-1;
            
        }
        
        //Leonardo 13/06/2014 - alterado para dar xScale na propriedade spriteNode
        //verifica se nao esta animando o pulo e anima o jogador andando
        if (![self.spriteNode actionForKey:@"animandoPulo"]) {
            [self animarAndando];
        }
        
        //anda para direcao
        [self runAction:[SKAction repeatActionForever: movimentar] withKey:@"andar"];
    }
}

//Método para parar de andar
-(void)pararAndar{
    
    //remove as acoes de andar e animarAndando
    [self removeActionForKey:@"andar"];
    [self.spriteNode removeActionForKey:@"animandoAndando"];
}

//funcao para fazer o jogador escalar
-(void)escalarParaDirecao:(NSString*)direcao{
    //se puder escalar
    if (self.podeEscalar) {
        
        
        SKAction *escalar=[[SKAction alloc]init];
        
        //Desliga a gravidade para o Node
        self.physicsBody.dynamic=NO;
        // verifica para qual direcao sera a escalada
        if ([direcao isEqualToString:@"C"]) {
            //Sobe
            
            escalar =[SKAction moveByX:0.0f y:90.0f duration:1.0];
            
        }else if([direcao isEqualToString:@"B"]){
            //Desce
            escalar =[SKAction moveByX:0.0f y:-90.0f duration:1.0];
        }
        //anima o jogador escalando
        [self animarEscalando];
        // move o jogador
        [self runAction:[SKAction repeatActionForever:escalar]withKey:@"escalar"];
    }
}

//funcao para parar a escalada do jogador
-(void)pararEscalar{
    self.podeEscalar = NO;
    if (![self.physicsBody isDynamic]) {
        self.physicsBody.dynamic = YES;
    }
    [self.spriteNode removeActionForKey:@"animandoEscalada"];
    [self removeActionForKey:@"escalar"];
}

//funcao para dar uma pausa na escalada do jogador
-(void)pausarEscalada{
    [[self.spriteNode actionForKey:@"animandoEscalada"]setSpeed:0];
    [self removeActionForKey:@"escalar"];
}

//funcao a fazer para ele interagir com pessoas e elementos do cenario
-(void)interagir{
    
}




@end

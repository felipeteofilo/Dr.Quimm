//
//  DQJogador.m
//  Dr.Quimm2
//
//  Created by Julia Yamamoto on 02/07/14.
//  Copyright (c) 2014 Júlia Yamamoto. All rights reserved.
//

#import "DQJogador.h"

@implementation DQJogador

//Singleton do jogador
+(id)sharedJogador
{
    static DQJogador *jogador = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jogador = [[self alloc]init];
    });
    
    return jogador;
}

//Metodo para iniciar a classe. Chama o método de iniciar o sprite do jogador e o de criar as animações
-(id)init
{
    if(self = [super init]){
        //!Configuração da florestaParte1 - Carregando o cientista
        self.carregandoCientista = YES;
        
        //Chama métodos iniciais
        [self iniciaSpriteJogador];
        [self criarAcoesAnimacaoJogador];
        
        //Adiciona o SKSpriteNode do jogador
        [self addChild:self.spriteJogador];
        
        //!Configuração da florestaParte1 - Posição de inicio
        [self setPosition:CGPointMake(150, 280)];
    }
    return self;
}

//********************************************COISAS A FAZER - LINHA 6!!!
//Metodo que inicia o jogador com phisicsBody e seu tamanho.
-(void)iniciaSpriteJogador
{
    //Atribui uma imagem ao Jogador
    if(self.carregandoCientista){
        self.spriteJogador = [SKSpriteNode spriteNodeWithImageNamed:@"pilotoComCientista"];
    }
    else{
        //COLOCAR IMAGEM DELE SEM O CIENTISTA
    }
    
    //Define o tamanho do sprite do jogador
    [self.spriteJogador setSize:CGSizeMake(90, 160)];
    
    //Aplica um physicsBody e define suas características
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.spriteJogador.size];
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.affectedByGravity = YES;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.density = 0.6f;
    self.physicsBody.restitution = 0;
    
    //Inicia com a animação dele parado
    [self animarParado];
}

//Método para fazer o jogador pular
-(void)pular
{
    //Se ele já não estiver pulando...
    if(!self.estaPulando){
        //Começa a pular
        self.estaPulando = YES;
        
        //Aplica impulso para o pulo
        self.physicsBody.dynamic = YES;
        self.physicsBody.velocity = CGVectorMake(0, 0);
        [self.physicsBody applyImpulse:CGVectorMake(0, 140)];
        
        //Inica a animação
        [self animarPulando];
    }
}

//Método para fazer o jogador andar para a direção passada
-(void)andarParaDirecao: (NSString *)direcao
{
    //Recebe qual a direção passada
    self.direcaoAndar = direcao;
    
    //Inicia a SKAction para a ação de movimento do personagem
    self.acaoMovimentoAndar = [[SKAction alloc]init];
    
    
    //*** VERIFICANDO A DIREÇÃO ***\\
    //D: Anda para a direita
    if([self.direcaoAndar isEqualToString:@"D"]){
        
        //A ação de movimento deve ser para a direita
        self.acaoMovimentoAndar = [SKAction moveByX:90 y:0 duration:1.0f];
        
        //Coloca o sprite do jogador olhando para a direção correta
        self.spriteJogador.xScale = fabs(self.spriteJogador.xScale)*1;
    }
    
    //E: Anda para a esquerda
    else if([self.direcaoAndar isEqualToString:@"E"]){
        
        //A ação de movimento deve ser para a esquerda
        self.acaoMovimentoAndar = [SKAction moveByX:-90 y:0 duration:1.0f];
        
        //Coloca o sprite do jogador olhando para a direção correta
        self.spriteJogador.xScale = fabs(self.spriteJogador.xScale)*-1;
    }
    
    //Menssagem de Erro
    else{
        NSLog(@"ATENÇÃO: Informação de andarParaDirecao passada está errada. Escreva 'D' para Direita e 'E' para a Esquerda");
    }
    //*** FIM ***\\
    

    //Verifica se não está animando o pulo antes de executar a animação dele andando
    if (![self.spriteJogador actionForKey:@"animandoPulo"]) {
        [self animarAndando];
    }

    //Executa a ação de movimento
    [self runAction:[SKAction repeatActionForever: self.acaoMovimentoAndar] withKey:@"movimentoAndando"];
}

//Método para fazer o jogador parar de andar
-(void)pararDeAndar
{
    //Remove as ações de movimento e animação relacionadas a andar
    [self removeActionForKey:@"movimentoAndando"];
    [self.spriteJogador removeActionForKey:@"animacaoAndando"];
}

//Metodo que cria as ações de animação do jogador.
-(void)criarAcoesAnimacaoJogador
{
    //Inicia os SKTextureAtlas
    SKTextureAtlas *atlasAndando = [SKTextureAtlas atlasNamed:@"Andando"];
    SKTextureAtlas *atlasParado = [SKTextureAtlas atlasNamed:@"Parado"];
    SKTextureAtlas *atlasPulando = [SKTextureAtlas atlasNamed:@"Pulando"];
    
    
    //Cria os NSMutableArrays de frames a partir dos SKTextureAtlas
        //Andando
        NSMutableArray *arrayFramesAndando = [[NSMutableArray alloc] init];
        for(int i = 0; i < [atlasAndando.textureNames count]; i++){
            NSString *nomeTextura = [NSString stringWithFormat:@"andando%d", i];
            SKTexture *novaTextura = [atlasAndando textureNamed:nomeTextura];
            [arrayFramesAndando addObject:novaTextura];
        }
        //Parado
        NSMutableArray *arrayFramesParado = [[NSMutableArray alloc] init];
        for(int i = 0; i < [atlasParado.textureNames count]; i++){
            NSString *nomeTextura = [NSString stringWithFormat:@"parado%d", i];
            SKTexture *novaTextura = [atlasParado textureNamed:nomeTextura];
            [arrayFramesParado addObject:novaTextura];
        }
        //Pulando
        NSMutableArray *arrayFramesPulando = [[NSMutableArray alloc] init];
        for(int i = 0; i < [atlasPulando.textureNames count]; i++){
            NSString *nomeTextura = [NSString stringWithFormat:@"pulando%d", i];
            SKTexture *novaTextura = [atlasPulando textureNamed:nomeTextura];
            [arrayFramesPulando addObject:novaTextura];
        }
    
    //Atribui as devidas texturas á SKAction que pertence
    self.acaoAnimarAndando = [SKAction animateWithTextures:arrayFramesAndando timePerFrame:0.1f resize:NO restore:YES];
    self.acaoAnimarParado = [SKAction animateWithTextures:arrayFramesParado timePerFrame:0.1f resize:NO restore:YES];
    self.acaoAnimarPulando = [SKAction animateWithTextures:arrayFramesPulando timePerFrame:0.1f resize:NO restore:YES];
    
}

//Metodo para animar o jogador andando. Animar apenas. KEY:"animacaoAndando"
-(void)animarAndando
{
    [self.spriteJogador runAction:self.acaoAnimarAndando withKey:@"animacaoAndando"];
}

//Metodo para animar o jogador pulando. Animar apenas. KEY:"animacaoPulando"
-(void)animarPulando
{
    [self.spriteJogador runAction:self.acaoAnimarPulando withKey:@"animacaoPulando"];
}

//Metodo para animar o jogador parado. Animar apenas. KEY:"animacaoParado"
-(void)animarParado
{
    [self.spriteJogador runAction:self.acaoAnimarParado withKey:@"animacaoAndando"];
}

@end

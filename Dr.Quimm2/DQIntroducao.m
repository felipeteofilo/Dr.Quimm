//
//  DQIntroducao.m
//  Dr.Quimm2
//
//  Created by Julia Yamamoto on 02/07/14.
//  Copyright (c) 2014 Júlia Yamamoto. All rights reserved.
//

#import "DQIntroducao.h"

@implementation DQIntroducao

-(id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size]){
        
        //Define a primeira cutscene e a coloca para rodar antes da fase começar
        self.primeiraCutscene = [[DQCutscene alloc]initComParte:1 Fase:1];
        
        //Define o valor dos booleanos
        self.cutsceneEstaRodando = NO;
        self.alguemEstaFalando = NO;

        //Antes de iniciar a fase, roda a primeira cutscene
        [self iniciarCutSceneParte:1];
    }
    return self;
}

//********************************************COISAS A FAZER - LINHA 8!!!
//Método que inicia uma das cutscenes da cena, passada por paramentro
-(void)iniciarCutSceneParte:(int)parte
{
    self.cutsceneEstaRodando = YES;
    
    switch (parte) {
        case 1:
            //inicia primeira cutscene
            [self.primeiraCutscene iniciarCutscene:self Seletor:@selector(iniciarFase)];
            break;
           
        case 2:
            //inicia segunda cutscene - A FAZER
            break;
            
        default:
            //menssagem de erro
            NSLog(@"ATENÇÃO: valor passado não correspondente a nenhuma cutscene");
            break;
    }
}

//Método que inicia a fase
-(void)iniciarFase
{
    //Cutscene terminou de rodar
    self.cutsceneEstaRodando = NO;
    
    //Inicializa o mundo dessa fase
    self.mundo =[SKNode node];
    [self.mundo setName:mundo];
    [self.mundo setZPosition:-100];
    
    //Cria a parte inicial, aplicando o phisicsBody e suas definições
    self.physicsWorld.gravity=CGVectorMake(0, -3);
    
    //Cria a parte inicial, aplicando o phisicsBody e suas definições
    SKSpriteNode *parteInicial =[SKSpriteNode spriteNodeWithImageNamed:@"parte1"];
    [parteInicial setAnchorPoint:CGPointMake(0, 0)];
    [parteInicial setPosition:CGPointMake(0,0)];
    parteInicial.physicsBody = [DQControleCorpoFisico criaCorpoFísicoBase:1];
    parteInicial.physicsBody.categoryBitMask = ChaoCategoria;
    parteInicial.physicsBody.usesPreciseCollisionDetection = YES;
    parteInicial.physicsBody.dynamic = NO;
    
    //Inicia o jogador pelo singleton
    self.jogador = [DQJogador sharedJogador];
    
    //Define as categorias de colisao do jogador
    self.jogador.physicsBody.categoryBitMask = JogadorCategoria;
    self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
    
    //Define que a classe que irá delegar o contato será essa mesma
    [self.physicsWorld setContactDelegate:self];
    
    //Adicionado nome no skNode que será o chao
    [parteInicial setName:backgroundAtual];
    
    //Adiciona a primeira parte da tela e o jogador no mundo
    [self.mundo addChild:parteInicial];
    [self.mundo addChild:self.jogador];
    
    //Adiciona o mundo na scena
    [self addChild:self.mundo];
    
    self.parteFaseAtual = 1;
    self.ultimoXParteFase = 0;
    
    //Guarda quantas partes a fase atual tem
    self.partesFase = 14;
}

//Método de atualização do SpriteKit
-(void)update:(NSTimeInterval)currentTime
{
    [self criaPartesFase];
}

//Método que cria e incia todas as partes da fase
-(void)criaPartesFase
{
    
    //Cria um SKNode com o background
    SKNode *nodeBackground = [self.mundo childNodeWithName:backgroundAtual];
    
    //se for maior que a metade do tamanho de uma skScene ele irá criar um SKNode com o physicsbody da próxima parte do cenário
    if (self.jogador.position.x > (CGRectGetMaxX(self.frame)*self.parteFaseAtual)/2) {
        
        //verifica se já tem um node com o nome @proxParte - USANDO IF NOT
        if (![self.mundo childNodeWithName:proxBackground]) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual + 1 <= self.partesFase) {
                NSString *nomeImagemBack=[NSString stringWithFormat:@"parte%i",self.parteFaseAtual+1];
                
                //Altera para SKSpriteNode
                SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorPoint
                background.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [background setZPosition: -100.0];
                
                
                //POSICIONA APÓS A CENA
                //Corpo fisico
                background.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual + 1];
                
                //Nome do node
                [background setName:proxBackground];
                
                //Posição do node
                background.position=CGPointMake(CGRectGetMaxX(self.frame) * self.parteFaseAtual, 0);
                
                //Aciona background no mundo
                [self.mundo addChild:background];
            }
        }
        
    }
    
    //Verifica se a posicao X do jogador é menor que a posicao X do background + 1/2 de um frame de SKScene
    else if (self.jogador.position.x < (nodeBackground.position.x + CGRectGetMidX(self.frame))){
        
        //verifica se ja tem um node com o nome @proxParte - USANDO IF NOT
        if (![self.mundo childNodeWithName:backgroundAnt]) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual -1 > 0) {
                
                NSString *nomeImagemBack=[NSString stringWithFormat:@"parte%i",self.parteFaseAtual-1];
                
                // Alterar para skspritenode
                SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorpoint
                background.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [background setZPosition: -100.0];
                
                //posiciona após a cena
                //Corpo fisico
                background.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual - 1];
                
                //nome do node
                [background setName:backgroundAnt];
                
                
                //posicao do node
                background.position=CGPointMake(self.ultimoXParteFase - CGRectGetMinX(self.frame), 0);
                
                //Add back no mundo
                [self.mundo addChild:background];
                
            }
        }
    }
    
    NSLog(@"posicao X do jogador %f",self.jogador.position.x);
    NSLog(@"X do background + metade de uma tela: %f",nodeBackground.position.x + CGRectGetMidX(self.frame));
}

//Metodo que controle em que parte da fase está e carrega as necessárias
-(void)controlaParteFase
{
    
    if (self.jogador.position.x > (CGRectGetMaxX(self.frame)*self.parteFaseAtual +5 )) {
        if (self.parteFaseAtual + 1 <= self.parteFaseAtual ) {
            self.parteFaseAtual ++;
            
            //Se ja tiver um backAnterior marca como backEliminar
            if ([self.mundo childNodeWithName:backgroundAnt]) {
                [[self.mundo childNodeWithName:backgroundAnt]setName:backgroundEliminar];
            }
            
            //Transforma o backgroundAtual no anterior
            [[self.mundo childNodeWithName:backgroundAtual]setName:backgroundAnt];
            
            //Atualiza oque era chamado de proxBackground para background
            [[self.mundo childNodeWithName:proxBackground]setName:backgroundAtual];
        }
        
        //Verifica se a possicao X atual do jogador é menor que o X do background atual (o menos 10 é para dar uma tolerancia)
    }else if (self.jogador.position.x < [self.mundo childNodeWithName:backgroundAtual].position.x -5  ){
        if (self.parteFaseAtual -1 >=1 ) {
            self.parteFaseAtual --;
            
            //Se ja tiver um proxBack marca como backEliminar
            if ([self.mundo childNodeWithName:proxBackground]) {
                [[self.mundo childNodeWithName:proxBackground]setName:backgroundEliminar];
            }
            
            //Transforma o backgroundAtual em proxBack
            [[self.mundo childNodeWithName:backgroundAtual]setName:proxBackground];
            
            //Atualiza oque era chamado de proxBackground para background
            [[self.mundo childNodeWithName:backgroundAnt]setName:backgroundAtual];
        }
    }
}

//Metodo que e chamado assim que e criada a cena
-(void)didMoveToView:(SKView *)view{
    
    // cria o gesto do pulo e adiciona na cena
    self.gestoPulo = [[DQGestoPulo alloc]init];
    
    [view addGestureRecognizer:self.gestoPulo];
}

//metodo que e chamado assim que um toque é iniciado na cena
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.cutsceneEstaRodando) {
        
        
        //verifica em qual parte da tela o toque foi feito e faz o personagem andar de acordo com essa informacao
        UITouch *posicao = [touches anyObject];
        
        if ([posicao locationInView:self.view].x > self.view.frame.size.height/2 ) {
            
            [self.jogador andarParaDirecao:@"D"];
        }else{
            [self.jogador andarParaDirecao:@"E"];
        }
    }
    else if(self.alguemEstaFalando){
        if ([self.primeiraCutscene trocarFala]) {
            [self.primeiraCutscene mostrarFalaNoJogo:self KeyDaFala:nil];
            
        }
        else{
            self.alguemEstaFalando = NO;
            self.cutsceneEstaRodando = NO;
        }
    }
    
}

//metodo chamado assim que um toque e finalizado
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.cutsceneEstaRodando) {
        [self.jogador pararDeAndar];
    }
    else if(!self.alguemEstaFalando){
        [self.primeiraCutscene trocarCena];
    }
    
}

//metodo do delegate de contato que e chamado assim que comeca o contato
-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    // Organiza os corpos de acordo com o valor da categoria. Isto é feito para facilitar a comparação mais em baixo
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    
    // Compara as máscaras de categoria com os valores que nós usamos para os objetos do jogo
    if ((firstBody.categoryBitMask & JogadorCategoria)!=0) {
        if ((secondBody.categoryBitMask & ChaoCategoria) !=0) {
            
            //se o jogador colidiu com o chao setamos que ele estao no chao e verificamos se ele esta andando e o animamos
            [self.jogador setEstaPulando:YES];
            
            if (![self.jogador.spriteJogador actionForKey:@"animandoAndando"] && [self.jogador actionForKey:@"andar"] ) {
                [self.jogador animarAndando];
            }
        }
    }
    
}

@end

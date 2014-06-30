//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"
#import "DQControleCorpoFisico.h"

#define cameraEdge 512

@implementation DQFlorestaParte1


//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:1];
        

        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;

        [self.controleCutscenes iniciarCutscene:self Seletor:@selector(iniciarFase)];
        
        //[self iniciarFase];
    }
    return self;
}

-(void)iniciarFase{
    
    self.cutsceneEstaRodando = NO;
    
    //Alterado a inicialização do mundo para usar a variavel da skScene e assim poder manipular ele durante a cena toda
    //SKNode *mundo = [SKNode node];
    //mundo.name = @"mundo";
    self.mundo =[SKNode node];
    [self.mundo setName:mundo];
    [self.mundo setZPosition:-100];
    
    //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
    self.physicsWorld.gravity=CGVectorMake(0, -3);
    
    SKSpriteNode *primeiraParte =[SKSpriteNode spriteNodeWithImageNamed:@"parte1"];
    
    [primeiraParte setAnchorPoint:CGPointMake(0, 0)];
    [primeiraParte setPosition:CGPointMake(0,0)];
    
    primeiraParte.physicsBody =[DQControleCorpoFisico criaCorpoFísicoBase:1];
    primeiraParte.physicsBody.categoryBitMask=ChaoCategoria;
    primeiraParte.physicsBody.usesPreciseCollisionDetection=YES;
    primeiraParte.physicsBody.dynamic=NO;
    
    //Leonardo - inicializa o jogador
    //Inicia o jogador pelo singleton
    self.jogador = [DQJogador sharedJogador];
    
    //seta as categorias de colisao do jogador
    self.jogador.physicsBody.categoryBitMask=JogadorCategoria;
    self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
    
    //Seta que a classe que ira delegar o contato sera essa mesma
    [self.physicsWorld setContactDelegate:self];
    
    //Adicionado nome no skNode que será o chao
    [primeiraParte setName:backgroundAtual];
    
    //Adiciona a primeira parte da tela e o jogador no mundo
    [self.mundo addChild:primeiraParte];
    [self.mundo addChild:self.jogador];
    
    //Adiciona o mundo na scena
    [self addChild:self.mundo];
    
    //self.posicaoXJogador=self.jogador.position.x;
    self.parteFaseAtual=1;
    self.ultimoXParteFase=0;
    
    //Provisório
    self.nPartesCena=14;
}

- (void)didSimulatePhysics
{
    
    if (!self.cutsceneEstaRodando) {
        
        CGPoint heroPosition = self.jogador.position;
        
        //LEONARDO - 25/06/2014 - Foi adicionado propriedade para acessar o mundo
        CGPoint worldPosition = self.mundo.position;
        
        CGFloat xCoordinate = worldPosition.x + heroPosition.x ;
        
        if(xCoordinate <= cameraEdge && heroPosition.x >= 512)
        {
            worldPosition.x = worldPosition.x - xCoordinate  + cameraEdge;
            
        }
        else if(xCoordinate > (self.frame.size.width - cameraEdge) && heroPosition.x < (self.nPartesCena *1024) -512)
        {
            worldPosition.x = worldPosition.x + (self.frame.size.width - xCoordinate) - cameraEdge;
            
        }
        
        self.mundo.position = worldPosition;
        
        //Chama método para controlar em que parte da fase esta
        [self controlaParteFase];
        
        if (heroPosition.x > 2470 && heroPosition.x < 2475 ) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoAlfa"];
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
            [self.jogador pararAndar];
            if ([self.jogador.andandoParaDirecao isEqualToString:@"D"]) {
                heroPosition.x += 5;
            }
            else
                heroPosition.x -=5;
            
            self.jogador.position= heroPosition;
            
           
            
        }
        
    }
}


//metodo que e chamado assim que e criada a cena
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
    else if(self.estaFalando){
        if ([self.controleCutscenes trocarFala]) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:nil];
            
        }
        else{
            self.estaFalando =NO;
            self.cutsceneEstaRodando = NO;
        }
    }
    
}



//metodo chamado assim que um toque e finalizado
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.cutsceneEstaRodando) {
        [self.jogador pararAndar];
    }
    else if(!self.estaFalando)
        [self.controleCutscenes trocarCena];
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
            [self.jogador setPodePular:0];
            
            if (![self.jogador.spriteNode actionForKey:@"animandoAndando"] && [self.jogador actionForKey:@"andar"] ) {
                [self.jogador animarAndando];
            }
        }
    }
    
}

-(void)update:(NSTimeInterval)currentTime{
    
    [self criarParteFase];
}


-(void)criarParteFase{
    
    //Cria um skNode com o background para facilitar na nossa leitura do codigo
    SKNode *nodeBackground=[self.mundo childNodeWithName:backgroundAtual];
    
    //se for maior que a metade do tamanho de uma skScene ele irá criar um skNode com o physicsbody da prox parte do cenario
    //if (self.posicaoXJogador > CGRectGetMidX(self.frame)){
    if (self.jogador.position.x > (CGRectGetMaxX(self.frame)*self.parteFaseAtual)/2) {
        
        //verifica se ja tem um node com o nome @proxParte - ESTA USANDO IF NOT
        if (![self.mundo childNodeWithName:proxBackground]) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual + 1 <= self.nPartesCena) {
                NSString *nomeImagemBack=[NSString stringWithFormat:@"parte%i",self.parteFaseAtual+1];
                
                // Alterar para skspritenode
                SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorpoint
                background.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [background setZPosition: -100.0];
                
                //se tiver Cria o skspritenode com o fundo da prox parte e corpo fisico
                
                //posiciona após a cena
                //Corpo fisico
                background.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual + 1];
                
                //nome do node
                [background setName:proxBackground];
                
                //posicao do node
                //background.position=CGPointMake(self.ultimoXParteFase+CGRectGetMaxX(self.frame), 0);
                background.position=CGPointMake(CGRectGetMaxX(self.frame) * self.parteFaseAtual, 0);
                
                //add back no mundo
                [self.mundo addChild:background];
            }
            
        }
        
        //Verifica se a posicao X do jogador é menor que a posicao X do back + 1/2 de um frame de SkScene
        //}else if (self.jogador.position.x < (CGRectGetMaxX(self.frame)*self.parteFaseAtual)/2){
    }//else
    
    if (self.jogador.position.x < (nodeBackground.position.x + CGRectGetMidX(self.frame))){
        
        //NSLog(@"metade da tela * partedaFase / 2: %f",(CGRectGetMaxX(self.frame)*self.parteFaseAtual)/2);
        //verifica se ja tem um node com o nome @proxParte - ESTA USANDO IF NOT
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
    NSLog(@"X do back + metade de uma tela: %f",nodeBackground.position.x + CGRectGetMidX(self.frame));
}

-(void)controlaParteFase{
    
    if (self.jogador.position.x > (CGRectGetMaxX(self.frame)*self.parteFaseAtual +5 )) {
        if (self.parteFaseAtual + 1 <= self.nPartesCena ) {
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
    
    //Elimina os nodes marcados para eliminar
    //[[self.mundo childNodeWithName:backgroundEliminar]removeFromParent];
}
@end

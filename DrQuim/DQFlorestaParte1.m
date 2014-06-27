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
{

}

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:1];
        
        
        //ALTERACAO PARA TESTE
        //        self.cutsceneEstaRodando = YES;
        //
        //        [self.controleCutscenes iniciarCutscene:self Seletor:@selector(iniciarFase)];
        
        [self iniciarFase];
        
    }
    return self;
}

-(void)iniciarFase{
    
    self.cutsceneEstaRodando = NO;
    
    //Alterado a inicialização do mundo para usar a variavel da skScene e assim poder manipular ele durante a cena toda
    self.mundo =[SKNode node];
    [self.mundo setName:mundo];
    
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
    
    //Att propriedade
    self.backgroundAtual=primeiraParte;
    
    //Adiciona a primeira parte da tela e o jogador no mundo
    [self.mundo addChild:primeiraParte];
    [self.mundo addChild:self.jogador];
    
    //Adiciona o mundo na scena
    [self addChild:self.mundo];
    
    self.parteFaseAtual=1;
    
    //Provisório
    self.nPartesCena=14;
}

- (void)didSimulatePhysics
{
    
    if (!self.cutsceneEstaRodando) {
        
        
        CGPoint heroPosition = self.jogador.position;
        
        if (heroPosition.x == 560) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoBeta"];
            self.cutsceneEstaRodando = YES;
            
        }
        
        
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
        
        //Leonardo - 25/06/2014 - Alterado para não precisar pesquisar na arvore de nos, pq ja temos acesso direto ao node de mundo
        self.mundo.position = worldPosition;
        
        //Chama método para controlar em que parte da fase esta
        [self controlaParteFase];
        
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
    
}

//metodo chamado assim que um toque e finalizado
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.cutsceneEstaRodando) {
        [self.jogador pararAndar];
    }
    else
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
    
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundFuturo criado
        if (!self.backgroundFuturo) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual + 1 <= self.nPartesCena) {
                NSString *nomeImagemBack=[NSString stringWithFormat:@"parte%i",self.parteFaseAtual+1];
                
                // Alterar para skspritenode
                SKSpriteNode *backgroundFuturo=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorpoint
                backgroundFuturo.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [backgroundFuturo setZPosition: -100.0];
                
                //posiciona após a cena
                backgroundFuturo.position = CGPointMake(self.backgroundAtual.position.x +CGRectGetMaxX(self.frame), 0);
            
                //Corpo fisico
                backgroundFuturo.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual + 1];
                
                //nome do node
                [backgroundFuturo setName:proxBackground];
            
                
                //Atualiza a propriedade e add no mundo
                self.backgroundFuturo = backgroundFuturo;
                
                [self.mundo addChild:self.backgroundFuturo];
            }
        }
    }
    
    if (self.jogador.position.x < (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundAnterior criado
        if (!self.backgroundAnterior) {
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual -1 > 0) {
                
                NSString *nomeImagemBack=[NSString stringWithFormat:@"parte%i",self.parteFaseAtual-1];
                
                // Alterar para skspritenode
                SKSpriteNode *backgroundAnterior=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorpoint
                backgroundAnterior.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [backgroundAnterior setZPosition: -100.0];
                
                //posiciona antes a cena
                backgroundAnterior.position = CGPointMake(self.backgroundAtual.position.x - CGRectGetMaxX(self.frame), 0);
                
                //Corpo fisico
                backgroundAnterior.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual - 1];
                
                //nome do node
                [backgroundAnterior setName:backgroundAnt];
                
                //Add back no mundo
                //[self.mundo addChild:background];
                
                //Atualiza a propriedade e add no mundo
                self.backgroundAnterior= backgroundAnterior;
                
                [self.mundo addChild:self.backgroundAnterior];
                
            }
        }
    }
}

-(void)controlaParteFase{

    //Verifica se o X do jogador é maior que o X da parte + a largura de uma tela
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMaxX(self.frame))){
        if (self.parteFaseAtual + 1 <= self.nPartesCena ) {
            self.parteFaseAtual ++;
            
            //Se ja tem um backAnterior elimina ele
            if (self.backgroundAnterior) {
                [self.backgroundAnterior removeFromParent];
                self.backgroundAnterior=nil;
            }
            
            //Transforma o backAnterior em backAtual
            self.backgroundAnterior=self.backgroundAtual;
            
            //Transforma o back Atual em backFuturo
            self.backgroundAtual=self.backgroundFuturo;
            
            //Transforma o backgroundAtual em nulo, para criar com a imagem e corpo fisico correto
            self.backgroundFuturo=nil;
        }
        
    }
    
    //Verifica se o X do jogador é menor que o X da parte + a largura de uma tela
    if (self.jogador.position.x < self.backgroundAtual.position.x){
        if (self.parteFaseAtual -1 >=1 ) {
            self.parteFaseAtual --;
            
            
            //Se ja tiver um backFuturo elimina ele
            if (self.backgroundFuturo) {
                [self.backgroundFuturo removeFromParent];
                self.backgroundFuturo = nil;
            }
            
            //Transforma o backgroundAtual em backgroundFuturo
            self.backgroundFuturo = self.backgroundAtual;

            //Transforma o backgroundAnterior em backgroundAtual
            self.backgroundAtual = self.backgroundAnterior;
            
            //Transforma o backgroundAtual em nulo, para criar com a imagem e corpo fisico correto
            self.backgroundAnterior=nil;
        }
    }
}
@end

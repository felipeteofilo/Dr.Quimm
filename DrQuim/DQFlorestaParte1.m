//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"
#import "DQControleCorpoFisico.h"

#define bordaCamera 512

@implementation DQFlorestaParte1
{
    SKSpriteNode *plataforma;
    SKSpriteNode *plataformaExtra;
}

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /*
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:1];
        
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;

        [self.controleCutscenes iniciarCutscene:self Seletor:@selector(iniciarFase)];
         */
        [self iniciarFase];
    }
    return self;
}


//Metodo para iniciar fase
-(void)iniciarFase{
    
    self.cutsceneEstaRodando = NO;
    
    //Alterado a inicialização do mundo para usar a variavel da skScene e assim poder manipular ele durante a cena toda
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

//Ultimo Método que é chamado antes de aparecer a tela, usado para arrumar a camera
- (void)didSimulatePhysics
{
    
    if (!self.cutsceneEstaRodando) {
        //Chama método para posicionar camera
        [self posicionaCamera];

        //Chama método para controlar em que parte da fase esta
        [self controlaParteFase];
    }
}

//Método para controle da posição da campera  == BASE ==
-(void)posicionaCamera{
    CGPoint posicaoJogador = self.jogador.position;
    
    //LEONARDO - 25/06/2014 - Foi adicionado propriedade para acessar o mundo
    CGPoint posicaoMundo = self.mundo.position;
    
    
    CGFloat coordenadaX = posicaoMundo.x + posicaoJogador.x ;
    
    if(coordenadaX <= bordaCamera && posicaoJogador.x >= bordaCamera)
    {
        posicaoMundo.x = posicaoMundo.x - coordenadaX  + bordaCamera;
        
    }
    else if(coordenadaX > (self.frame.size.width - bordaCamera) && posicaoJogador.x < (self.nPartesCena *1024) -512)
    {
        posicaoMundo.x = posicaoMundo.x + (self.frame.size.width - coordenadaX) - bordaCamera;
        
    }
    
    //Leonardo - 25/06/2014 - Alterado para não precisar pesquisar na arvore de nos, pq ja temos acesso direto ao node de mundo
    self.mundo.position = posicaoMundo;

    if (posicaoJogador.x > 2470 && posicaoJogador.x < 2475 ) {
        [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoAlfa"];
        
        self.cutsceneEstaRodando = YES;
        self.estaFalando = YES;
        
        [self.jogador pararAndar];
        
        if ([self.jogador.andandoParaDirecao isEqualToString:@"D"]) {
            posicaoJogador.x += 5;
        }
        else
            posicaoJogador.x -=5;
        
        self.jogador.position= posicaoJogador;
        
    }
}

//metodo que e chamado assim que e criada a cena
-(void)didMoveToView:(SKView *)view{
    
    // cria o gesto do pulo e adiciona na cena
    self.gestoPulo = [[DQGestoPulo alloc]init];
    
    [view addGestureRecognizer:self.gestoPulo];
}

//metodo que e chamado assim que um toque é iniciado na cena == BASE ==
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
    }else if(!self.estaFalando){
        [self.controleCutscenes trocarCena];
    }
}

//metodo do delegate de contato que e chamado assim que comeca o contato == BASE ==
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


//Metodo chamado toda hora pela spriteKit, usado para criar as partes do corpo fisico da fase
-(void)update:(NSTimeInterval)currentTime{
    [self criarParteFase];
}

//Cria a parte da fase == BASE ==
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
                
                //Atualiza a propriedade e add no mundo
                self.backgroundFuturo = backgroundFuturo;
                
                //Cria um spriteNode com cor e a plataforma
                plataforma=[[SKSpriteNode alloc]init];
                
                SKPhysicsBody *physicsBodyPlataforma=[DQControleCorpoFisico adicionaPlataformaParte:self.parteFaseAtual+1];
            
                plataformaExtra=[[SKSpriteNode alloc]init];

                //Corpo fisico plataforma Extra
                SKPhysicsBody *physicsBodyPlataformaExtra=[DQControleCorpoFisico criaPlataformaExtra:self.parteFaseAtual + 1];
                
                if (physicsBodyPlataforma) {
                    plataforma.physicsBody=physicsBodyPlataforma;
                    [plataforma setAnchorPoint:CGPointMake(0, 0)];
                    
                    [self.backgroundFuturo addChild:plataforma];

                }
                
                if (physicsBodyPlataformaExtra) {
                    plataformaExtra.physicsBody=physicsBodyPlataformaExtra;
                    
                    [plataformaExtra setAnchorPoint:CGPointMake(0, 0)];
                    plataformaExtra.position=CGPointMake(0, -70);
                    
                    [self.backgroundFuturo addChild:plataformaExtra];
                }
                
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
                
                //Atualiza a propriedade e add no mundo
                self.backgroundAnterior= backgroundAnterior;
                
                //Cria um spriteNode com cor e a plataforma
                plataforma=[[SKSpriteNode alloc]init];
                
                //plataformaExtra
                plataformaExtra=[[SKSpriteNode alloc]init];
                
                //Corpo fisico plat padrao
                SKPhysicsBody *corpoFisicoPlataforma=[DQControleCorpoFisico adicionaPlataformaParte:self.parteFaseAtual - 1];
                
                //Corpo fisico plataforma Extra
                SKPhysicsBody *corpoFisicoPlataformaExtra=[DQControleCorpoFisico criaPlataformaExtra:self.parteFaseAtual - 1];
                
                if (corpoFisicoPlataforma) {
                    plataforma.physicsBody=corpoFisicoPlataforma;
                    //plataforma.position=[DQControleCorpoFisico origemPlataforma:self.parteFaseAtual+1];
                    [plataforma setAnchorPoint:CGPointMake(0, 0)];
                    
                    //Adiciona a plataforma no backFuturo para que fique com a posicao em relacao a ele
                    [self.backgroundAnterior addChild:plataforma];
                    
                }
                
                if (corpoFisicoPlataformaExtra) {
                    plataformaExtra.physicsBody=corpoFisicoPlataformaExtra;
                    
                    [plataformaExtra setAnchorPoint:CGPointMake(0, 0)];
                    plataformaExtra.position=CGPointMake(0, -70);
                    
                    [self.backgroundAnterior addChild:plataformaExtra];
                }

                [self.mundo addChild:self.backgroundAnterior];
                
            }
        }
    }
}

//controla as partes da fase == BASE ==
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

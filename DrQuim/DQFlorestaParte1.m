//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"
#import "DQControleCorpoFisico.h"

#define bordaCameraX 512
#define bordaCameraY 384

@implementation DQFlorestaParte1

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:1];
        
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        
        //[self.controleCutscenes iniciarCutscene:self Seletor:@selector(iniciarFase)];
        
        [self iniciarFase];
    }
    return self;
}


//Metodo para iniciar fase
-(void)iniciarFase{
    
    self.cutsceneEstaRodando = NO;
    
    //PROVISÓrio
    self.parteFaseAtual=1;
    self.faseAtual=1;
    self.nPartesCena=14;
    
    //Alterado a inicialização do mundo para usar a variavel da skScene e assim poder manipular ele durante a cena toda
    self.mundo =[SKNode node];
    [self.mundo setName:mundo];
    [self.mundo setZPosition:-100];
    
    //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
    self.physicsWorld.gravity=CGVectorMake(0, -3);
    
    SKSpriteNode *primeiraParte =[SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"Fase%i_Parte%i",self.faseAtual,self.parteFaseAtual]];
                                  
    
    
    
    [primeiraParte setAnchorPoint:CGPointMake(0, 0)];
    [primeiraParte setPosition:CGPointMake(0,0)];
    
    primeiraParte.physicsBody=[DQControleCorpoFisico criaCorpoFisicoChaoParte:self.parteFaseAtual daFase:self.faseAtual];
    primeiraParte.physicsBody.categoryBitMask=ChaoCategoria;
    primeiraParte.physicsBody.usesPreciseCollisionDetection = YES;
    primeiraParte.physicsBody.dynamic = NO;
    
    
    
    //Leonardo - inicializa o jogador
    //Inicia o jogador pelo singleton
    self.jogador = [DQJogador sharedJogador];
    
    //seta as categorias de colisao do jogador
    self.jogador.physicsBody.categoryBitMask=JogadorCategoria;
    self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
    self.jogador.physicsBody.collisionBitMask=ChaoCategoria;
    
    //Seta que a classe que ira delegar o contato sera essa mesma
    [self.physicsWorld setContactDelegate:self];
    
    
    
    //Att propriedade
    self.backgroundAtual = primeiraParte;
    
    //Adiciona a primeira parte da tela e o jogador no mundo
    [self.mundo addChild:self.backgroundAtual];
    [self.mundo addChild:self.jogador];
    

    //Adiciona o mundo na scena
    [self addChild:self.mundo];
    

    //inicia as variaveis booleanas para falas - juliaFez
    self.falouRadiacaoAlpha = NO;
    self.falouRadiacaoBeta = NO;
    
    //Adiciona plataforma caso tenha
    SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parteFaseAtual daFase:self.faseAtual CGFrameTela:self.frame];
    
    [self adicionarPlataforma:plataforma noNode:self.backgroundAtual];
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
    
    //Pega as coordenadas do jogador em relacao ao mundo
    CGFloat coordenadaX = posicaoMundo.x + posicaoJogador.x;
    CGFloat coordenadaY = posicaoMundo.y + posicaoJogador.y;
    
    
   
    
    //Verifica se as coordenadas do jogador em relacao ao mundo e sua real posicao o posicionando sempre ao centro da tela
    if(coordenadaX <= bordaCameraX && posicaoJogador.x >= bordaCameraX)
    {
        posicaoMundo.x = posicaoMundo.x - coordenadaX  + bordaCameraX;
        
    }
    if(coordenadaY <= bordaCameraY && posicaoJogador.y >= bordaCameraY)
    {
        posicaoMundo.y = posicaoMundo.y - coordenadaY  + bordaCameraY;
        
    }
    
    //Verifica se as coordenadas do jogador em relacao ao mundo nao ultrpassam os limites impostos e o posiciona corretamente, lembrando sempre que o mundo que e reposicionado.
    if(coordenadaX > (self.frame.size.width - bordaCameraX) && posicaoJogador.x < (self.nPartesCena *1024) -bordaCameraX)
    {
        posicaoMundo.x = posicaoMundo.x + (self.frame.size.width - coordenadaX) - bordaCameraX;
        
    }
    if(coordenadaY > (self.frame.size.height - bordaCameraY) && posicaoJogador.y < 1536 - bordaCameraY)
    {
        posicaoMundo.y = posicaoMundo.y + (self.frame.size.height - coordenadaY) - bordaCameraY;
        
    }
    

    //seta a nova posicao do mundo
    self.mundo.position = posicaoMundo;
}

//metodo que e chamado assim que um toque é iniciado na cena == BASE ==
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Se não está falando e nem em cutscene...
    if (!self.cutsceneEstaRodando && !self.estaFalando) {
        //Verifica em qual lado da tela o jogador está tocando
        UITouch *posicao = [touches anyObject];
        
        
        //Jeito porco irei arrumar
        CGPoint posicaoDoToque = [posicao locationInNode:self];
        SKSpriteNode *nodeTocado = (SKSpriteNode *)[self nodeAtPoint:posicaoDoToque];
        
        if ([[nodeTocado name] isEqualToString:@"RadiacaoAlfa"]) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoAlfa"];
            
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
        }
        else if ([[nodeTocado name] isEqualToString:@"RadiacaoBeta"]) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoBeta"];
            
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
        }

        else{
        
            //Se estiver na direita
            if([posicao locationInView:self.view].x > self.frame.size.height/2){
                //ANDAR
                //marca o local em que tocou e desenha as setinhas
                self.pontoDeToqueAndar = [posicao locationInView:self.view];
                
                //mostra as setinhas
                self.setinhas = [SKSpriteNode spriteNodeWithImageNamed:@"setinhas"];
                [self.setinhas setPosition: CGPointMake(self.pontoDeToqueAndar.x, self.frame.size.height - self.pontoDeToqueAndar.y)];
                
                [self addChild:self.setinhas];
            }
            
            //Se estiver na esquerda
            else if([posicao locationInView:self.view].x < self.frame.size.height/2){
                //PULAR
                // Pega o singleton do jogador e o faz pular
                [[DQJogador sharedJogador] pular];
                
            }
        }
    }
    
    //Se estiver falando em jogo...
    else if(self.estaFalando){
        if ([self.controleCutscenes trocarFala]) {
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:nil];
            
        }
        else{
            
            self.estaFalando = NO;
            self.cutsceneEstaRodando = NO;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *posicao = [touches anyObject];
    
    //Anda corretamente apenas e for do lado direito da tela
    if([posicao locationInView:self.view].x > self.frame.size.height/2){
        //Verifica se não está rodando cutscene ou falando
        if (!self.cutsceneEstaRodando && !self.estaFalando) {
            
            //se moveu para a direita, anda para a direita - D
            if([posicao locationInView:self.view].x > self.pontoDeToqueAndar.x){
                if (![self.jogador.andandoParaDirecao isEqualToString:@"D"]) {
                    [self.jogador andarParaDirecao:@"D"];
                }
            }
            
            //senão, move para a esquerda - E
            else{
                if (![self.jogador.andandoParaDirecao isEqualToString:@"E"] ) {
                    [self.jogador andarParaDirecao:@"E"];
                }
            }
        }
    }
    
}

//metodo chamado assim que um toque e finalizado
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.cutsceneEstaRodando) {
        //faz parar de andar, colocando a direção como nula
        [self.jogador setAndandoParaDirecao:@" "];
        [self.jogador pararAndar];
        
    }else if(!self.estaFalando){
        [self.controleCutscenes trocarCena];
    }
    
    //tirar imagem da setinha da tela
    [self.setinhas removeFromParent];
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
    NSLog(@"X: %0.0f| Y: %0.0f", self.jogador.position.x, self.jogador.position.y);
    [self executaFalasDoJogo];
}

//FALTANDO AS FALAS DA AGUA - PRECISA PEGAR COORDENADA CERTINHA
//FALTANDO AS FALAS DA RADIACAOREPETIDA - PRECISA PEGAR COORDENADA CERTINHA
-(void)executaFalasDoJogo
{
    //cria os pontos de menssagem
    CGPoint pontoAlpha;
    CGPoint pontoBeta;
    
    //inicia-os com suas coordenadas
    //-> alpha
    pontoAlpha = CGPointMake(3290, 1000);
    //-> beta
    pontoBeta = CGPointMake(5798, 1170);
    
    //verifica contato
    //-> alpha
    //Se o jogador estiver perto da radiacao comeca a apitar
    if (self.jogador.position.x > pontoAlpha.x - 50  && self.jogador.position.x < pontoAlpha.x +10) {
        
        //Se ja houver algum apito aguarda para tocar outro
        if (![self hasActions]) {
            [self runAction:[SKAction playSoundFileNamed:@"beep.mp3" waitForCompletion:YES]];
        }
        
        //se o jogador chegar ao local da fala, comeca a fala
        if((self.jogador.position.x >= pontoAlpha.x && self.jogador.position.y >= pontoAlpha.y) && !self.falouRadiacaoAlpha){
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoAlfa"];
            
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
            
            [self.jogador pararAndar];
            self.falouRadiacaoAlpha = YES;
            
            //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
            SKSpriteNode * iconeRadiacaoAlpha = [[ SKSpriteNode alloc]initWithImageNamed:@"Jogador"];
            iconeRadiacaoAlpha.size = CGSizeMake(50, 50);
            [iconeRadiacaoAlpha setAnchorPoint:CGPointMake(0,0 )];
            [iconeRadiacaoAlpha setPosition:pontoAlpha];
            [iconeRadiacaoAlpha setName:@"RadiacaoAlfa"];
            [self.jogador setZPosition:1];
            [self.mundo insertChild:iconeRadiacaoAlpha atIndex:0];
        }
    }

    //-> beta
    if (self.jogador.position.x > pontoBeta.x - 50 && self.jogador.position.x < pontoBeta.x  +10 && self.jogador.position.y > pontoBeta.y - 20) {
       
        //Se ja houver algum apito aguarda para tocar outro
        if (![self hasActions]) {
            [self runAction:[SKAction playSoundFileNamed:@"beep.mp3" waitForCompletion:YES]];
        }
        
        //se o jogador chegar ao local da fala, comeca a fala
        if( (self.jogador.position.x > pontoBeta.x && self.jogador.position.y > pontoBeta.y) && !self.falouRadiacaoBeta){
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoBeta"];
            
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
            
            [self.jogador pararAndar];
            self.falouRadiacaoBeta = YES;
            
            //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
            SKSpriteNode * iconeRadiacaoBeta = [[ SKSpriteNode alloc]initWithImageNamed:@"Jogador"];
            iconeRadiacaoBeta.size = CGSizeMake(50, 50);
            [iconeRadiacaoBeta setAnchorPoint:CGPointMake(0,0 )];
            [iconeRadiacaoBeta setPosition:pontoBeta];
            
            [iconeRadiacaoBeta setName:@"RadiacaoBeta"];
            [self.jogador setZPosition:1];
            [self.mundo insertChild:iconeRadiacaoBeta atIndex:0];
        }
    }
}

//Cria a parte da fase == BASE ==
-(void)criarParteFase{
    
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundFuturo criado
        if (!self.backgroundFuturo) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual + 1 <= self.nPartesCena) {
                NSString *nomeImagemBack=[NSString stringWithFormat:@"Fase%i_Parte%i",self.faseAtual,self.parteFaseAtual+1];
                
                // Alterar para skspritenode
                SKSpriteNode *backgroundFuturo=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorpoint
                backgroundFuturo.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [backgroundFuturo setZPosition: -100.0];
                
                //posiciona após a cena
                backgroundFuturo.position = CGPointMake(self.backgroundAtual.position.x +CGRectGetMaxX(self.frame), 0);
            
                //Corpo fisico
                //backgroundFuturo.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual + 1];
                backgroundFuturo.physicsBody=[DQControleCorpoFisico criaCorpoFisicoChaoParte:self.parteFaseAtual+1 daFase:self.faseAtual];
                
                //Atualiza a propriedade e add no mundo
                self.backgroundFuturo = backgroundFuturo;
                 
                SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parteFaseAtual+1 daFase:self.faseAtual CGFrameTela:self.frame];
                
                [self adicionarPlataforma:plataforma noNode:self.backgroundFuturo];
                
                
                [self.mundo addChild:self.backgroundFuturo];
                
                //NSLog(@"%u", plataforma.physicsBody.collisionBitMask);
            }
        }
    }
    
    if (self.jogador.position.x < (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundAnterior criado
        if (!self.backgroundAnterior) {
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual -1 > 0) {
                
                NSString *nomeImagemBack=[NSString stringWithFormat:@"Fase%i_Parte%i",self.faseAtual,self.parteFaseAtual-1];
                
                // Alterar para skspritenode
                SKSpriteNode *backgroundAnterior=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
                
                //Atualiza o anchorpoint
                backgroundAnterior.anchorPoint=CGPointMake(0, 0);
                
                //Deixa o background no fundo da tela
                [backgroundAnterior setZPosition: -100.0];
                
                //posiciona antes a cena
                backgroundAnterior.position = CGPointMake(self.backgroundAtual.position.x - CGRectGetMaxX(self.frame), 0);
                
                //Corpo fisico
                //backgroundAnterior.physicsBody=[DQControleCorpoFisico criaCorpoFísicoBase: self.parteFaseAtual - 1];
                backgroundAnterior.physicsBody=[DQControleCorpoFisico criaCorpoFisicoChaoParte:self.parteFaseAtual-1 daFase:self.faseAtual];
                
                //Atualiza a propriedade e add no mundo
                self.backgroundAnterior= backgroundAnterior;
                
                //Adiciona plataformas
                
                SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parteFaseAtual-1 daFase:self.faseAtual CGFrameTela:self.frame];
                
                [self adicionarPlataforma:plataforma noNode:self.backgroundAnterior];
            
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

-(void)adicionarPlataforma:(SKNode*)plataformaAdd noNode:(SKNode*)nodeAddPlataforma{
 
    if (plataformaAdd) {
        
        int I=0;
        
        for (DQPlataforma *plataforma in [plataformaAdd children]) {
           /*
            [plataforma setName:@"plataforma"];
            [plataforma.physicsBody setCategoryBitMask:PlataformaCategoria];
            [plataforma.physicsBody setCollisionBitMask:0];
            */
            I++;
        }
        //NSLog(@"N plataformas %i",I);
        
        [nodeAddPlataforma addChild:plataformaAdd];
    }
}
@end

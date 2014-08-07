//
//  DQFase.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 09/07/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFase.h"

#define bordaCameraX 512
#define bordaCameraY 384

@implementation DQFase

//Método para controle da posição da campera
-(void)posicionaCamera{
    
    CGPoint posicaoJogador = self.jogador.position;
    CGPoint posicaoMundo = self.mundo.position;
    CGPoint coordenadaXY=CGPointMake(posicaoMundo.x + posicaoJogador.x, posicaoMundo.y + posicaoJogador.y);
    
    //Verifica se as coordenadas do jogador em relacao ao mundo e sua real posicao o posicionando sempre ao centro da tela
    if(coordenadaXY.x <= bordaCameraX && posicaoJogador.x >= bordaCameraX)
    {
        posicaoMundo.x = posicaoMundo.x - coordenadaXY.x  + bordaCameraX;
    }
    
    if(coordenadaXY.y <= bordaCameraY && posicaoJogador.y >= bordaCameraY)
    {
        posicaoMundo.y = posicaoMundo.y - coordenadaXY.y  + bordaCameraY;
    }
    
    //Verifica se as coordenadas do jogador em relacao ao mundo nao ultrpassam os limites impostos e o posiciona corretamente, lembrando sempre que o mundo que e reposicionado.
    if(coordenadaXY.x > (self.frame.size.width - bordaCameraX) && posicaoJogador.x < (self.nPartesFase *1024) -bordaCameraX)
    {
        posicaoMundo.x = posicaoMundo.x + (self.frame.size.width - coordenadaXY.x) - bordaCameraX;
    }
    if(coordenadaXY.y > (self.frame.size.height - bordaCameraY) && posicaoJogador.y < 1536 - bordaCameraY)
    {
        posicaoMundo.y = posicaoMundo.y + (self.frame.size.height - coordenadaXY.y) - bordaCameraY;
    }
    
    //seta a nova posicao do mundo
    self.mundo.position = posicaoMundo;
}

-(void)controlarTranscicaoPartesFase{
    
    //Verifica se o X do jogador é maior que o X da parte + a largura de uma tela
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMaxX(self.frame))){
        if (self.parteFaseAtual + 1 <= self.nPartesFase ) {
            self.parteFaseAtual ++;
            
            [self removerNodeBackground:self.backgroundAnterior];
            
            //Transforma o Atual em Anterior
            self.backgroundAnterior=self.backgroundAtual;
            
            //Transforma o backFuturo em Atual
            self.backgroundAtual=self.backgroundFuturo;
            
            //Transforma o backgroundAtual em nulo, para criar com a imagem e corpo fisico correto
            self.backgroundFuturo=nil;
        }
    }
    
    //Verifica se o X do jogador é menor que o X da parte + a largura de uma tela
    if (self.jogador.position.x < self.backgroundAtual.position.x){
        if (self.parteFaseAtual -1 >=1 ) {
            self.parteFaseAtual --;
            
            [self removerNodeBackground:self.backgroundFuturo];
            
            //Transforma o backgroundAtual em backgroundFuturo
            self.backgroundFuturo = self.backgroundAtual;
            
            //Transforma o backgroundAnterior em backgroundAtual
            self.backgroundAtual = self.backgroundAnterior;
            
            //Transforma o backgroundAtual em nulo, para criar com a imagem e corpo fisico correto
            self.backgroundAnterior=nil;
        }
    }
}

-(void)removerNodeBackground:(SKNode*)nodeRemover{
    if (nodeRemover) {
        [nodeRemover removeFromParent];
        nodeRemover = nil;
    }
}

-(void)adicionarPlataforma:(SKNode*)plataformaAdd noNode:(SKNode*)nodeAddPlataforma{
    if (plataformaAdd) {
        for (DQPlataforma *plataforma in [plataformaAdd children]) {
            [self plataformaCategoria:plataforma];
        }
        
        [nodeAddPlataforma addChild:plataformaAdd];
    }
}

-(void)chaoCategoria:(SKNode*)node{
    //Chao Categoria
    node.physicsBody.categoryBitMask=ChaoCategoria;
    node.physicsBody.collisionBitMask=JogadorCategoria;
    node.physicsBody.contactTestBitMask=JogadorCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}

-(void)jogadorCategoria:(SKNode*)node{
    //Chao Categoria
    node.physicsBody.categoryBitMask=JogadorCategoria;
    node.physicsBody.collisionBitMask=ChaoCategoria;
    node.physicsBody.contactTestBitMask= PlataformaCategoria;
    //node.physicsBody.contactTestBitMask= EscadaCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}
-(void)escadaCategoria :(SKNode*)node{
    node.physicsBody.categoryBitMask=EscadaCategoria;
    node.physicsBody.collisionBitMask=0;
    node.physicsBody.contactTestBitMask=JogadorCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}
-(void)plataformaCategoria:(SKNode*)node{
    //Chao Categoria
    node.physicsBody.categoryBitMask=PlataformaCategoria;
    node.physicsBody.collisionBitMask=0;
    node.physicsBody.contactTestBitMask=JogadorCategoria;
    node.physicsBody.usesPreciseCollisionDetection=YES;
}

-(SKSpriteNode*)configurarBackgroundParte:(int)parte naPos:(CGPoint)posicao{
    NSString *nomeImagemBack=[NSString stringWithFormat:@"Fase%i_Parte%i",self.faseAtual,parte];
    
    SKSpriteNode *backConfigurar=[SKSpriteNode spriteNodeWithImageNamed:nomeImagemBack];
    
    //Atualiza o anchorpoint
    [backConfigurar setAnchorPoint:CGPointMake(0, 0)];
    
    //Deixa o background no fundo da tela
    [backConfigurar setZPosition: -100.0];
    
    //posiciona após a cena
    [backConfigurar setPosition:posicao];
    
    //Corpo fisico
    [backConfigurar setPhysicsBody:[DQControleCorpoFisico criaCorpoFisicoChaoParte:parte daFase:self.faseAtual]];
    
    //Configura a categoria do chao do prox Back
    [self chaoCategoria:backConfigurar];
    
    return backConfigurar;
}





-(void)criarParteFase{
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundFuturo criado
        if (!self.backgroundFuturo) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual + 1 <= self.nPartesFase) {
                
                CGPoint posicaoAdd=CGPointMake(self.backgroundAtual.position.x +CGRectGetMaxX(self.frame), 0);
                self.backgroundFuturo=[self configurarBackgroundParte:self.parteFaseAtual+1 naPos:posicaoAdd];
                
                
                //Configura Cobertura para Background (criar efeito caverna)
                DQCoberturaBackground *coberturaBackground=[[DQCoberturaBackground alloc]initCoberturaParte:self.parteFaseAtual+1 daFase:self.faseAtual];
                
                if (coberturaBackground) {
                    [self.backgroundFuturo addChild:coberturaBackground];
                }
                
                //Cria Corpo Fisico para plataformas
                SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parteFaseAtual+1 daFase:self.faseAtual CGFrameTela:self.frame];
                [plataforma setName:NomeNodePlataformas];
                
                [self adicionarPlataforma:plataforma noNode:self.backgroundFuturo];
                [self.mundo addChild:self.backgroundFuturo];
                
                
                if (![self childNodeWithName:nomeEscalavel]) {
                    [self adicionarEscalavelnoBackhround:self.backgroundFuturo Parte:self.parteFaseAtual+1];
                }
            }
        }
    }
    
    if (self.jogador.position.x < (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundAnterior criado
        if (!self.backgroundAnterior) {
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual -1 > 0) {
                CGPoint posicaoAdd=CGPointMake(self.backgroundAtual.position.x -CGRectGetMaxX(self.frame), 0);
                self.backgroundAnterior =[self configurarBackgroundParte:self.parteFaseAtual-1 naPos:posicaoAdd];
                
                
                //Cobertura backgroung (efeito caverna)
                //Configura Cobertura para Background (criar efeito caverna)
                DQCoberturaBackground *coberturaBackground=[[DQCoberturaBackground alloc]initCoberturaParte:self.parteFaseAtual-1 daFase:self.faseAtual];
                
                if (coberturaBackground) {
                    [self.backgroundAnterior  addChild:coberturaBackground];
                }
                
                //Adiciona plataformas
                SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parteFaseAtual-1 daFase:self.faseAtual CGFrameTela:self.frame];
                [plataforma setName:NomeNodePlataformas];
                
                [self adicionarPlataforma:plataforma noNode:self.backgroundAnterior];
                [self.mundo addChild:self.backgroundAnterior];
                
                if (![self childNodeWithName:nomeEscalavel]) {
                    [self adicionarEscalavelnoBackhround:self.backgroundAnterior Parte:self.parteFaseAtual-1];
                }
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *toque=[touches anyObject];
    CGPoint posicaoToque=[toque locationInView:self.view];
    
    //Se estiver na direita
    
    if(posicaoToque.x > CGRectGetMidX(self.frame)){
        //ANDAR
        //marca o local em que tocou e desenha as setinhas
        self.pontoDeToqueAndar = posicaoToque;
        
        //mostra as setinhas
        self.direcional = [SKSpriteNode spriteNodeWithImageNamed:@"setinhas"];
        [self.direcional setPosition: CGPointMake(self.pontoDeToqueAndar.x, self.frame.size.height - self.pontoDeToqueAndar.y)];
        
        [self addChild:self.direcional];
    }
    //Se estiver na esquerda
    else if(posicaoToque.x < CGRectGetMidX(self.frame)){
        //PULAR
        [self.jogador pular];
    }
    
    
    CGPoint posToqueBackGround=[toque locationInNode:self.backgroundAtual];
    
    //Pega o node de escada na posicao do toque
    SKNode *nodeTocado=[self.backgroundAtual nodeAtPoint:posToqueBackGround];
    
    //verifica para onde o jogador deve escalar
    if ([nodeTocado.name isEqualToString:nomeEscalavel]) {
        //Verifica se o Y é maior ou menor
        
        if (posToqueBackGround.y > (self.jogador.position.y+20.0)) {
            //Fazer jogador escalar - Subindo
            [self.jogador escalarParaDirecao:@"C"];
            
        }else if (posToqueBackGround.y < (self.jogador.position.y-20.0)){
            //Fazer jogador escalar - Descendo
            [self.jogador escalarParaDirecao:@"B"];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *toque = [touches anyObject];
    CGPoint posicaoToque=[toque locationInNode:self];
    
    //Anda corretamente apenas e for do lado direito da tela
    if(posicaoToque.x > CGRectGetMidX(self.frame)){
        //se moveu para a direita, anda para a direita - D
        if(posicaoToque.x > self.pontoDeToqueAndar.x){
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

-(void)verificaCoberturaBackground{
    DQCoberturaBackground *cobetura=(DQCoberturaBackground*)[self.backgroundAtual childNodeWithName:NomeNodeCobertura];
    
    if ([cobetura.name isEqualToString:NomeNodeCobertura]) {
        //Converte a posicao do jogador para o sistema de coordenadas do no que tem a cobertura
        CGPoint posJogadorConvertida=[self.mundo convertPoint:self.jogador.position toNode:self.backgroundAtual];
        
        [cobetura manipulaCobertura:posJogadorConvertida];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    //faz parar de andar, colocando a direção como nula
    [self.jogador setAndandoParaDirecao:@" "];
    [self.jogador pararAndar];
    
    //tirar imagem da setinha da tela
    [self.direcional removeFromParent];
    
    //Ao parar o toque, pausa sua escalada se ainda estiver escalando
    if ([self.jogador actionForKey:@"escalar"]) {
        [self.jogador pausarEscalada];
    }
    
    CGPoint posicaoToqueNode=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posicaoToqueNode];
    
    if ([self childNodeWithName:@"MENU"]) {
        [[self childNodeWithName:@"MENU"]removeFromParent];
        //[self.mundo setPaused:NO];
    }
    
    for (SKSpriteNode *nodeTocado in arrayNodes) {
        if ([nodeTocado.name isEqualToString:@"botaoMenu"]) {
            if (!self.menu) {
                self.menu=[[DQMenu alloc]initMenu];
                [self.menu setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
                
            }
            
            if (![self childNodeWithName:@"MENU"]) {
                [self addChild:self.menu];
                //[self.mundo setPaused:YES];
            }
            
            break;
        }
    }
}


//Metodo chamado ao final de alguma colisao
-(void)didEndContact:(SKPhysicsContact *)contact{
    
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
    if ((firstBody.categoryBitMask & JogadorCategoria)!=0) {
        if ((secondBody.categoryBitMask & ChaoCategoria) !=0) {
            
            //se o jogador  parar  de colidir com o chao setamos que ele nao esta no chao
            [self.jogador setEstaNoChao:NO];
            
        }
    }
    
    
    //se parou de colidir com a escada
    if ([secondBody.node.name isEqualToString:nomeEscalavel]) {
        //faz o jogador parar de escalar
        [self.jogador pararEscalar];
    }
}

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
            [self.jogador setEstaNoChao:YES];
            if (![self.jogador.spriteNode actionForKey:@"animandoAndando"] && [self.jogador actionForKey:@"andar"] ) {
                [self.jogador animarAndando];
            }
        }
        
        if ([secondBody.node.name isEqualToString:nomePlataforma]){
            
            //Adiciona + 50 de tolerancia
            float yPlataforma =[[secondBody.node.userData objectForKey:nomeMaiorY]floatValue] + 30.0f;
            
            
            
            //Verifica se jogador esta abaixo da plataforma que colidiu
            if (firstBody.node.position.y < yPlataforma ) {
                [self plataformaCategoria:secondBody.node];
                
            }else if((firstBody.velocity.dy <= 0) && (firstBody.node.position.y > yPlataforma )){
                [self chaoCategoria:secondBody.node];
            }
        }
        
        //se colidir com a escada
        if ([secondBody.node.name isEqualToString:nomeEscalavel]) {
            //seta que o jogador pode subir ou descer
            [self.jogador setPodeEscalar:YES];
            
        }
        
    }
}

-(void)update:(NSTimeInterval)currentTime{
    [self criarParteFase];
    [self verificaCoberturaBackground];
    
    [self.controladorDaVida atualizarSituacaoJogador];
    
}

- (void)didSimulatePhysics{
    //Chama método para posicionar camera
    [self posicionaCamera];
    
    //Chama método para controlar em que parte da fase esta
    [self controlarTranscicaoPartesFase];
    
    //Desativa plataformas
    [self desativaPlataformas];
    
    //Faz algumas verificacoes para animar o jogador
    [self verificarAnimacaoCaindo];
    [self verificarAnimacaoDerrapagem];
    
}

//funcao para vefrificar se pode animar jogador caindo de altas distancias
-(void)verificarAnimacaoCaindo{
    //se esta caindo de uma distancia muito grande anima ele caindo
    if ( !self.jogador.estaNoChao && self.jogador.physicsBody.velocity.dy < -535 && ![self.jogador.spriteNode actionForKey:@"animandoCaindo"]) {
        [self.jogador animarCaindo];
    }
}

//funcao para verificar se pode animar jogador derrapando
-(void)verificarAnimacaoDerrapagem{
    //se jogador esta derrapando anima ele derrapando
    if ( self.jogador.estaNoChao && (self.jogador.physicsBody.velocity.dx < -10 || self.jogador.physicsBody.velocity.dx > 10) && ![self.jogador.spriteNode actionForKey:@"animandoAndando"] && ![self.jogador.spriteNode actionForKey:@"animandoDerrapando"]) {
        [self.jogador animarDerrapando];
    }
    //se nao retira a animacao
    if ([self.jogador.spriteNode actionForKey:@"animandoDerrapando"] && self.jogador.physicsBody.velocity.dx == 0 ) {
        [self.jogador pararDerrapar];
    }
}

-(void)configuraFisicaMundo{
    //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
    self.physicsWorld.gravity=CGVectorMake(0, -3);
    
    //Seta que a classe que ira delegar o contato sera essa mesma
    [self.physicsWorld setContactDelegate:self];
    
    //Cria um corpo fisico ao redor da tela para nao deixar o jogador cair pela lateral
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];
    
}

-(void)criaJogador{
    //Leonardo - inicializa o jogador
    //Inicia o jogador pelo singleton
    self.jogador = [DQJogador sharedJogador];
    
    [self.jogador iniciarAnimacoes:[DQConfiguracaoFase animacoesJogadorFase:self.faseAtual]];
    //seta as categorias de colisao do jogador
    [self jogadorCategoria:self.jogador];
    
    CGPoint pontoInicial=[DQConfiguracaoFase posicaoInicialJogadorFase:self.faseAtual];
    
    [self.jogador setPosition:pontoInicial];
    
    if (!self.mundo) {
        NSLog(@"POR FAVOR INICIE O MUNDO ANTES DE CHAMAR A CRIAÇÃO DO JOGADOR");
    }else {
        [self.jogador removeFromParent];
        [self.mundo addChild:self.jogador];
    }
}

-(void)configuracoesFase:(int)faseAtual{
    self.faseAtual=faseAtual;
    self.parteFaseAtual=1;
    self.nPartesFase=[DQConfiguracaoFase nPartesFase:self.faseAtual];
}

-(void)iniciarFase{
    
    //Alterado a inicialização do mundo para usar a variavel da skScene e assim poder manipular ele durante a cena toda
    self.mundo =[SKNode node];
    
    [self.mundo setZPosition:-100];
    
    self.controladorDaVida = [DQVidaControle sharedControleVida];
    
    self.backgroundAtual =[SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"Fase%i_Parte%i",self.faseAtual,self.parteFaseAtual]];
    [self.backgroundAtual setAnchorPoint:CGPointMake(0, 0)];
    [self.backgroundAtual setPosition:CGPointMake(0,0)];
    [self.backgroundAtual setPhysicsBody:[DQControleCorpoFisico criaCorpoFisicoChaoParte:self.parteFaseAtual daFase:self.faseAtual]];
    self.backgroundAtual.physicsBody.dynamic = NO;
    
    [self chaoCategoria:self.backgroundAtual];
    
    //Adiciona a primeira parte da tela e o jogador no mundo
    [self.mundo addChild:self.backgroundAtual];
    
    //Adiciona o mundo na scena
    [self addChild:self.mundo];
    
    //Adiciona plataforma caso tenha
    SKNode *plataforma=[DQControleCorpoFisico criarPlataformaParte:self.parteFaseAtual daFase:self.faseAtual CGFrameTela:self.frame];
    
    [self adicionarPlataforma:plataforma noNode:self.backgroundAtual];
    
    [self plataformaCategoria:plataforma];
    
    [self criaJogador];
    [self configuraFisicaMundo];
}

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}
-(void)desativaPlataformas{
    //Se tiver um node com plataformas
    if ([self.backgroundAtual childNodeWithName:NomeNodePlataformas]) {
        
        //Para cada node plataforma no Node que contem as plataformas verificar
        for (SKNode *plataforma in [[self.backgroundAtual childNodeWithName:NomeNodePlataformas]children]) {
            if ([[plataforma.userData objectForKey:nomeMaiorY]floatValue] > self.jogador.position.y) {
                //Evita ficar chamando toda hora
                if (!(plataforma.physicsBody.categoryBitMask & PlataformaCategoria)!=0) {
                    [self plataformaCategoria:plataforma];
                }
            }
        }
    }
}

-(void)configuraBotaoMenu{
    self.botaoMenu=[SKSpriteNode spriteNodeWithImageNamed:@"botaoMenu"];
    [self.botaoMenu setPosition:CGPointMake(CGRectGetMidX(self.frame),self.hudFase.position.y-150)];
    
    [self.botaoMenu setName:@"botaoMenu"];
    //[self.botaoMenu setScale:0.9];
    [self addChild:self.botaoMenu];
}

-(void)adicionarEscalavelnoBackhround:(SKSpriteNode*)background Parte:(int)parte{
    //Adiciona escada caso tenha
    NSArray *arrayEscalaveis=[DQConfiguracaoFase escalavelFase:self.faseAtual Parte:parte];
    
    for (int i=0;i<[arrayEscalaveis count];i++) {
        
        //Cada posicao no array de escalaveis tem apenas 2 posicoes (Ponto inicial e ponto Final do escalavel)
        CGPoint pontoInicial= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:0]);
        CGPoint pontoFinal= CGPointFromString([[arrayEscalaveis objectAtIndex:i]objectAtIndex:1]);
        
        //cria a escada e seta o corpo fisico dela
        DQEscalavel *escada=[[DQEscalavel alloc]initEscalavelComPontoInicial:pontoInicial ePontoFinal:pontoFinal eLargura:50.0f];
        
        [self escadaCategoria:escada];
        
        [background addChild:escada];
    }
}

@end

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

#pragma mark Inicio e Configuracao da Fase
-(id)initFase:(int)fase Size:(CGSize)size{
    
    if (self=[super initWithSize:size ]) {
        
        [self configuracoesFase:fase];
    }
    return self;
}

-(NSDictionary*)infoParteFase:(int)parte{
    return [[self.configFase objectForKey:@"Partes"]objectAtIndex:parte-1];
}

-(void)configuracoesFase:(int)faseAtual{
    
    self.faseAtual=faseAtual;
    self.parteFaseAtual=1;
    self.nPartesFase=[DQConfiguracaoFase nPartesFase:self.faseAtual];
    
    [self pegarConfigFase:self.faseAtual];
    [self iniciarFase];
}

-(void)pegarConfigFase:(int)fase{
    self.configFase=[DQConfiguracaoFase configFase:self.faseAtual];
}

-(void)configuraFisicaMundo{
    //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
    self.physicsWorld.gravity=CGVectorMake(0, -3);
    
    //Seta que a classe que ira delegar o contato sera essa mesma
    [self.physicsWorld setContactDelegate:self];
    
    //Cria um corpo fisico ao redor da tela para nao deixar o jogador cair pela lateral
    [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];
    
}

-(void)iniciarFase{
    
    //Alterado a inicialização do mundo para usar a variavel da skScene e assim poder manipular ele durante a cena toda
    self.mundo =[SKNode node];
    [self.mundo setName:@"mundo"];
    [self.mundo setZPosition:-100];
    
    self.controladorDaVida = [DQVidaControle sharedControleVida];
    
    //Leonardo - Alterado para classe específica
    self.backgroundAtual=[[DQBackground alloc]initBackgroundFase:self.faseAtual parte:self.parteFaseAtual naPosicao:CGPointZero infoParte:[self infoParteFase:self.parteFaseAtual]];
    
    //Adiciona a primeira parte da tela e o jogador no mundo
    [self.mundo addChild:self.backgroundAtual];
    
    //Adiciona o mundo na scena
    [self addChild:self.mundo];
    
    [self.backgroundAtual criarPlataformas:[[self infoParteFase:self.parteFaseAtual]objectForKey:@"Plataformas"]];
    
    self.controleDeFalas = [[DQFalasNoJogoControle alloc]init];
    
    [self criaJogador];
    [self configuraFisicaMundo];
    [self configuraHUD];
    [self configurarSomFundo];
    [self configurarControles];
}

-(void)configurarSomFundo{
    self.controleSom=[[DQControleSomScene alloc]initControleSomFundo:Fase nomeSom:[DQConfiguracaoFase somFundoFase:self.faseAtual] indiceCena:self.faseAtual];
    
    [self addChild:self.controleSom];
}

-(void)criaJogador{
    //Inicia o jogador pelo singleton
    self.jogador = [DQJogador sharedJogador];
    
    [self.jogador iniciarAnimacoes:[DQConfiguracaoFase animacoesJogadorFase:self.faseAtual]];
    
    [self.jogador setPosition:[DQConfiguracaoFase posicaoInicialJogadorFase:self.faseAtual]];
    
    if (!self.mundo) {
        NSLog(@"POR FAVOR INICIE O MUNDO ANTES DE CHAMAR A CRIAÇÃO DO JOGADOR");
    }else {
        [self.jogador removeFromParent];
        [self.mundo addChild:self.jogador];
    }
}

#pragma mark Controle de Backgrounds
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
            
            //Transforma o backgroundAtual em nulo, para criar com a imagem e corpo fisico corretos
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
    
    
    //TODO: Adicionar animais?
    NSMutableDictionary *parte = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *configAnimaisFase =[[NSMutableDictionary alloc]init];
    NSArray *animais = [NSArray arrayWithArray:[DQConfiguracaoFase animaisFase:self.faseAtual Parte:self.parteFaseAtual]];
    
    [configAnimaisFase setObject:[NSNumber numberWithInt:self.parteFaseAtual ]forKey:@"Parte"];
    [configAnimaisFase setObject:animais forKey:@"Animais"];
    [parte setObject:configAnimaisFase forKey:@"ConfigParte"];
    
    [self setUserData:parte];
}

-(void)removerNodeBackground:(DQBackground*)nodeRemover{
    if (nodeRemover) {
        [nodeRemover removeFromParent];
        nodeRemover = nil;
    }
}

-(void)criarParteFase{
    if (self.jogador.position.x > (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        
        //Verifica se ja tem um backgroundFuturo criado
        if (!self.backgroundFuturo) {
            
            //Verifica se tem parte a ser criada
            if (self.parteFaseAtual + 1 <= self.nPartesFase) {
                
                CGPoint posicaoAdd=CGPointMake(self.backgroundAtual.position.x +CGRectGetMaxX(self.frame), 0);
                
                self.backgroundFuturo = [[DQBackground alloc]initBackgroundFase:self.faseAtual parte:self.parteFaseAtual+1 naPosicao:posicaoAdd infoParte:[self infoParteFase:self.parteFaseAtual+1]];

                //Adicionado Classe específica
                [self.backgroundFuturo criaCoberturaParaBackground];
                [self.backgroundFuturo criarPlataformas:[[self infoParteFase:self.parteFaseAtual+1]objectForKey:@"Plataformas"]];
                //Adiciona o background no mundo
                [self.mundo addChild:self.backgroundFuturo];
                
                if (![self childNodeWithName:nomeEscalavel]) {
                    //Ele esta passando a parte fase atual pq:
                    //- No array a posicao da parte atual é igual a parteFaseAtual -1(pq o array começa com 0)
                    //- Logo a p parte é a parte fase atual sem tirar 1.
                    [self.backgroundFuturo criaEscalavel:[[[self.configFase objectForKey:@"Partes"]objectAtIndex:self.parteFaseAtual]objectForKey:@"Escalaveis"]];
                }
            }
        }
    }
    
    if (self.jogador.position.x < (self.backgroundAtual.position.x + CGRectGetMidX(self.frame))){
        if (!self.backgroundAnterior) {
            if (self.parteFaseAtual -1 > 0) {
                CGPoint posicaoAdd=CGPointMake(self.backgroundAtual.position.x -CGRectGetMaxX(self.frame), 0);
                self.backgroundAnterior =[[DQBackground alloc]initBackgroundFase:self.faseAtual parte:self.parteFaseAtual-1 naPosicao:posicaoAdd infoParte:[self infoParteFase:self.parteFaseAtual-1]];
                [self.backgroundAnterior criaCoberturaParaBackground];
                [self.backgroundAnterior criarPlataformas:[[self infoParteFase:self.parteFaseAtual-1]objectForKey:@"Plataformas"]];
                [self.backgroundAnterior criaEscalavel:[[[self.configFase objectForKey:@"Partes"]objectAtIndex:self.parteFaseAtual-2]objectForKey:@"Escalaveis"]];
                
                [self.mundo addChild:self.backgroundAnterior];
            }
        }
    }
}

#pragma mark Controle de Contato
//Metodo chamado ao final de alguma colisao
-(void)didEndContact:(SKPhysicsContact *)contact{
    
    // Organiza os corpos de acordo com o valor da categoria. Isto é feito para facilitar a comparação mais em baixo
    SKPhysicsBody  *secondBody; //*firstBody,
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        //firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        //firstBody = contact.bodyB;
        secondBody = contact.bodyA;
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
        if ((secondBody.categoryBitMask & ChaoCategoria) !=0 ||(secondBody.categoryBitMask & PlataformaAtivadaCategoria) !=0) {
            
            //se o jogador colidiu com o chao setamos que ele estao no chao
            
            [self.jogador setEstaNoChao:YES];
            
        }
        
        if ([secondBody.node.name isEqualToString:nomePlataforma]){
            if ((secondBody.categoryBitMask & PlataformaDesativadaCategoria)!=0) {
                [self.backgroundAtual controleAtivacaoPlataforma:secondBody.node posicaoJogador:firstBody.node.position.y velocidadeY:firstBody.velocity.dy];
            }

        }
        
        //se colidir com a escada
        if ([secondBody.node.name isEqualToString:nomeEscalavel]) {
            //seta que o jogador pode subir ou descer
            [self.jogador setPodeEscalar:YES];
        }
        
    }
}

#pragma mark CicloFrames
-(void)update:(NSTimeInterval)currentTime{
    //Faz verificação de pausa do jogo
    self.jogoPausado=self.paused;
    
    if (!self.jogoPausado) {
        [self.jogador atualizarStatusMissao:self.controleDeFalas];

        [self criarParteFase];
        
        //Converte a posicao do jogador para o sistema de coordenadas do no que tem a cobertura
        [self.backgroundAtual verificaCoberturaBackground:[self.mundo convertPoint:self.jogador.position toNode:self.backgroundAtual]];
        [self.controladorDaVida atualizarSituacaoJogador];
        [self.hudFase atualizarBarraStatus];
        
        
        CFTimeInterval ultimoUpdate = currentTime - self.intervaloUltimoUpdate;
        
        if (ultimoUpdate > 30) {
            self.intervaloUltimoUpdate = currentTime;
            
            if (self.faseAtual !=2) {
                if ([DQUteis sortearChanceSim:50.0]) {
                    [self.controleSom tocarSomLista];
                }
            }
        }
    }
}

- (void)didSimulatePhysics{
    if (!self.jogoPausado) {
        //Chama método para posicionar camera
        [self posicionaCamera];
        
        //Chama método para controlar em que parte da fase esta
        [self controlarTranscicaoPartesFase];
        
        //Desativa plataformas
        //Alterado para chamar metodo da classe back
        [self.backgroundAtual desativaPlataformas:self.jogador.position.y];
        
        //Faz algumas verificacoes para animar o jogador
        [self.jogador verificarAnimacaoCaindo];
        [self.jogador verificarAnimacaoDerrapagem];
    }
}

#pragma mark Outros
-(void)atualizaSomMusicaFundo{
    [self.controleSom.playerMusicaFundo setVolume:[DQControleUserDefalts volumeMusica]];
}

-(void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    
    //So chama o som qndo a Scene aparecer
    [self.controleSom tocarMusicaFundo];
    
    //A cada vez que iniciar a fase salva a fase que o jogador está
    [DQControleUserDefalts setFaseAtual:self.faseAtual];
    [DQControleUserDefalts setParteFaseAtual:self.parteFaseAtual];
    
    [self.controleSom playerMusicaFundo];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *toque=[touches anyObject];
    CGPoint posToqueNoMundo =[toque locationInNode:self.mundo];

    
    //Pega o node na posicao do toque
    SKNode *nodeTocadoNoMundo=[self.mundo nodeAtPoint:posToqueNoMundo];
    
    //Se a caixa de fala esta na tela
    if([self childNodeWithName:@"falasDoJogo"]){
        
        //Ve se pode pode ir para proxima fala
        if ([self.controleDeFalas proximaFala]) {
            if ([self.controleDeFalas.estadoFala isEqual:@"Alerta"]) {
                SKSpriteNode *falaAtual =[self.controleDeFalas mostrarAlertaComKey:nil Tamanho:self.size];
                [self addChild:falaAtual];
            }
            else{
                SKSpriteNode *falaAtual =[self.controleDeFalas mostrarFalaComNPC:nil KeyDaFala:nil Missao:nil Tamanho:self.size];
                [self addChild:falaAtual];
            }
        }
    }
    
    //Se a caixa de fala nao esta na tela
    else{
        //Verifica se o Menu esta aparecendo se estiver remove eles
        if ([self childNodeWithName:@"MENU"]) {
            [[self childNodeWithName:@"MENU"]removeFromParent];
            [self setPaused:NO];
            return;
        }
        
        //Se o node em que tocou for da classe DQNPC, faz o jogador interagir com o NPC
        if ([[[nodeTocadoNoMundo userData]objectForKey:@"Tipo"] isEqual:@"NPC"]) {
            
            //remove as setas direcionais
            //para o andar do jogador
            [self.jogador pararAndar];
            //faz ele interagir com o npc em questao
            [self.jogador interagirComNPC:nodeTocadoNoMundo.name ControleDeFalas:self.controleDeFalas];
            
        }
    }
}

-(void)configuraHUD{
    self.hudFase = [[DQHudController alloc]initHud];
    [self.hudFase setPosition:CGPointMake(0, CGRectGetMaxY(self.frame))];
    [self addChild:self.hudFase];
}

#pragma mark Controle Personagem
//Configura controles
-(void)configurarControles{
    self.direcional=[[DQBotaoDirecional alloc]initDirecional:@"testeBotao" seletorHorizontal:@selector(movimentaPersonagem:) seletorVertical:@selector(escaladaPersonagem:) selSoltarDir:@selector(pararPersonagem) dalegateSeletores:self];
    
    [self.direcional setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.9f,CGRectGetHeight(self.frame)*0.1f )];
    [self addChild:self.direcional];
    
    self.botaoPulo=[[DQBotao alloc]initBotao:@"testeBotao" comSel:@selector(puloPersonagem) eDelegate:self eTamanho:CGSizeMake(100, 100)];
    
    [self.botaoPulo setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.1f, CGRectGetHeight(self.frame)*0.1f)];
    [self addChild:self.botaoPulo];
}

-(void)escaladaPersonagem:(NSNumber*)valorMovimento{
    if ([self.jogador podeEscalar]) {
        //Recebeu um valor positivo significa que quer subir
        if ([valorMovimento floatValue]>0) {
            //Fazer jogador escalar - Subindo
            [self.jogador escalarParaDirecao:'C'];
            
        }else{
            //Fazer jogador escalar - Descendo
            [self.jogador escalarParaDirecao:'B'];
        }
    }
}

//MOVIMENTA O PERSONAGEM
-(void)movimentaPersonagem:(NSNumber*)forcaMovimento{
    char dirCaminhada;
    
    //Decide a direção q precisa mover
    if ([forcaMovimento floatValue] > 0) {
        dirCaminhada ='D';
    }else{
        dirCaminhada='E';
    }
    
    //Chama metodo passando qnto ele irá andar
    [self.jogador andarParaDirecao:dirCaminhada eVelocidade:[forcaMovimento floatValue]];
}

-(void)pararPersonagem{
    //faz parar de andar
    [self.jogador pararAndar];
    [self.jogador pausarEscalada];
}

-(void)puloPersonagem{
    [self.jogador pular];
}

//Método para controle da posição da camera
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
@end

//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"
#import "DQControleUserDefalts.h"

#define RAIOAPITAR 70
#define RAIOFALAR 20

@implementation DQFlorestaParte1

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.contadorAcao=0;
        
        [self configuracoesFase:1];
        //Esta chamando no metodo didMoveToView da classe mae
        //[self iniciarFase];
    }
    return self;
}


-(void)iniciarFase{
    [super iniciarFase];
    
    //Remove o HUD pois o mesmo nao aparece na 1 fase
    [self.hudFase removeFromParent];
    [self definirPontosRadiacao];
    [self.jogador setDistAndar:90];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    //Verifica em qual lado da tela o jogador está tocando
    UITouch *posicao = [touches anyObject];
    
    //Jeito porco irei arrumar
    CGPoint posicaoDoToque = [posicao locationInNode:self];
    SKSpriteNode *nodeTocado = (SKSpriteNode *)[self nodeAtPoint:posicaoDoToque];
    
    if ([[nodeTocado name] isEqualToString:@"RadiacaoAlfa"]) {
        [self addChild:[self.controleDeFalas mostrarAlertaComKey:@"RadiacaoAlfa" Tamanho:self.size]];
    }
    else if ([[nodeTocado name] isEqualToString:@"RadiacaoBeta"]) {
        [self addChild:[self.controleDeFalas mostrarAlertaComKey:@"RadiacaoBeta" Tamanho:self.size]];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![self childNodeWithName:@"falasDoJogo"]) {
        UITouch *toque = [touches anyObject];
        CGPoint posicaoToque=[toque locationInNode:self];
        
        //Anda corretamente apenas e for do lado direito da tela
        if(posicaoToque.x > CGRectGetMidX(self.frame)){
            //se moveu para a direita, anda para a direita - D
            if(posicaoToque.x > self.pontoDeToqueAndar.x){
                if (![self.jogador.andandoParaDirecao isEqualToString:@"D"]) {
                    [self.jogador andarParaDirecao:@"D"];
                    self.andouDireita=YES;
                    self.contadorAcao=0;
                }
            }
            
            //senão, move para a esquerda - E
            else{
                if (![self.jogador.andandoParaDirecao isEqualToString:@"E"] ) {
                    [self.jogador andarParaDirecao:@"E"];
                    self.andouEsquerda=YES;
                    self.contadorAcao=0;
                }
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
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
        CGPoint posToqueBackGround=[toque locationInNode:self.backgroundAtual];
        //Pega o node de escada na posicao do toque
        SKNode *nodeTocadoNoBackGround=[self.backgroundAtual nodeAtPoint:posToqueBackGround];
        
        //verifica para onde o jogador deve escalar
        if ([nodeTocadoNoBackGround.name isEqualToString:nomeEscalavel]) {
            //Verifica se o Y é maior ou menor
            
            if (posToqueBackGround.y > (self.jogador.position.y+20.0)) {
                //Fazer jogador escalar - Subindo
                [self.jogador escalarParaDirecao:@"C"];
                
            }else if (posToqueBackGround.y < (self.jogador.position.y-20.0)){
                //Fazer jogador escalar - Descendo
                [self.jogador escalarParaDirecao:@"B"];
            }
        }
        
        //Posicao do toque na tela
        CGPoint posicaoToque=[toque locationInNode:self];
        
        //Se estiver na direita
        
        if(posicaoToque.x > CGRectGetMidX(self.frame) && ![self.jogador actionForKey:@"escalar"]){
            
            //Remove a anterior
            [self.direcional removeFromParent];
            //ANDAR
            //marca o local em que tocou e desenha as setinhas
            self.pontoDeToqueAndar = [toque locationInView:self.view];
            
            [self.direcional removeFromParent];
            //mostra as setinhas
            self.direcional = [SKSpriteNode spriteNodeWithImageNamed:@"setinhas"];
            [self.direcional setPosition: CGPointMake(self.pontoDeToqueAndar.x, self.frame.size.height - self.pontoDeToqueAndar.y)];
            
            [self addChild:self.direcional];
        }
        
        //Se o node em que tocou for da classe DQNPC, faz o jogador interagir com o NPC
        if ([[[nodeTocadoNoMundo userData]objectForKey:@"Tipo"] isEqual:@"NPC"]) {
            
            //remove as setas direcionais
            [self.direcional removeFromParent];
            //para o andar do jogador
            [self.jogador pararAndar];
            //faz ele interagir com o npc em questao
            [self.jogador interagirComNPC:nodeTocadoNoMundo.name ControleDeFalas:self.controleDeFalas];
            
        }
        //Se estiver na esquerda
        else if(posicaoToque.x < CGRectGetMidX(self.frame)){
            //PULAR
            [self.jogador pular];
            self.pulou=YES;
            self.contadorAcao=0;
        }
        
    }
}

-(void)iniciarTutorial:(NSString*)acao{
    SKTextureAtlas *atlasTutorial=[SKTextureAtlas atlasNamed:[NSString stringWithFormat:@"tutorial%@",acao]];
    NSMutableArray *framesTutorial=[NSMutableArray array];
    
    for (int i=1;i <= [[atlasTutorial textureNames]count];i++) {
        SKTexture *temp = [atlasTutorial textureNamed:[NSString stringWithFormat:@"%d", i]];
        
        [framesTutorial addObject:temp];
    }
    
    SKSpriteNode *spriteTutorial=[[SKSpriteNode alloc]init];
    [spriteTutorial setSize:CGSizeMake(self.frame.size.width/2, self.frame.size.height)];
    [spriteTutorial setName:@"Tutorial"];
    
    if ([acao isEqualToString:@"Pular"]) {
        [spriteTutorial setAnchorPoint:CGPointMake(0, 0)];
        [spriteTutorial setPosition:CGPointMake(0, 0)];
    }else {
        [spriteTutorial setAnchorPoint:CGPointMake(0, 0)];
        [spriteTutorial setPosition:CGPointMake(self.frame.origin.x + self.frame.size.width/2, 0)];
    }
    
    [self animarTutorial:framesTutorial noSpriteNode:spriteTutorial];
}

-(void)animarTutorial:(NSArray*)arrayTexturas noSpriteNode:(SKSpriteNode*)spriteTutorial{
    [self addChild:spriteTutorial];
    
    //Desativa a interacao do user
    [self setUserInteractionEnabled:NO];
    
    [spriteTutorial runAction:[SKAction animateWithTextures:arrayTexturas timePerFrame:0.25f] completion:^{
        //Ativa a interacao do user
        
        [self setUserInteractionEnabled:YES];
        [spriteTutorial removeFromParent];
        self.contadorAcao=0;
    }];
}

-(void)verificaApresentacaoTurorial:(NSTimeInterval)currentTime{
    if (self.contadorAcao == 0) {
        self.contadorAcao = CACurrentMediaTime();
    }
    
    SKNode *node=[self childNodeWithName:@"Tutorial"];
    
    if (CACurrentMediaTime()-self.contadorAcao > 2 && !node) {
        if (!self.andouEsquerda) {
            [self iniciarTutorial:@"CorrerEsquerda"];
            
        }else if (!self.andouDireita){
            [self iniciarTutorial:@"CorrerDireita"];
            
        }else if (!self.pulou){
            [self iniciarTutorial:@"Pular"];
        }
        
        self.contadorAcao = CACurrentMediaTime();
    }
}

//Metodo chamado toda hora pela spriteKit, usado para criar as partes do corpo fisico da fase ==OK==
-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    [self procurarRadiacao];
    
    //Fazer o jogador sair de perto
    [self falarAlertaRadiacao];
    
    [self segundaCutScene];
    
    
    [self verificaApresentacaoTurorial:currentTime];
}

-(void)definirPontosRadiacao{
    
    //->Alpha
    NSValue *pontoAlpha =[NSValue valueWithCGPoint:CGPointMake(3290, 1000)];
    //-> Beta
    NSValue *pontoBeta =[NSValue valueWithCGPoint: CGPointMake(5798, 1150)];
    self.pontosRadiacao=[NSMutableArray arrayWithObjects:pontoAlpha,pontoBeta,nil];
    
    //Key pontos radiacao
    self.keyFalaPontoRadiacao=[NSArray arrayWithObjects:@"RadiacaoAlfa",@"RadiacaoBeta", nil];
    
    self.boolFalouRadiacao=[NSMutableArray array];
    
    for (int i=0; i<[self.pontosRadiacao count]; i++) {
        [self.boolFalouRadiacao insertObject:[NSNumber numberWithBool:NO] atIndex:i];
    }
}

-(void)apitarRadiacao{
    [self apitarRadiacao:@"ContadorGeiger-1.mp3"];
}
-(void)apitarRadiacao:(NSString*)nomeArquivoAudio{
    if (![self actionForKey:@"apitar"]) {
        SKAction *apitar=[SKAction playSoundFileNamed:nomeArquivoAudio waitForCompletion:YES];
        SKAction *parar=[SKAction removeFromParent];
        
        [self runAction:[SKAction sequence:@[apitar,parar]]withKey:@"apitar"];
    }
}
-(void)adicionaIconeRadiacao:(NSString*)nomeRadiacao naPosicao:(CGPoint)posicao{
    
    //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
    SKSpriteNode * iconeRadiacaoAlpha = [[ SKSpriteNode alloc]initWithImageNamed:@"BalaoAlerta"];
    iconeRadiacaoAlpha.size = CGSizeMake(50, 50);
    [iconeRadiacaoAlpha setAnchorPoint:CGPointMake(0, 0)];
    [iconeRadiacaoAlpha setPosition:posicao];
    [iconeRadiacaoAlpha setName:nomeRadiacao];
    
    [iconeRadiacaoAlpha setScale:0.9];
    
    SKAction *fadeOut=[SKAction fadeOutWithDuration:0.3];
    SKAction *fadeIn=[SKAction fadeInWithDuration:0.3];
    
    
    [iconeRadiacaoAlpha runAction:[SKAction repeatAction:[SKAction sequence:@[fadeOut,fadeIn]] count:5]];
    
    [self.mundo insertChild:iconeRadiacaoAlpha atIndex:0];
}
-(void)afastaJogadorRadiacao{
    [self.jogador andarParaDirecao:@"E"];
    [self.jogador runAction:[SKAction moveToX:self.jogador.position.x-15 duration:0.5] withKey:@"saindoDePerto"];
}
-(void)falarAlertaRadiacao{
    //cria os pontos de menssagem
    CGPoint pontoAlertaAlpha;
    CGPoint pontoAlertaBeta;
    
    //inicia-os com suas coordenadas
    //-> aletra alpha
    pontoAlertaAlpha = CGPointMake(3520, 1130);
    //-> alerta beta
    pontoAlertaBeta = CGPointMake(5990, 1255);
    
    //-> alerta alpha
    if(self.jogador.position.x > pontoAlertaAlpha.x  && self.jogador.position.x < pontoAlertaAlpha.x+100 && self.jogador.position.y >= pontoAlertaAlpha.y -20){
        
        if ( !self.falouAtencaoAlpha) {
            self.falouAtencaoAlpha = YES;
            [self afastaJogadorRadiacao];
            //Sorteia 1 número para que a fala seja aleatória
            int numeroAleatorio = arc4random() % 3; //de 0 a 3
            numeroAleatorio++;
            
            //Formata a String para que fique com o nome da fala
            NSString *keyDaFala = [NSString stringWithFormat:@"Aleatoria%i", numeroAleatorio];
            
            //inicia a fala
            [self addChild:[self.controleDeFalas mostrarAlertaComKey:keyDaFala Tamanho:self.size]];
            [self.direcional removeFromParent];
            
            [self.jogador pararAndar];
        }
        
        
    }
    
    
    //faz a fala de alerta ficar disponível novamente
    if(self.jogador.position.x <= pontoAlertaAlpha.x - 8){
        
        self.falouAtencaoAlpha = NO;
    }
    
    //-> alerta beta
    if(self.jogador.position.x > pontoAlertaBeta.x  && self.jogador.position.x < pontoAlertaBeta.x+100 && self.jogador.position.y >= pontoAlertaBeta.y-20){
        
        if ( !self.falouAtencaoBeta) {
            [self afastaJogadorRadiacao];
            self.falouAtencaoBeta = YES;
            //Sorteia 1 número para que a fala seja aleatória
            int numeroAleatorio = arc4random() % 3; //de 0 a 3
            numeroAleatorio++;
            
            //Formata a String para que fique com o nome da fala
            NSString *keyDaFala = [NSString stringWithFormat:@"Aleatoria%i", numeroAleatorio];
            
            //inicia a fala
            [self addChild:[self.controleDeFalas mostrarAlertaComKey:keyDaFala Tamanho:self.size]];
            
            [self.direcional removeFromParent];
            [self.jogador pararAndar];
        }
        
    }
    
    if(self.jogador.position.x <= pontoAlertaBeta.x - 8){
        
        self.falouAtencaoBeta = NO;
    }
}

-(void)segundaCutScene{
    CGPoint pontoSegundaCutscene;
    
    //-> segundaCutscene
    pontoSegundaCutscene = CGPointMake(7640, 330);
    //-> segundaCutscene
    //se o jogador chegar ao local da fala, comeca a fala
    
    if( self.jogador.position.x > pontoSegundaCutscene.x && self.jogador.position.y > pontoSegundaCutscene.y){
        
        [self.jogador pararAndar];
        [self mudarFase];
    }
}

//metodo para mudar da fase 1 para vila
-(void)mudarFase{
    DQVila *vila=[DQVila sceneWithSize:self.view.bounds.size];
    
    vila.scaleMode = SKSceneScaleModeAspectFill;
    
    //Cria um cutSceneTela
    DQCutsceneTela *proxCutScene=[[DQCutsceneTela alloc]initCutScene:2 Fase:vila SizeScene:self.view.bounds.size];
    
    [proxCutScene setScaleMode:SKSceneScaleModeAspectFill];
    
    [self.view presentScene:proxCutScene];
}



-(void)procurarRadiacao{
    //Para cada posicao configurada no array de radiacao eu vou verificar se o jogador esta em uma area especifica
    for (int i=0; i< [self.pontosRadiacao count]; i++) {
        CGPoint pontoAnalisar=[[self.pontosRadiacao objectAtIndex:i]CGPointValue];
        
        //Começar a apitar
        if ((self.jogador.position.x > pontoAnalisar.x - RAIOAPITAR  && self.jogador.position.x < pontoAnalisar.x + RAIOAPITAR) && self.jogador.position.y > pontoAnalisar.y - 10 ){
            
            [self apitarRadiacao];
            
            //Fala Radiacao
            if(self.jogador.position.x >= pontoAnalisar.x  && self.jogador.position.x <= pontoAnalisar.x+ RAIOFALAR && self.jogador.position.y >= pontoAnalisar.y-10 && ![[self.boolFalouRadiacao objectAtIndex:i]boolValue]){
                
                NSString *keyFalaRadiacao=[self.keyFalaPontoRadiacao objectAtIndex:i];
                [self addChild:[self.controleDeFalas mostrarAlertaComKey:keyFalaRadiacao Tamanho:self.size]];
                
                [self.boolFalouRadiacao removeObjectAtIndex:i];
                
                NSNumber *falouRadiacao=[NSNumber numberWithBool:YES];
                [self.boolFalouRadiacao insertObject:falouRadiacao atIndex:i];
                [self.direcional removeFromParent];
                [self.jogador pararAndar];
                
                //Adiciona o Icone
                [self adicionaIconeRadiacao:[self.keyFalaPontoRadiacao objectAtIndex:i] naPosicao:CGPointMake(pontoAnalisar.x, pontoAnalisar.y + 80.0)];
            }
        }
    }
}
@end

//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"


#define RAIOAPITAR 70
#define RAIOFALAR 20

@implementation DQFlorestaParte1

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self configuracoesFase:1];

        
        [self iniciarFase];

    }
    return self;
}


-(void)iniciarFase{
    [super iniciarFase];
    
    //Remove o HUD pois o mesmo nao aparece na 1 fase
    [self.hudFase removeFromParent];
    [self definirPontosRadiacao];
    
    self.mostrouTutorial = YES;
    self.executandoTutorial = NO;
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    //Se ainda não mostrou o tutorial, assim que a pessoa clica na tela, ele inicia:
    if(!self.mostrouTutorial){
        if(!self.executandoTutorial){
            [self iniciarTutorial];
        }
    }
    else{
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
    }];
}

//TODO:- Arrumar o timer
-(void)verificaApresentacaoTurorial:(NSTimeInterval)currentTime{
    CFTimeInterval ultimoUpdate = currentTime - self.contadorAcao;
    
    //Mais de 2 segundos sem fazer acao nenhuma
    if (ultimoUpdate > 2) {
        self.contadorAcao = currentTime;
        
        if (!self.andouEsquerda) {
            [self iniciarTutorial:@"CorrerEsquerda"];
            self.andouEsquerda=YES;
            
        }else if (!self.andouDireita){
            [self iniciarTutorial:@"CorrerDireita"];
            self.andouDireita=YES;
            
        }else if (!self.pulou){
            [self iniciarTutorial:@"Pular"];
            self.pulou=YES;
        }
    }
}

-(void)iniciarTutorial
{
    self.executandoTutorial = YES;
    [self.jogador pararAndar];
    
    //Cria o SpriteNode de tutorial
    //Pular
    SKSpriteNode *tutorialPular = [[SKSpriteNode alloc]init];
    [tutorialPular setSize:CGSizeMake(self.frame.size.width/2, self.frame.size.height)];
    [tutorialPular setAnchorPoint:CGPointMake(0, 0)];
    [tutorialPular setPosition:CGPointMake(0, 0)];
    //Correr
    SKSpriteNode *tutorialCorrer = [[SKSpriteNode alloc]init];
    [tutorialCorrer setSize:CGSizeMake(self.frame.size.width/2, self.frame.size.height)];
    [tutorialCorrer setAnchorPoint:CGPointMake(0, 0)];
    [tutorialCorrer setPosition:CGPointMake(self.frame.origin.x + self.frame.size.width/2, 0)];
    
    //Arrumando coisas para ação do tutorial de pular
    //Pega imagens
    SKTextureAtlas *atlasPular = [SKTextureAtlas atlasNamed:@"tutorialPular"];
    SKTexture *AP1 = [atlasPular textureNamed:@"tutorialPular001.png"];
    SKTexture *AP2 = [atlasPular textureNamed:@"tutorialPular002.png"];
    SKTexture *AP3 = [atlasPular textureNamed:@"tutorialPular003.png"];
    SKTexture *AP4 = [atlasPular textureNamed:@"tutorialPular004.png"];
    //Adiciona num array
    NSArray *arrayTutorialPular = @[AP1, AP2, AP3, AP4];
    //Cria a ação
    SKAction *acaoTutorialPular = [SKAction animateWithTextures:arrayTutorialPular timePerFrame:0.3f];
    
    //Arrumando coisas para ação do tutorial de correr - Direita
    //Pega imagens
    SKTextureAtlas *atlasCorrerD = [SKTextureAtlas atlasNamed:@"tutorialCorrerDireita"];
    SKTexture *ACD1 = [atlasCorrerD textureNamed:@"tutorialCorrerD001.png"];
    SKTexture *ACD2 = [atlasCorrerD textureNamed:@"tutorialCorrerD002.png"];
    SKTexture *ACD3 = [atlasCorrerD textureNamed:@"tutorialCorrerD003.png"];
    SKTexture *ACD4 = [atlasCorrerD textureNamed:@"tutorialCorrerD004.png"];
    SKTexture *ACD5 = [atlasCorrerD textureNamed:@"tutorialCorrerD005.png"];
    SKTexture *ACD6 = [atlasCorrerD textureNamed:@"tutorialCorrerD006.png"];
    SKTexture *ACD7 = [atlasCorrerD textureNamed:@"tutorialCorrerD007.png"];
    SKTexture *ACD8 = [atlasCorrerD textureNamed:@"tutorialCorrerD008.png"];
    //Adiciona num array
    NSArray *arrayTutorialCorrerD = @[ACD1, ACD2, ACD3, ACD4, ACD5, ACD6, ACD7, ACD8];
    
    //Cria a ação
    SKAction *acaoTutorialCorrerD = [SKAction animateWithTextures:arrayTutorialCorrerD timePerFrame:0.25f];
    
    //Arrumando coisas para ação do tutorial de correr - Esquerda
    //Pega imagens
    SKTextureAtlas *atlasCorrerE = [SKTextureAtlas atlasNamed:@"tutorialCorrerEsquerda"];
    SKTexture *ACE1 = [atlasCorrerE textureNamed:@"tutorialCorrerE001.png"];
    SKTexture *ACE2 = [atlasCorrerE textureNamed:@"tutorialCorrerE002.png"];
    SKTexture *ACE3 = [atlasCorrerE textureNamed:@"tutorialCorrerE003.png"];
    SKTexture *ACE4 = [atlasCorrerE textureNamed:@"tutorialCorrerE004.png"];
    SKTexture *ACE5 = [atlasCorrerE textureNamed:@"tutorialCorrerE005.png"];
    SKTexture *ACE6 = [atlasCorrerE textureNamed:@"tutorialCorrerE006.png"];
    SKTexture *ACE7 = [atlasCorrerE textureNamed:@"tutorialCorrerE007.png"];
    
    //Adiciona num array
    NSArray *arrayTutorialCorrerE = @[ACE1, ACE2, ACE3, ACE4, ACE5, ACE6, ACE7];
    //Cria a ação
    SKAction *acaoTutorialCorrerE = [SKAction animateWithTextures:arrayTutorialCorrerE timePerFrame:0.25f];
    
    
    //Fazendo o tutorial de pular
    [self addChild:tutorialPular];
    [tutorialPular runAction:acaoTutorialPular completion:^{
        [self.jogador pular];
        [tutorialPular removeFromParent];
        
        //espera um pouco
        [self runAction:[SKAction waitForDuration:0.5f] completion:^{
            
            //Fazendo o tutorial de correr para a Direita
            [self addChild:tutorialCorrer];
            [tutorialCorrer runAction:acaoTutorialCorrerE completion:^{
                [self.jogador andarParaDirecao:@"E"];
                [tutorialCorrer removeFromParent];
                
                //espera um pouco
                [self runAction:[SKAction waitForDuration:1] completion:^{
                    [self.jogador pararAndar];
                    
                    //Fazendo o tutorial de correr para a Esquerda
                    [self addChild:tutorialCorrer];
                    [tutorialCorrer runAction:acaoTutorialCorrerD completion:^{
                        [self.jogador andarParaDirecao:@"D"];
                        [tutorialCorrer removeFromParent];
                        
                        //espera um pouco
                        [self runAction:[SKAction waitForDuration:1] completion:^{
                            [self.jogador pararAndar];
                        }];
                    }];
                }];
            }];
        }];
    }];
    
    self.mostrouTutorial = YES;
    self.executandoTutorial = NO;
    
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
    if (![self actionForKey:@"apitar"]) {
        SKAction *apitar=[SKAction playSoundFileNamed:@"beep.mp3" waitForCompletion:YES];
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
//funcao para mudar da fase 1 para 2
-(void)mudarFase{
    DQVila *fase2=[DQVila sceneWithSize:self.view.bounds.size];
    
    fase2.scaleMode = SKSceneScaleModeAspectFill;
    
    [self.view presentScene:fase2];
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

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
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:1 Fase:1];
        
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        
        [self configuracoesFase:1];
        
        [self iniciarFase];
    }
    return self;
}

-(void)iniciarFase{
    [super iniciarFase];
    
    [self definirPontosRadiacao];
    
    self.cutsceneEstaRodando = NO;
    self.estaFalando = NO;
    
    self.mostrouTutorial = NO;
    self.executandoTutorial = NO;
    
}
//Ultimo Método que é chamado antes de aparecer a tela, usado para arrumar a camera //===OK===
- (void)didSimulatePhysics
{
    if (!self.cutsceneEstaRodando) {
        [super didSimulatePhysics];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Se não está falando e nem em cutscene...
    if (!self.cutsceneEstaRodando && !self.estaFalando) {
        
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
                [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoAlfa"];
            
                self.cutsceneEstaRodando = YES;
                self.estaFalando = YES;
            }
            else if ([[nodeTocado name] isEqualToString:@"RadiacaoBeta"]) {
                [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoBeta"];
            
                self.cutsceneEstaRodando = YES;
                self.estaFalando = YES;
            }else{
                [super touchesBegan:touches withEvent:event];
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
    SKAction *acaoTutorialPular = [SKAction animateWithTextures:arrayTutorialPular timePerFrame:0.4f];
    
    //Arrumando coisas para ação do tutorial de correr
    //Pega imagens
    SKTextureAtlas *atlasCorrer = [SKTextureAtlas atlasNamed:@"tutorialCorrer"];
    SKTexture *AC1 = [atlasCorrer textureNamed:@"tutorialCorrer001.png"];
    SKTexture *AC2 = [atlasCorrer textureNamed:@"tutorialCorrer002.png"];
    SKTexture *AC3 = [atlasCorrer textureNamed:@"tutorialCorrer003.png"];
    SKTexture *AC4 = [atlasCorrer textureNamed:@"tutorialCorrer004.png"];
    SKTexture *AC5 = [atlasCorrer textureNamed:@"tutorialCorrer005.png"];
    SKTexture *AC6 = [atlasCorrer textureNamed:@"tutorialCorrer006.png"];
    SKTexture *AC7 = [atlasCorrer textureNamed:@"tutorialCorrer007.png"];
    SKTexture *AC8 = [atlasCorrer textureNamed:@"tutorialCorrer008.png"];
    SKTexture *AC9 = [atlasCorrer textureNamed:@"tutorialCorrer009.png"];
    SKTexture *AC10 = [atlasCorrer textureNamed:@"tutorialCorrer010.png"];
    SKTexture *AC11 = [atlasCorrer textureNamed:@"tutorialCorrer011.png"];
    SKTexture *AC12 = [atlasCorrer textureNamed:@"tutorialCorrer012.png"];
    SKTexture *AC13 = [atlasCorrer textureNamed:@"tutorialCorrer013.png"];
    //Adiciona num array
    NSArray *arrayTutorialCorrer = @[AC1, AC2, AC3, AC4, AC5, AC6, AC7, AC8, AC9, AC10, AC11, AC12, AC13];
    //Cria a ação
    SKAction *acaoTutorialCorrer = [SKAction animateWithTextures:arrayTutorialCorrer timePerFrame:0.35f];
    

    //Fazendo o tutorial de pular
    [self addChild:tutorialPular];
    [tutorialPular runAction:acaoTutorialPular completion:^{
        [self.jogador pular];
        [tutorialPular removeFromParent];
        
        //Fazendo tutorial de correr
        [self addChild:tutorialCorrer];
        [tutorialCorrer runAction:acaoTutorialCorrer completion:^{
            [tutorialCorrer removeFromParent];
        }];
    }];
    
    self.mostrouTutorial = YES;
}

//Metodo chamado toda hora pela spriteKit, usado para criar as partes do corpo fisico da fase ==OK==
-(void)update:(NSTimeInterval)currentTime{
    if (!self.cutsceneEstaRodando) {
        [super update:currentTime];
        [self procurarRadiacao];
        
        //Fazer o jogador sair de perto
        [self falarAlertaRadiacao];
        
        [self segundaCutScene];
    }
}

-(void)definirPontosRadiacao{
    
    //->Alpha
    NSValue *pontoAlpha =[NSValue valueWithCGPoint:CGPointMake(3290, 1000)];
    //-> Beta
    NSValue *pontoBeta =[NSValue valueWithCGPoint: CGPointMake(5798, 1170)];
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
    SKSpriteNode * iconeRadiacaoAlpha = [[ SKSpriteNode alloc]initWithImageNamed:@"icone_cientista"];
    iconeRadiacaoAlpha.size = CGSizeMake(50, 50);
    [iconeRadiacaoAlpha setAnchorPoint:CGPointMake(0, 0)];
    [iconeRadiacaoAlpha setPosition:posicao];
    [iconeRadiacaoAlpha setName:nomeRadiacao];
    
    [self.mundo insertChild:iconeRadiacaoAlpha atIndex:0];
}
-(void)afastaJogadorRadiacao{
    [self.jogador andarParaDirecao:@"E"];
    [self.jogador runAction:[SKAction moveToX:self.jogador.position.x-10 duration:0.5] withKey:@"saindoDePerto"];
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
    if((self.jogador.position.x > pontoAlertaAlpha.x && self.jogador.position.y > pontoAlertaAlpha.y) && (self.jogador.position.x < pontoAlertaAlpha.x+100 && self.jogador.position.y < pontoAlertaAlpha.y+100) && !self.falouAtencaoAlpha){
        
        [self afastaJogadorRadiacao];
        //Sorteia 1 número para que a fala seja aleatória
        int numeroAleatorio = arc4random() % 3; //de 0 a 3
        numeroAleatorio++;
        
        //Formata a String para que fique com o nome da fala
        NSString *keyDaFala = [NSString stringWithFormat:@"Aleatoria%i", numeroAleatorio];
        
        //inicia a fala
        [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:keyDaFala];
        
        
        self.estaFalando = YES;
        self.falouAtencaoAlpha = YES;
        
        [self.jogador pararAndar];
    }
    
    
    //faz a fala de alerta ficar disponível novamente
    if(self.jogador.position.x <= pontoAlertaAlpha.x - 8){
        self.falouAtencaoAlpha = NO;
    }
    
    //-> alerta beta
    if((self.jogador.position.x > pontoAlertaBeta.x && self.jogador.position.y > pontoAlertaBeta.y) && (self.jogador.position.x < pontoAlertaBeta.x+100 && self.jogador.position.y < pontoAlertaBeta.y+100) && !self.falouAtencaoBeta){
        
        [self afastaJogadorRadiacao];
        //Sorteia 1 número para que a fala seja aleatória
        int numeroAleatorio = arc4random() % 3; //de 0 a 3
        numeroAleatorio++;
        
        //Formata a String para que fique com o nome da fala
        NSString *keyDaFala = [NSString stringWithFormat:@"Aleatoria%i", numeroAleatorio];
        
        //inicia a fala
        [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:keyDaFala];
        
        
        self.estaFalando = YES;
        self.falouAtencaoBeta = YES;
        
        [self.jogador pararAndar];
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
        
        [self.controleCutscenes mudarParte];
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        [self.jogador pararAndar];
        [self.controleCutscenes iniciarCutscene:self Seletor:nil];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if((self.cutsceneEstaRodando) && (!self.estaFalando)){
        [self.controleCutscenes trocarCena];
    }else{
        
    }
}

-(void)procurarRadiacao{
    //Para cada posicao configurada no array de radiacao eu vou verificar se o jogador esta em uma area especifica
    for (int i=0; i< [self.pontosRadiacao count]; i++) {
        CGPoint pontoAnalisar=[[self.pontosRadiacao objectAtIndex:i]CGPointValue];
        
        //Começar a apitar
        if ((self.jogador.position.x > pontoAnalisar.x - RAIOAPITAR  && self.jogador.position.x < pontoAnalisar.x + RAIOAPITAR) && self.jogador.position.y > pontoAnalisar.y - 10 ){
            
            [self apitarRadiacao];
            
            //Fala Radiacao
            if((self.jogador.position.x >= pontoAnalisar.x && self.jogador.position.y >= pontoAnalisar.y) && (self.jogador.position.x <= pontoAnalisar.x+ RAIOFALAR && self.jogador.position.y <= pontoAnalisar.y+ RAIOFALAR) && ![[self.boolFalouRadiacao objectAtIndex:i]boolValue]){
                
                NSString *keyFalaRadiacao=[self.keyFalaPontoRadiacao objectAtIndex:i];
                [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:keyFalaRadiacao];
                
               
                self.estaFalando = YES;
                
                [self.boolFalouRadiacao removeObjectAtIndex:i];
                
                NSNumber *falouRadiacao=[NSNumber numberWithBool:YES];
                [self.boolFalouRadiacao insertObject:falouRadiacao atIndex:i];
                
                [self.jogador pararAndar];
                
                //Adiciona o Icone
                [self adicionaIconeRadiacao:[self.keyFalaPontoRadiacao objectAtIndex:i] naPosicao:pontoAnalisar];
                
            }
        }
    }
}
@end

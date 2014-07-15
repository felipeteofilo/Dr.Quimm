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
    
    self.cutsceneEstaRodando=NO;
    self.estaFalando=NO;
    
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

//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"

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

-(void)iniciarFase{
    [super iniciarFase];
    
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
    [super update:currentTime];
    
    [self executaFalasDoJogo];
}


-(void)executaFalasDoJogo
{
    //cria os pontos de menssagem
    CGPoint pontoAlpha;
    CGPoint pontoBeta;
    CGPoint pontoSegundaCutscene;
    CGPoint pontoAlertaAlpha;
    CGPoint pontoAlertaBeta;
    
    //inicia-os com suas coordenadas
    //-> alpha
    pontoAlpha = CGPointMake(3290, 1000);
    //-> beta
    pontoBeta = CGPointMake(5798, 1170);
    //-> segundaCutscene
    pontoSegundaCutscene = CGPointMake(7640, 330);
    //-> aletra alpha
    pontoAlertaAlpha = CGPointMake(3520, 1130);
    //-> alerta beta
    pontoAlertaBeta = CGPointMake(5990, 1255);
    
    //verifica contato
    //-> alpha
    //Se o jogador estiver perto da radiacao comeca a apitar
    if ((self.jogador.position.x > pontoAlpha.x - 50  && self.jogador.position.x < pontoAlpha.x + 940) && self.jogador.position.y > pontoAlpha.y - 10 ) {
        
        //Se ja houver algum apito aguarda para tocar outro
        if (![self hasActions]) {
            [self runAction:[SKAction playSoundFileNamed:@"beep.mp3" waitForCompletion:YES]];
        }
        
        //se o jogador chegar ao local da fala, comeca a fala
        if((self.jogador.position.x >= pontoAlpha.x && self.jogador.position.y >= pontoAlpha.y) && (self.jogador.position.x <= pontoAlpha.x+20 && self.jogador.position.y <= pontoAlpha.y+20) && !self.falouRadiacaoAlpha){
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoAlfa"];
            
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
            
            [self.jogador pararAndar];
            self.falouRadiacaoAlpha = YES;
            
            //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
            SKSpriteNode * iconeRadiacaoAlpha = [[ SKSpriteNode alloc]initWithImageNamed:@"icone_cientista"];
            iconeRadiacaoAlpha.size = CGSizeMake(50, 50);
            [iconeRadiacaoAlpha setAnchorPoint:CGPointMake(0, 0)];
            [iconeRadiacaoAlpha setPosition:pontoAlpha];
            [iconeRadiacaoAlpha setName:@"RadiacaoAlfa"];
            [self.jogador setZPosition:1];
            [self.mundo insertChild:iconeRadiacaoAlpha atIndex:0];
        }
    }

    //-> beta
    if (self.jogador.position.x > pontoBeta.x - 50 && self.jogador.position.x < pontoBeta.x + 940 && self.jogador.position.y > pontoBeta.y-10) {
       
        //Se ja houver algum apito aguarda para tocar outro
        if (![self hasActions]) {
            [self runAction:[SKAction playSoundFileNamed:@"beep.mp3" waitForCompletion:YES]];
        }
        
        //se o jogador chegar ao local da fala, comeca a fala
        if( (self.jogador.position.x > pontoBeta.x && self.jogador.position.y > pontoBeta.y) && (self.jogador.position.x < pontoBeta.x + 20 && self.jogador.position.y < pontoBeta.y + 20) && !self.falouRadiacaoBeta){
            [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:@"RadiacaoBeta"];
            
            self.cutsceneEstaRodando = YES;
            self.estaFalando = YES;
            
            [self.jogador pararAndar];
            self.falouRadiacaoBeta = YES;
            
            //Depois que o jogador inicia a fala cria-se um icone para quando ele quiser ler a fala novamente
            SKSpriteNode * iconeRadiacaoBeta = [[ SKSpriteNode alloc]initWithImageNamed:@"icone_cientista"];
            iconeRadiacaoBeta.size = CGSizeMake(50, 50);
            [iconeRadiacaoBeta setAnchorPoint:CGPointMake(0, 0)];
            [iconeRadiacaoBeta setPosition:pontoBeta];
            
            [iconeRadiacaoBeta setName:@"RadiacaoBeta"];
            [self.jogador setZPosition:1];
            [self.mundo insertChild:iconeRadiacaoBeta atIndex:0];
        }
    }
    
    //-> segundaCutscene
    //se o jogador chegar ao local da fala, comeca a fala
    if( self.jogador.position.x > pontoSegundaCutscene.x && self.jogador.position.y > pontoSegundaCutscene.y){
        self.controleCutscenes = [[DQCutsceneControle alloc]initComParte:2 Fase:1];
        
        self.cutsceneEstaRodando = YES;
        self.estaFalando = NO;
        [self.jogador pararAndar];
        
        [self.controleCutscenes iniciarCutscene:self Seletor:nil];
        
    }
    
    //-> alerta alpha
    if((self.jogador.position.x > pontoAlertaAlpha.x && self.jogador.position.y > pontoAlertaAlpha.y) && (self.jogador.position.x < pontoAlertaAlpha.x+100 && self.jogador.position.y < pontoAlertaAlpha.y+100) && !self.falouAtencaoAlpha){
        [self.jogador andarParaDirecao:@"E"];
        [self.jogador runAction:[SKAction moveToX:self.jogador.position.x-10 duration:0.5] withKey:@"saindoDePerto"];
        
        //Sorteia 1 número para que a fala seja aleatória
        int numeroAleatorio = arc4random() % 3; //de 0 a 3
        numeroAleatorio++;
        
        //Formata a String para que fique com o nome da fala
        NSString *keyDaFala = [NSString stringWithFormat:@"Aleatoria%i", numeroAleatorio];
        
        //inicia a fala
        [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:keyDaFala];
        
        self.cutsceneEstaRodando = YES;
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
        [self.jogador andarParaDirecao:@"E"];
        [self.jogador runAction:[SKAction moveToX:self.jogador.position.x-10 duration:0.5] withKey:@"saindoDePerto"];
        
        //Sorteia 1 número para que a fala seja aleatória
        int numeroAleatorio = arc4random() % 3; //de 0 a 3
        numeroAleatorio++;
        
        //Formata a String para que fique com o nome da fala
        NSString *keyDaFala = [NSString stringWithFormat:@"Aleatoria%i", numeroAleatorio];
        
        //inicia a fala
        [self.controleCutscenes mostrarFalaNoJogo:self KeyDaFala:keyDaFala];
        
        self.cutsceneEstaRodando = YES;
        self.estaFalando = YES;
        self.falouAtencaoBeta = YES;
        
        [self.jogador pararAndar];
    }

    if(self.jogador.position.x <= pontoAlertaBeta.x - 8){
        self.falouAtencaoBeta = NO;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if((self.cutsceneEstaRodando) && (!self.estaFalando)){
        [self.controleCutscenes trocarCena];
    }else{
        
    }
}
@end

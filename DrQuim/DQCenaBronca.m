//
//  DQCenaBronca.m
//  DrQuim
//
//  Created by LEONARDO DE SOUSA MENDES on 21/08/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCenaBronca.h"

@implementation DQCenaBronca

-(id)initCena:(CGSize)size cena:(SKScene*)cenaAnterior {
    if (self=[super initWithSize:size]) {
        //Adiciona o fundo da cena
        SKSpriteNode *fundoCena=[SKSpriteNode spriteNodeWithImageNamed:@"Fase2_Parte4"];
        [fundoCena setAnchorPoint:CGPointMake(0, 0)];
        [fundoCena setPosition:CGPointMake(0, 0)];
        [fundoCena setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:fundoCena.frame]];
        [fundoCena.physicsBody setDynamic:NO];
        
        [self addChild:fundoCena];
        
        self.cenaAnterior=cenaAnterior;
        [self configuraPersonagens];
        [self configuraChao];
        self.controleDeFalas = [[DQFalasNoJogoControle alloc]init];
        
    }
    return self;
}
-(void)configuraPersonagens{
    //Adiciona os npcs envolvidos
    self.maeDeTodos=[[DQNpc alloc]initComNome:@"Maedetodos" naPosicao:CGPointMake(495, 155)];
    [self.maeDeTodos setXScale:-1.0f];
    self.cacador=[[DQNpc alloc]initComNome:@"Cacador" naPosicao:CGPointMake(500, 155)];
    self.jogador=[DQJogador sharedJogador];
    [self.jogador setPosition:CGPointMake(50, 200)];
    [self.jogador iniciarAnimacoes:[DQConfiguracaoFase animacoesJogadorFase:2]];
    
    [self.jogador removeFromParent];
}
-(void)didMoveToView:(SKView *)view{
    [self addChild:self.maeDeTodos];
    [self addChild:self.cacador];
    [self addChild:self.jogador];
}
-(void)configuraChao{
    [self setPhysicsBody:[DQControleCorpoFisico criaCorpoFisicoChaoParte:3 daFase:2]];
    
    //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
    self.physicsWorld.gravity=CGVectorMake(0, -3);
    
    //Seta que a classe que ira delegar o contato sera essa mesma
    [self.physicsWorld setContactDelegate:self];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    //Se nao ha falas na tela
    if(![self childNodeWithName:@"falasDoJogo"]){
        //faz parar de andar
        [self.jogador pararAndar];
        
        //tirar imagem da setinha da tela
        [self.direcional removeFromParent];
        
        //Ao parar o toque, pausa sua escalada se ainda estiver escalando
        if ([self.jogador actionForKey:@"escalar"]) {
            [self.jogador pausarEscalada];
        }
    }
}

-(void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    [self dispararFalas];
}

-(void)dispararFalas{
    if (self.jogador.position .x > (self.maeDeTodos.position.x-200) && !self.comecouAlerta) {
        [self addChild:[self.controleDeFalas mostrarAlertaComKey:@"Bronca Mae Todos" Tamanho:self.size]];
        //[self.jogador interagirComNPC:@"Maedetodos"];
        
        //Atualiza bool
        self.comecouAlerta=YES;
        [self.jogador pararAndar];
        [self.direcional removeFromParent];
    }
    
}

-(void)voltaVila{
    DQVila *vila=[[DQVila alloc]initFase:2 Size:self.view.bounds.size];
    vila.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:vila];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *toque=[touches anyObject];
    
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
    }else {
        //Verifica bool
        if (self.comecouAlerta) {
            [self.jogador removeFromParent];
            //self.jogador.controleMissoes.parteAtual++;
            [self voltaVila];
            
        }else{
            //Verifica se o Menu esta aparecendo se estiver remove eles
            if ([self childNodeWithName:@"MENU"]) {
                [[self childNodeWithName:@"MENU"]removeFromParent];
                [self setPaused:NO];
                return;
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
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if (![self childNodeWithName:@"falasDoJogo"]) {
        UITouch *toque = [touches anyObject];
        CGPoint posicaoToque=[toque locationInNode:self];
        
        //Anda corretamente apenas e for do lado direito da tela
        if(posicaoToque.x > CGRectGetMidX(self.frame)){
            //se moveu para a direita, anda para a direita - D
            if(posicaoToque.x > self.pontoDeToqueAndar.x){
                if (![self.jogador.andandoParaDirecao isEqualToString:@"D"]) {
               //     [self.jogador andarParaDirecao:<#(char)#> eVelocidade:<#(float)#>
                }
            }
            
            //senão, move para a esquerda - E
            else{
                if (![self.jogador.andandoParaDirecao isEqualToString:@"E"] ) {
                    //[self.jogador andarParaDirecao:@"E"];
                }
            }
        }
    }
}
@end

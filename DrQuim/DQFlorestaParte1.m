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
        DQCutsceneControle *teste = [[DQCutsceneControle alloc]initComParte:1];
        
        
        //Inicia o jogador pelo singleton
        self.jogador = [DQJogador sharedJogador];
        
        //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
        self.physicsWorld.gravity=CGVectorMake(0, -3);
        
        
        // LEONARDO 16/06/2014 - Movido criação do corpo Físico para método especifico =]
        
        SKNode *chao=[[SKNode alloc]init];
        
        chao.physicsBody=[self criaCorpoFísicoParte:3];
        
        chao.physicsBody.categoryBitMask=ChaoCategoria;
        chao.physicsBody.usesPreciseCollisionDetection=YES;
        chao.physicsBody.dynamic=NO;
        chao.position=CGPointMake(0, 0);
        
        chao.hidden =YES;
  
        SKSpriteNode *background =[SKSpriteNode spriteNodeWithImageNamed:@"parte1"];
        
        [background setAnchorPoint:CGPointMake(0, 0)];
        [background setPosition:CGPointMake(0, 0)];
        
        //seta as categorias de colisao do jogador
        self.jogador.physicsBody.categoryBitMask=JogadorCategoria;
        self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
        
        
        //Seta que a classe que ira delegar o contato sera essa mesma
        [self.physicsWorld setContactDelegate:self];
        
        //adiciona corpo físico personalizado
        [self addChild:chao];

        //Adiciona o backgroud e o node do jogador
        [self addChild:background];
        [self addChild:self.jogador];
        
    }
    return self;
}

-(SKPhysicsBody*)criaCorpoFísicoParte: (int)parte {

    NSMutableArray *arrayPosicoes=[NSMutableArray array];
    
    
    //De acordo com a parte do background ele cria um array de CGPoints com as coordenadas
    switch (parte){
            case 1:
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 224)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(373, 187)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(376, 141)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(932, 121)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 127)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            
            break;
            
        case 2:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 127)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(606, 162)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(614, 300)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 302)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            
        case 3:
            
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(0, 302)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(35,304)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(41, 191)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(602, 201)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(613, 66)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(679, 53)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 53)]];
            [arrayPosicoes addObject:[NSValue valueWithCGPoint:CGPointMake(1023, 0)]];
            break;
    }
    
    //Cria o path de acordo com os pontos configurados
    CGMutablePathRef path = CGPathCreateMutable();
    
    //Pega as coordenadas do ponto inicial do path para facilitar leitura
    CGPoint primeiroPonto=[[arrayPosicoes firstObject]CGPointValue];
    
    //Posiciona o path no ponto inicial do array
    CGPathMoveToPoint(path, NULL,primeiroPonto.x, primeiroPonto.y);
    
    for (NSValue *pontoMapa in arrayPosicoes){
        
        //Para cada ponto do array eu crio uma linha que será usada no corpo físico
        CGPathAddLineToPoint(path, NULL,[pontoMapa CGPointValue].x,[pontoMapa CGPointValue].y);
    }
    
    //Fecho o path
    CGPathCloseSubpath(path);
    
    //Crio o corpo físico e devolvo ele p quem chamou
    SKPhysicsBody *corpoFisicoRetorno=[SKPhysicsBody bodyWithEdgeLoopFromPath:path];
    
    
    return corpoFisicoRetorno;
}

//metodo que e chamado assim que e criada a cena
-(void)didMoveToView:(SKView *)view{
    
    // cria o gesto do pulo e adiciona na cena
    self.gestoPulo = [[DQGestoPulo alloc]init];
    
    [view addGestureRecognizer:self.gestoPulo];
}


//metodo que e chamado assim que um toque é iniciado na cena
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //verifica em qual parte da tela o toque foi feito e faz o personagem andar de acordo com essa informacao
    UITouch *posicao = [touches anyObject];
    
    if ([posicao locationInView:self.view].x > self.view.frame.size.height/2 ) {
        
        [self.jogador andarParaDirecao:@"D"];
    }else{
        [self.jogador andarParaDirecao:@"E"];
    }
    
    
}

//metodo chamado assim que um toque e finalizado
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //remove as acoes de andar e animarAndando
    //[self.jogador removeActionForKey:@"andar"];
    //[self.jogador removeActionForKey:@"animandoAndando"];
    
    [self.jogador pararAndar];
}

//metodo do delegate de contato que e chamado assim que comeca o contato
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




@end

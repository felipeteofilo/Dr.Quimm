//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"

#define cameraEdge 150

@implementation DQFlorestaParte1


//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //DQCutsceneControle *teste = [[DQCutsceneControle alloc]initComParte:1];
        
       
        
        SKNode *mundo = [SKNode node];
        mundo.name = @"mundo";
        
        //Inicia o jogador pelo singleton
        self.jogador = [DQJogador sharedJogador];
        
        //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
        self.physicsWorld.gravity=CGVectorMake(0, -3);
        
        //Configura o timer para 0
        self.intervaloUltimoUpdate=0;

        SKSpriteNode *primeiraParte =[SKSpriteNode spriteNodeWithImageNamed:@"parte1C"];
        
        
        
        [primeiraParte setAnchorPoint:CGPointMake(0, 0)];
        [primeiraParte setPosition:CGPointMake(0,0)];
        CGFloat offsetX = primeiraParte.frame.size.width * primeiraParte.anchorPoint.x;
        CGFloat offsetY = primeiraParte.frame.size.height * primeiraParte.anchorPoint.y;
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0 - offsetX, 224 - offsetY);
        CGPathAddLineToPoint(path, NULL, 373 - offsetX, 187 - offsetY);
        CGPathAddLineToPoint(path, NULL, 376 - offsetX, 141 - offsetY);
        CGPathAddLineToPoint(path, NULL, 932 - offsetX, 121 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1023 - offsetX, 127 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1023 - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, 2 - offsetX, 0 - offsetY);
        
        CGPathCloseSubpath(path);

        primeiraParte.physicsBody =[SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        primeiraParte.physicsBody.categoryBitMask=ChaoCategoria;
        primeiraParte.physicsBody.usesPreciseCollisionDetection=YES;
        primeiraParte.physicsBody.dynamic=NO;
        
        primeiraParte.hidden =YES;
        
        SKSpriteNode *segundaParte = [SKSpriteNode spriteNodeWithImageNamed:@"parte2C"];
        [segundaParte setAnchorPoint:CGPointMake(0, 0)];
        [segundaParte setPosition:CGPointMake(self.frame.size.width, 0)];
        offsetX = segundaParte.frame.size.width * segundaParte.anchorPoint.x;
        offsetY = segundaParte.frame.size.height * segundaParte.anchorPoint.y;
        
        path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0 - offsetX, 128 - offsetY);
        CGPathAddLineToPoint(path, NULL, 606 - offsetX, 162 - offsetY);
        CGPathAddLineToPoint(path, NULL, 613 - offsetX, 300 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1022 - offsetX, 303 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1022 - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
        
        CGPathCloseSubpath(path);
        
        segundaParte.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        
        segundaParte.physicsBody.categoryBitMask=ChaoCategoria;
        segundaParte.physicsBody.usesPreciseCollisionDetection=YES;
        segundaParte.physicsBody.dynamic=NO;
        segundaParte.hidden =YES;
        
        SKSpriteNode *terceiraParte = [SKSpriteNode spriteNodeWithImageNamed:@"parte3C"];
        [terceiraParte setAnchorPoint:CGPointMake(0, 0)];
        [terceiraParte setPosition:CGPointMake(self.frame.size.width*2, 0)];
        
         offsetX = terceiraParte.frame.size.width * terceiraParte.anchorPoint.x;
         offsetY = terceiraParte.frame.size.height * terceiraParte.anchorPoint.y;
        
        path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 2 - offsetX, 303 - offsetY);
        CGPathAddLineToPoint(path, NULL, 38 - offsetX, 302 - offsetY);
        CGPathAddLineToPoint(path, NULL, 42 - offsetX, 192 - offsetY);
        CGPathAddLineToPoint(path, NULL, 602 - offsetX, 201 - offsetY);
        CGPathAddLineToPoint(path, NULL, 612 - offsetX, 63 - offsetY);
        CGPathAddLineToPoint(path, NULL, 688 - offsetX, 52 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1023 - offsetX, 54 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1022 - offsetX, 1 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1 - offsetX, 0 - offsetY);
        
        CGPathCloseSubpath(path);
        
        terceiraParte.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        
        terceiraParte.physicsBody.categoryBitMask=ChaoCategoria;
        terceiraParte.physicsBody.usesPreciseCollisionDetection=YES;
        terceiraParte.physicsBody.dynamic=NO;
        terceiraParte.hidden =YES;
        
       
        
        SKSpriteNode *chaoReal =[SKSpriteNode spriteNodeWithImageNamed:@"parte1"];
        
        [chaoReal setAnchorPoint:CGPointMake(0, 0)];
        [chaoReal setPosition:CGPointMake(0, 0)];
        
        SKSpriteNode *chaoReal2 =[SKSpriteNode spriteNodeWithImageNamed:@"parte2"];
        
        [chaoReal2 setAnchorPoint:CGPointMake(0, 0)];
        [chaoReal2 setPosition:CGPointMake(self.frame.size.width, 0)];
        
        SKSpriteNode *chaoReal3 =[SKSpriteNode spriteNodeWithImageNamed:@"parte3"];
        
        [chaoReal3 setAnchorPoint:CGPointMake(0, 0)];
        [chaoReal3 setPosition:CGPointMake(self.frame.size.width*2, 0)];
        
        
        
        //seta as categorias de colisao do jogador
        self.jogador.physicsBody.categoryBitMask=JogadorCategoria;
        self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
        
        
        //Seta que a classe que ira delegar o contato sera essa mesma
        [self.physicsWorld setContactDelegate:self];
        
        //adiuciona o jogador e o chao na cena
        [mundo addChild:primeiraParte];
        [mundo addChild:segundaParte];
        [mundo addChild:terceiraParte];
        
        [mundo addChild:chaoReal];
        [mundo addChild:chaoReal2];
        [mundo addChild:chaoReal3];
        
        
        
        [self addChild:mundo];
        

        [mundo addChild:self.jogador];
        self.posicaoXJogador=self.jogador.position.x;
        
        NSLog(@"posicao x jogador %f",self.posicaoXJogador);
        
    }
    return self;
}

- (void)didSimulatePhysics
{
  // [self childNodeWithName: @"//camera"].position = CGPointMake(self.jogador.position.x, self.jogador.position.y);
    
    //[self centerOnNode: [self childNodeWithName: @"//camera"]];
    //[self childNodeWithName: @"//mundo"].position = CGPointMake(-(self.jogador.position.x-(self.size.width/2)), -(self.jogador.position.y-(self.size.height/2))-200);
    
    
    
    
        CGPoint heroPosition = self.jogador.position;
        CGPoint worldPosition = [self childNodeWithName: @"//mundo"].position;
        
        //NSLog(@"%f", heroPosition.x);
        
        CGFloat xCoordinate = worldPosition.x + heroPosition.x ;
        
        if(xCoordinate <= cameraEdge && heroPosition.x >= 150)
        {
            worldPosition.x = worldPosition.x - xCoordinate  + cameraEdge   ;
            
        }
        
        else if(xCoordinate > (self.frame.size.width - cameraEdge) && heroPosition.x < 2922)
        {
            worldPosition.x = worldPosition.x + (self.frame.size.width - xCoordinate) - cameraEdge;
           
        }
        
        [self childNodeWithName: @"//mundo"].position= worldPosition;
    
   
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

-(void)update:(NSTimeInterval)currentTime{
    
    //Guardar variação do timer
    CFTimeInterval tempoDesdeUltimoUpdate=currentTime -self.intervaloUltimoUpdate;

    self.intervaloUltimoUpdate=currentTime;
    
    if (tempoDesdeUltimoUpdate > 0.5) {
        // se sepassou mais de um segundo
        tempoDesdeUltimoUpdate =1.0/60.0;
        self.intervaloUltimoUpdate = currentTime;
        
        NSLog(@"%f",tempoDesdeUltimoUpdate);
    }
    
    //[self updateWithTimeSinceLastUpdate:tempoDesdeUltimoUpdate];
    
    //FAZER UMA VERIFICAÇÃO TIMER PARA NÃO FICAR CRIANDO DIRETO - em x tempo chama o método
    //A cada update ele vai fazer a verificação da variavel posicaoXJogador
        //[self criarParteFase];
    
}

//método chamado no update para trabalhar com a variação de tempo no jogo
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)tempoDesdeUltimoUpdate{
    NSLog(@"%f",tempoDesdeUltimoUpdate);
}

-(void)criarParteFase{

    //se for maior que a metade do tamanho de uma skScene ele irá criar um skNode com o physicsbody da prox parte do cenario
    if (self.posicaoXJogador > CGRectGetMidX(self.frame)){
        //verifica se ja tem um node com o nome @proxParte
        

            //Se não //verifica se tem parte a ser criada
                //se tiver Cria o skspritenode com o fundo da prox parte e corpo fisico
        
            //posiciona após a cena
    }else if (self.posicaoXJogador < CGRectGetMidX(self.frame)){
        //verifica se ja tem um node com o nome @parteAnterior
        
        
        //Se não tiver Cria o skspritenode com o fundo da parteAnterior e corpo fisico
        
        //posiciona após a cena
    }
    
    
}




@end

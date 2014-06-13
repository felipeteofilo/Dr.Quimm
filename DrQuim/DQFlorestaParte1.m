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
        
        //Inicia o jogador pelo singleton
        self.jogador = [DQJogador sharedJogador];
        
        //Cria o chao e seta o phisics body dele e cria a gravidade do mundo
        self.physicsWorld.gravity=CGVectorMake(0, -3);
        

        SKSpriteNode *chao =[SKSpriteNode spriteNodeWithImageNamed:@"parte1C"];
        [chao setAnchorPoint:CGPointMake(0, 0)];
        [chao setPosition:CGPointMake(0,0)];
        CGFloat offsetX = chao.frame.size.width * chao.anchorPoint.x;
        CGFloat offsetY = chao.frame.size.height * chao.anchorPoint.y;
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0 - offsetX, 224 - offsetY);
        CGPathAddLineToPoint(path, NULL, 373 - offsetX, 187 - offsetY);
        CGPathAddLineToPoint(path, NULL, 376 - offsetX, 141 - offsetY);
        CGPathAddLineToPoint(path, NULL, 932 - offsetX, 121 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1023 - offsetX, 127 - offsetY);
        CGPathAddLineToPoint(path, NULL, 1023 - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, 2 - offsetX, 0 - offsetY);
        
        CGPathCloseSubpath(path);

        chao.physicsBody =[SKPhysicsBody bodyWithEdgeLoopFromPath:path];
        chao.physicsBody.categoryBitMask=ChaoCategoria;
        chao.physicsBody.usesPreciseCollisionDetection=YES;
        chao.physicsBody.dynamic=NO;
        
        chao.hidden =YES;
        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"parte2C"];
//        [sprite setAnchorPoint:CGPointMake(0, 0)];
//        [sprite setPosition:CGPointMake(0, 0)];
//        offsetX = sprite.frame.size.width * sprite.anchorPoint.x;
//        offsetY = sprite.frame.size.height * sprite.anchorPoint.y;
//        
//        path = CGPathCreateMutable();
//        
//        CGPathMoveToPoint(path, NULL, 0 - offsetX, 128 - offsetY);
//        CGPathAddLineToPoint(path, NULL, 606 - offsetX, 162 - offsetY);
//        CGPathAddLineToPoint(path, NULL, 613 - offsetX, 300 - offsetY);
//        CGPathAddLineToPoint(path, NULL, 1022 - offsetX, 303 - offsetY);
//        CGPathAddLineToPoint(path, NULL, 1022 - offsetX, 0 - offsetY);
//        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
//        
//        CGPathCloseSubpath(path);
//        
//        sprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
//        
//        sprite.physicsBody.categoryBitMask=ChaoCategoria;
//        sprite.physicsBody.usesPreciseCollisionDetection=YES;
//        sprite.physicsBody.dynamic=NO;
//        
//        [sprite setAnchorPoint:CGPointMake(0, 0)];
//        [sprite setPosition:CGPointMake(0, 0)];
        
        
        SKSpriteNode *chaoReal =[SKSpriteNode spriteNodeWithImageNamed:@"parte1"];
        
        [chaoReal setAnchorPoint:CGPointMake(0, 0)];
        [chaoReal setPosition:CGPointMake(0, 0)];
        
        //seta as categorias de colisao do jogador
        self.jogador.physicsBody.categoryBitMask=JogadorCategoria;
        self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
        
        
        //Seta que a classe que ira delegar o contato sera essa mesma
        [self.physicsWorld setContactDelegate:self];
        
        //adiuciona o jogador e o chao na cena
        [self addChild:chao];
        //[self addChild:sprite];
        [self addChild:chaoReal];
        [self addChild:self.jogador];
        
    }
    return self;
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

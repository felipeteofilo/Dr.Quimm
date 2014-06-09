//
//  DQFlorestaParte1.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 27/05/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFlorestaParte1.h"

@implementation DQFlorestaParte1

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.jogador = [[DQJogador alloc]initWithImageNamed:@"Standing"];
        
        self.physicsWorld.gravity=CGVectorMake(0, -3);
        
        SKSpriteNode *chao=[SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(self.size.width*2, 10)];
        
        [chao setPosition:CGPointMake(10,0)];
        chao.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:chao.size];
        chao.physicsBody.affectedByGravity=YES;
        chao.physicsBody.collisionBitMask=ChaoCategoria;
        chao.physicsBody.usesPreciseCollisionDetection=YES;
        chao.physicsBody.dynamic=NO;
        
        self.jogador.physicsBody.categoryBitMask=JogadorCategoria;
        self.jogador.physicsBody.contactTestBitMask = ChaoCategoria;
        
        [self.physicsWorld setContactDelegate:self];
        [self addChild:chao];
        [self addChild:self.jogador];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *posicao = [touches anyObject];
    if (touches.count > 1) {
        [self.jogador pular];
    }
   
    
    if ([posicao locationInView:self.view].x > self.view.frame.size.height/2 ) {
        
       [self.jogador andarParaDirecao:@"D"];
    }else{
        [self.jogador andarParaDirecao:@"E"];
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.jogador removeActionForKey:@"andar"];
    [self.jogador removeActionForKey:@"animandoAndando"];
    
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
        if ((secondBody.categoryBitMask & ChaoCategoria) !=0) {
            
            [self.jogador setEstaNoChao:true];
            
        }
    }
    
}




@end

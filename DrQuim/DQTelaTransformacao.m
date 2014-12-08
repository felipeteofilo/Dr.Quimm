//
//  DQTelaTransformacao.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTelaTransformacao.h"

@implementation DQTelaTransformacao



-(id)initWithSize:(CGSize)size :(NSArray*)elementos :(Receita*)receita{
    if (self = [super initWithSize:size]) {
        
        self.lugaresAnteriores =[[NSMutableArray alloc]init];
        [self criarElementos:elementos];
        
    }
    return self;
}


-(void)criarElementos:(NSArray*)elementos{
    
    for(int i = 0; i < elementos.count; i++){
        
        Elemento * elemento = [DQCoreDataController procurarElemento:[elementos objectAtIndex:i]];
       
        SKSpriteNode *elementoSprite =[[SKSpriteNode alloc]initWithImageNamed:elemento.imagem];
        [elementoSprite setAnchorPoint:CGPointZero];
       
        [elementoSprite setSize:CGSizeMake(self.size.width*0.1, self.size.width*0.1)];
        
        
       
        int x = arc4random() % (int)(self.size.width - elementoSprite.size.width);
        
        int y = arc4random() % (int)(self.size.height - elementoSprite.size.height);
        
        if (self.lugaresAnteriores.count > 0) {
            for (int j = 0; j < self.lugaresAnteriores.count; j++) {
                
                NSString *stringPontoAnterior = [self.lugaresAnteriores objectAtIndex:j];
                CGPoint pontoAnterior = CGPointFromString(stringPontoAnterior);
                int distanciaX = pontoAnterior.x - x;
                int distanciaY = pontoAnterior.y - y;
                
                if (distanciaX < 0) {
                    distanciaX = distanciaX *-1;
                }
                if (distanciaY < 0) {
                    distanciaY = distanciaY *-1;
                }
                
                
                if (distanciaX < elementoSprite.size.width ){
                     x = arc4random() % (int)(self.size.width - elementoSprite.size.width);
                    j--;
                }
                if (distanciaY < elementoSprite.size.height ){
                    y = arc4random() % (int)(self.size.height - elementoSprite.size.height);
                    if(j > 0){
                        j--;
                    }
                }
                
            }
            
        }
        
        NSString *ponto = [NSString stringWithFormat:@"{%d, %d}",x,y];
        
        
        [self.lugaresAnteriores addObject:ponto];
        
        
        
        [elementoSprite setPosition:CGPointMake(x, y)];
      
        [self shake:4 node:elementoSprite];
        [self addChild:elementoSprite];
        
    }
}

-(void)shake:(NSInteger)times node:(SKSpriteNode*)elemento {
    
    NSInteger amplitudeX = 20;
    NSInteger amplitudeY = 20;
    NSMutableArray * randomActions = [NSMutableArray array];
    for (int i=0; i<times; i++) {
        NSInteger randX = elemento.position.x+arc4random() % amplitudeX - amplitudeX/2;
        NSInteger randY = elemento.position.y+arc4random() % amplitudeY - amplitudeY/2;
        SKAction *action = [SKAction moveTo:CGPointMake(randX, randY) duration:0.1];
        [randomActions addObject:action];
    }
    
    SKAction *rep = [SKAction sequence:randomActions];
    
    [elemento runAction:[SKAction repeatActionForever:rep]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
   
    
}








@end

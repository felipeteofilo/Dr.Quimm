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
        [self.physicsWorld setContactDelegate:self];
        
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];
        [self.physicsBody setCategoryBitMask:ParedesCategoria];
        
        
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
        
         [elementoSprite setPhysicsBody:[SKPhysicsBody bodyWithPolygonFromPath:[self pathForRectangleOfSize:elementoSprite.size withAnchorPoint:elementoSprite.anchorPoint]]];
        
        [elementoSprite.physicsBody setAffectedByGravity:NO];
        [elementoSprite.physicsBody setFriction:0];
        [elementoSprite.physicsBody setRestitution:0];
        [elementoSprite.physicsBody setAllowsRotation:NO];
       
        [elementoSprite.physicsBody setUsesPreciseCollisionDetection:YES];
        
        
        
        [elementoSprite.physicsBody setCategoryBitMask:ElementoCategoria];
       
        
        [elementoSprite.physicsBody setContactTestBitMask:ElementoCategoria];
        
      
        [self shake:4 node:elementoSprite];
        
        
        [elementoSprite setName:@"Elemento"];
        [self addChild:elementoSprite];
        
    }
}


-(void)didBeginContact:(SKPhysicsContact *)contact{
    
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
    if ((firstBody.categoryBitMask & ElementoCategoria)!=0) {
        if ((secondBody.categoryBitMask & ElementoCategoria) !=0 ) {
            
            SKPhysicsJointLimit *pin = [SKPhysicsJointLimit jointWithBodyA:contact.bodyA bodyB:contact.bodyB anchorA:contact.bodyA.node.position anchorB:contact.bodyB.node.position ];
            
            [pin setMaxLength:self.size.width*0.1];
            
            NSString *firePath = [[NSBundle mainBundle] pathForResource:@"Spark" ofType:@"sks"];
            
            SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
            [fire setParticleScale:1];
            [fire setParticleLifetime:0.3];
            [fire setParticleSize:CGSizeMake(10, 10)];
            
            
            
            //changing the targetnode from spaceship to scene so that it gets influenced by movement
            fire.targetNode = firstBody.node;
            
            [firstBody.node addChild:fire];
            
            [self.physicsWorld addJoint:pin];
    }
    }
}





//metodo para centralizar o physics body na textura dele
- (CGPathRef)pathForRectangleOfSize:(CGSize)size withAnchorPoint:(CGPoint)anchor {
    CGPathRef path = CGPathCreateWithRect( CGRectMake(-size.width * anchor.x, -size.height * anchor.y,
                                                      size.width,   size.height), nil);
    return path;
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
    
    UITouch *toque = [touches anyObject];
    CGPoint posicaoToque = [toque locationInNode:self];
    
    self.nodeTocado = (SKSpriteNode*)[self nodeAtPoint:posicaoToque];
    self.posicaoDelta = CGPointMake(posicaoToque.x - self.nodeTocado.frame.origin.x, posicaoToque.y - self.nodeTocado.frame.origin.y);
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *toque = [touches anyObject];
    CGPoint posicaoToque = [toque locationInNode:self];
    
    if ([self.nodeTocado.name isEqualToString:@"Elemento"]) {
        [self.nodeTocado removeAllActions];
        
        float x = posicaoToque.x - self.posicaoDelta.x;
        float y = posicaoToque.y - self.posicaoDelta.y;
        float largura = self.nodeTocado.frame.size.width;
        float altura = self.nodeTocado.frame.size.height;
        
        //verifica se está dentro da tela
        if(x >= 0 && x+largura <= self.frame.size.width && y >= 0 && y+altura <= self.frame.size.height){
            [self.nodeTocado setPosition:CGPointMake(x, y)];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
    
    if ([self.nodeTocado.name isEqualToString:@"Elemento"]) {
        [self shake:4 node:self.nodeTocado];
        self.nodeTocado = nil;
    }
}








@end

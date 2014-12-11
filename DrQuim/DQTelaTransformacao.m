//
//  DQTelaTransformacao.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 08/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTelaTransformacao.h"

@implementation DQTelaTransformacao



-(id)initWithSize:(CGSize)size receita:(Receita*)receita{
    if (self = [super initWithSize:size]) {
        SKSpriteNode *fundo = [[SKSpriteNode alloc]initWithImageNamed:@"transform_fundo"];
        
        [fundo setSize:self.size];
        [fundo setAnchorPoint:CGPointZero];
        [fundo setZPosition:-100];
        [self addChild:fundo];
        
        [self lerFrames];
        self.lugaresAnteriores =[[NSMutableArray alloc]init];
        [self criarElementos:receita.elementos];
        [self.physicsWorld setContactDelegate:self];
        
        self.receita = receita;
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame]];
        
        
        
        
        SKLabelNode *formula = [[SKLabelNode alloc]initWithFontNamed:[DQConfigMenu fonteMenu]];
        
        [formula setText:receita.resultado];
        
        [formula setPosition:CGPointMake(self.size.width *0.8, self.size.height*0.9)];
        
        
        
        [self addChild:formula];
        
        
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
        
        NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
        
        [info setObject:elemento.simbolo forKey:@"Nome"];
        [info setObject:[NSNumber numberWithInt:1] forKey:@"Quantidade"];
        
        [elementoSprite setUserData:info];
        
        SKLabelNode *numero = [[SKLabelNode alloc]init];
        
        [numero setName:@"Numero"];
        
        [numero setText:[NSString stringWithFormat:@"%d",1]];
        
        [numero setColor:[UIColor whiteColor]];
        [numero setFontName:[DQConfigMenu fonteMenu]];
        
        [numero setPosition:CGPointMake(elementoSprite.size.width, 0)];
        
        [elementoSprite addChild:numero];
        
        
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
            
            SKSpriteNode *elemento1 = (SKSpriteNode*)firstBody.node;
            
            SKSpriteNode *elemento2 = (SKSpriteNode*)secondBody.node;
            
            
            if([self verificarJuncao:elemento1 elemento2:elemento2]){
                
                SKSpriteNode *sprite =[[SKSpriteNode alloc]init];
                
                
                [sprite setSize:CGSizeMake(elemento1.size.height*4.5,elemento1.size.width*4.5)];
                [sprite setAnchorPoint:CGPointMake(0.4, 0.4)];
                [sprite setZPosition:-10];
                [elemento1 addChild:sprite];
                
                [sprite runAction:[SKAction animateWithTextures:self.framesSucesso timePerFrame:0.1] completion:^{
                    [sprite removeFromParent];
                }];
                
                
                
                SKPhysicsJointLimit *pin = [SKPhysicsJointLimit jointWithBodyA:contact.bodyA bodyB:contact.bodyB anchorA:contact.bodyA.node.position anchorB:contact.bodyB.node.position ];
                
               
                [pin setMaxLength:self.size.width*0.1];
                
                [self animarJuntos:elemento1];
                [self animarJuntos:elemento2];
                
                
                [self.physicsWorld addJoint:pin];
            }
            else {
                SKSpriteNode *sprite =[[SKSpriteNode alloc]init];
                
                
                [sprite setSize:CGSizeMake(elemento1.size.height*3.5,elemento1.size.width*3.5)];
                [sprite setAnchorPoint:CGPointMake(0.4, 0.4)];
                
                [elemento1 addChild:sprite];
                [sprite setZPosition:-10];
                [sprite runAction:[SKAction animateWithTextures:self.framesErro timePerFrame:0.1] completion:^{
                    [sprite removeFromParent];
                }];
                
            }
        }
    }
}



-(void)animarJuntos :(SKSpriteNode*)elemento1{
    if(![elemento1 childNodeWithName:@"raios"]){
        SKSpriteNode *sprite =[[SKSpriteNode alloc]init];
        [sprite setName:@"raios"];
        
        [sprite setSize:CGSizeMake(elemento1.size.height*2,elemento1.size.width*2)];
        [sprite setAnchorPoint:CGPointMake(0.35, 0.35)];
        [sprite setZPosition:-10];
        [elemento1 addChild:sprite];
        
        [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.framesJuntos timePerFrame:0.1]]];
    }
}


-(void)lerFrames{
    
    
    self.framesSucesso = [DQUteis lerFrames:[SKTextureAtlas atlasNamed:@"Sucesso"]];
    self.framesJuntos = [DQUteis lerFrames:[SKTextureAtlas atlasNamed:@"Conectado"]];
    self.framesErro = [DQUteis lerFrames:[SKTextureAtlas atlasNamed:@"Falha"]];
}


-(BOOL)verificarJuncao :(SKSpriteNode*)elemento1 elemento2:(SKSpriteNode*)elemento2{
    
    BOOL pode = false;
    
    
    NSDictionary * info =[self.receita.ligacoes objectForKey:[elemento1.userData objectForKey:@"Nome"]];
    
    SKLabelNode *numero = (SKLabelNode*)[elemento1 childNodeWithName:@"Numero"];
    SKLabelNode *numero2 = (SKLabelNode*)[elemento2 childNodeWithName:@"Numero"];
    
    if([numero.text intValue] == [[info objectForKey:@"Quantidade"]intValue]){
        if ([[[info objectForKey:@"Elemento"]objectForKey:@"Nome"] isEqualToString:[elemento2.userData objectForKey:@"Nome"]] && [[[info objectForKey:@"Elemento"]objectForKey:@"Quantidade"]intValue] == [numero2.text intValue] ) {
            
            [elemento1.userData setObject:[info objectForKey:@"Resultado"] forKey:@"Nome"];
            [elemento2.userData setObject:[info objectForKey:@"Resultado"] forKey:@"Nome"];
            
            if(elemento1.physicsBody.joints.count >0){
                for (int i = 0; i < elemento1.physicsBody.joints.count; i++) {
                    [[[[[elemento1.physicsBody.joints objectAtIndex:i]bodyA]node]userData]setObject:[info objectForKey:@"Resultado"] forKey:@"Nome"];
                    [[[[[elemento1.physicsBody.joints objectAtIndex:i]bodyB]node]userData]setObject:[info objectForKey:@"Resultado"] forKey:@"Nome"];
                }
            }
            if(elemento2.physicsBody.joints.count >0){
                for (int i = 0; i < elemento2.physicsBody.joints.count; i++) {
                    
                    [[[[[elemento2.physicsBody.joints objectAtIndex:i]bodyA]node]userData]setObject:[info objectForKey:@"Resultado"] forKey:@"Nome"];
                    [[[[[elemento2.physicsBody.joints objectAtIndex:i]bodyB]node]userData]setObject:[info objectForKey:@"Resultado"] forKey:@"Nome"];
                }
            }
            
            self.ligacoes++;
            
            if(self.ligacoes >= [self.receita.numero_ligacoes intValue]){
                [self transformacaoCompleta];
            }
            
            pode = true;
        }
    }
    return pode;
}

-(void)transformacaoCompleta{
    DQJogador *jogador = [DQJogador sharedJogador];
    
    [jogador.itens receberItem:self.receita.id_item_gerar quantidade:1];
    [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
}

//metodo para centralizar o physics body na textura dele
- (CGPathRef)pathForRectangleOfSize:(CGSize)size withAnchorPoint:(CGPoint)anchor {
    CGPathRef path = CGPathCreateWithRect( CGRectMake(-size.width * anchor.x, -size.height * anchor.y,
                                                      size.width,   size.height), nil);
    return path;
}

-(void)shake:(NSInteger)times node:(SKSpriteNode*)elemento {
    
    NSInteger amplitudeX = 10;
    NSInteger amplitudeY = 10;
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
    
    if(toque.tapCount == 2){
        SKLabelNode *numero = (SKLabelNode*)[self.nodeTocado childNodeWithName:@"Numero"];
        NSString *numeroString = numero.text;
        
        int num = [numeroString intValue];
        num++;
        
        [numero setText:[NSString stringWithFormat:@"%d",num]];
        
        [self.nodeTocado.userData setObject:[NSNumber numberWithInt:num] forKey:@"Quantidade"];
        
        [self.nodeTocado removeAllChildren];
        [self.nodeTocado addChild:numero];
    }
    self.lastTouch = event.timestamp ;
    
    
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
    
    
    if(event.timestamp - self.lastTouch > 0.5 && [self.nodeTocado hasActions] && [self.nodeTocado.name isEqualToString:@"Elemento"] && !self.nodeTocado.physicsBody.joints.count > 0){
        
        SKLabelNode *numero = (SKLabelNode*)[self.nodeTocado childNodeWithName:@"Numero"];
        [numero setText:[NSString stringWithFormat:@"%d",1]];
        
        [self.nodeTocado.userData setObject:[NSNumber numberWithInt:1] forKey:@"Quantidade"];
        
        [self.nodeTocado removeAllChildren];
        [self.nodeTocado addChild:numero];
        
    }
    
    if ([self.nodeTocado.name isEqualToString:@"Elemento"]) {
        [self shake:4 node:self.nodeTocado];
        self.nodeTocado = nil;
    }
}








@end

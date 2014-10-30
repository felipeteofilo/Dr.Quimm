//
//  DQMapaMundi.m
//  DrQuim
//
//  Created by Leonardo de Sousa Mendes on 29/10/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCenaMapaMundi.h"

@implementation DQCenaMapaMundi

-(id)initWithSize:(CGSize)size{
    if (self=[super initWithSize:size]) {
        self.controleMapaMundi =[[DQMapaMundiControle alloc]init];
        self.controleFases=[DQFasesControle sharedFasesControle];
        
        [self configuraMapa];
        
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"MapaFundo"];
        [background setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [background setZPosition:-100];
        [self addChild:background];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    SKNode *nodeTocado=[self nodeAtPoint:[[touches anyObject]locationInNode:self]];
    
    int idFaseTocada=[[nodeTocado.userData objectForKey:@"IDFase"]intValue];
    
    if ([self.controleMapaMundi faseDisponivel:idFaseTocada]) {
        [self.controleFases mudarDeFase:idFaseTocada Scene:self];
    }

}

//Cria um array de nodes onde o userDefaults sera = ao ID da fase
-(void)configuraMapa{
    //Crio um Dictonary com informacao de disponível e IDFase
    
    SKSpriteNode *nodeIconeFase;
    for (int i=1; i< [self.controleMapaMundi.fasesConfiguradas count]+1; i++) {
        nodeIconeFase=[SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(80,80)];
        
        //Adicionado o +1 no I para acertar o index com o ID salvo no coreData
        if ([self.controleMapaMundi faseDisponivel:i]) {
            [nodeIconeFase setAlpha:0.7f];
        }
        
        [nodeIconeFase setUserData:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i]] forKeys:@[@"IDFase"]]];
        
        [self posicionaNode:nodeIconeFase idFase:i];
        [self addChild:nodeIconeFase];
    }
}

-(void)posicionaNode:(SKSpriteNode*)node idFase:(int)idFase{
    switch (idFase) {
        case 1:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.72f, CGRectGetHeight(self.frame)*0.7f)];
            break;

        case 2:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.73f, CGRectGetHeight(self.frame)*0.83f)];
            break;
            
        case 3:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.65f, CGRectGetHeight(self.frame)*0.58f)];
            break;
            
        case 4:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.75f, CGRectGetHeight(self.frame)*0.4f)];
            break;
            
        case 5:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.7f, CGRectGetHeight(self.frame)*0.15f)];
            break;
            
        case 6:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.52f, CGRectGetHeight(self.frame)*0.6f)];
            break;
            
        case 7:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.53f, CGRectGetHeight(self.frame)*0.4f)];
            break;
            
        case 8:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.25f, CGRectGetHeight(self.frame)*0.67f)];
            break;
            
        case 9:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.15f, CGRectGetHeight(self.frame)*0.3f)];
            break;
            
        case 10:
            //[node setTexture:[SKTexture textureWithImageNamed:@"aquiNomeImgCortada"]];
            [node setPosition:CGPointMake(CGRectGetWidth(self.frame)*0.365f, CGRectGetHeight(self.frame)*0.55f)];
            break;
        default:
            break;
    }
}
@end

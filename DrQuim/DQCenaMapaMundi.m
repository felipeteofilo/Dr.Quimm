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
        nodeIconeFase=[SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(100, 100)];
        
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
            [node setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
            break;

        case 2:
            [node setPosition:CGPointZero];
            break;
            
        case 3:
            [node setPosition:CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame))];
            break;
        default:
            break;
    }
}
@end

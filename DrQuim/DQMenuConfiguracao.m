//
//  DQMenuConfiguracao.m
//  testeMenu
//
//  Created by Leonardo de Sousa Mendes on 25/07/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "DQMenuConfiguracao.h"

@implementation DQMenuConfiguracao
-(id)initMenu{
    if (self=[super initWithImageNamed:@"FundoMenu.png"]) {
        [self setUserInteractionEnabled:YES];
        [self setName:@"Configurações"];
        [self configuraTitulo];
    }
    return self;
}

-(void)configuraTitulo{
    
    self.titulo=[SKLabelNode labelNodeWithFontNamed:[DQConfigMenu fonteMenu]];
    
    [self.titulo setText:self.name];
    [self.titulo setFontSize:90.0f];
    [self.titulo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)-self.titulo.frame.size.height-50)];
    [self.titulo setName:@"Titulo"];
    
    [self addChild:self.titulo];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint posToque=[[touches anyObject]locationInNode:self];
    NSArray *arrayNodes=[self nodesAtPoint:posToque];
    
    if ([[self nodeAtPoint:posToque].name isEqualToString:self.titulo.name]) {
        [self esconderMenu];
    }
}

-(void)esconderMenu{
    [self removeFromParent];
}
@end

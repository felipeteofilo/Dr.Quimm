//
//  RTBotao.m
//  Robotunes
//
//  Created by LEONARDO DE SOUSA MENDES on 29/09/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import "DQBotao.h"

@implementation DQBotao

-(id)initBotao:(NSString*)imagemBotao comSel:(SEL)seletor eDelegate:(id)delegate eTamanho:(CGSize)size{
    if (self=[super initWithImageNamed:imagemBotao]) {
        [self setAcaoRealizar:seletor];
        [self setDelegateBotao:delegate];
        
        [self setSize:size];
        
        //Ativa a interacao do User
        [self setUserInteractionEnabled:YES];
        
        //Seta alpha baixo
        [self setAlpha:0.2f];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setAlpha:0.6f];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //Faz a ação do botão
    if ([self.delegateBotao respondsToSelector:self.acaoRealizar]) {
        [self.delegateBotao performSelector:self.acaoRealizar];
    }
    
    [self setAlpha:0.2f];
}
@end

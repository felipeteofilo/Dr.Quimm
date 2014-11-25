//
//  DQTelaInfoReceitas.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 25/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTelaInfoReceitas.h"

@implementation DQTelaInfoReceitas

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(id)initComReceitas:(NSArray*)receitas frame:(CGRect)frame{
    if(self = [super init]){
        [self setFrame:CGRectMake(frame.size.width*0.1, frame.size.height*0.8, frame.size.width*0.45, frame.size.height*0.2)];
        
       // [self setBackgroundColor:[UIColor blackColor]];
        
        [self montarReceitas:receitas];
        
    }
    return self;
}

-(void)montarReceitas :(NSArray*)receitas{
    
    
    for (int i = 0; i < receitas.count; i++) {
        
        CGSize tamanhoBotao = CGSizeMake(self.frame.size.height *0.7, self.frame.size.height *0.7);
        
        UIButton *receita = [[UIButton alloc]init];
        
        [receita setFrame:CGRectMake((tamanhoBotao.width * i)-(tamanhoBotao.width*0.4)*i, tamanhoBotao.height*0.03, tamanhoBotao.width, tamanhoBotao.height)];
        
        
        
        [receita setBackgroundImage:[UIImage imageNamed:@"postit"] forState:UIControlStateNormal];
        
        if (receita.frame.origin.x + receita.frame.size.width > self.frame.size.width) {
            [self setContentSize:CGSizeMake(receita.frame.origin.x + receita.frame.size.width, self.frame.size.height)];
        }
        
        
        
        MarqueeLabel * tituloReceita = [[MarqueeLabel alloc]initWithFrame:CGRectMake(receita.frame.size.width*0.13, receita.frame.size.height*0.3, receita.frame.size.width*0.62, receita.frame.size.height*0.4) duration:2 andFadeLength:10];
        
        [tituloReceita setText:[receitas objectAtIndex:i]];
        
        [receita addSubview:tituloReceita];
        
        [self addSubview:receita];
    }
    [self setCanCancelContentTouches:YES];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}



@end

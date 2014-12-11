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
        
        [receita addTarget:self action:@selector(mostrarInfoReceita:) forControlEvents:UIControlEventTouchUpInside];
        
        [receita setTitle:[receitas objectAtIndex:i]  forState:UIControlStateDisabled];
        
        [receita addSubview:tituloReceita];
        
        [self addSubview:receita];
    }
    [self setCanCancelContentTouches:YES];
}


-(void)mostrarInfoReceita :(UIButton*)button{
    
    
    
    if(![self.viewInfo superview] || ![[button titleForState:UIControlStateDisabled] isEqualToString:self.ultimaReceita]){
        if([self.viewInfo superview]){
            [self.viewInfo removeFromSuperview];
        }
        
        Receita *receita = [DQCoreDataController procurarReceita:[button titleForState:UIControlStateDisabled]];
        
        
        
        
        self.viewInfo = [[UIView alloc]initWithFrame:CGRectMake(self.superview.bounds.size.width*0.01, self.superview.bounds.size.height*0.4, self.superview.bounds.size.width*0.2, self.superview.bounds.size.width*0.25)];
        
        
        UIImageView * imagemFundo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"descript"]];
        
        [imagemFundo setFrame:CGRectMake(0, 0, self.viewInfo.frame.size.width, self.viewInfo.frame.size.height)];
        
        MarqueeLabel *nomeReceita = [[MarqueeLabel alloc]initWithFrame:CGRectMake(self.viewInfo.frame.size.width*0.3, self.viewInfo.frame.size.height*0.07, self.viewInfo.frame.size.width*0.65, self.viewInfo.frame.size.height*0.09) duration:5 andFadeLength:10];
        
        
        MarqueeLabel *compostosNecessários = [[MarqueeLabel alloc]initWithFrame:CGRectMake(self.viewInfo.frame.size.width * 0.05, self.viewInfo.frame.size.height*0.7, self.viewInfo.frame.size.width*0.9, self.viewInfo.frame.size.height*0.07) duration:5 andFadeLength:10];
        
        
        
        
        
        [nomeReceita setText:[button titleForState:UIControlStateDisabled]];
        
        [compostosNecessários setText:@"Compostos/Elementos Necessários:"];
        
        [nomeReceita setTextColor:[UIColor blueColor]];
        [compostosNecessários setTextColor:[UIColor blueColor]];
        
         UIFont *boldFontName = [UIFont boldSystemFontOfSize:14];
        
        NSMutableAttributedString *descricao= [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Descrição: %@\n\n",receita.descricao]];
        
        [descricao beginEditing];
        [descricao addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 9)];
        [descricao endEditing];
       
        UITextView * info = [[UITextView alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.05, imagemFundo.frame.size.height*0.182, imagemFundo.frame.size.width * 0.895, imagemFundo.frame.size.height * 0.512)];
        
        
        [info setAttributedText:descricao];
        
        [info setEditable:NO];
        
        [self.viewInfo addSubview:imagemFundo];
        [self.viewInfo addSubview:nomeReceita];
        [self.viewInfo addSubview:compostosNecessários];
        
        [self.superview addSubview:self.viewInfo];
        
        self.ultimaReceita = [button titleForState:UIControlStateDisabled];
        
        
        
        
        [self montarCompostosNecessários:[receita.compostos allKeys]];
        
        self.receitaEscolhida = receita;
        
        
        [self.viewInfo addSubview:info];
    
    }else {
        [self.viewInfo removeFromSuperview];
    }
}

-(void)montarCompostosNecessários :(NSArray*)compostos{
    if([self.scrollViewCompostos superview]){
        [self.scrollViewCompostos  removeFromSuperview];
    }
    
    
    self.scrollViewCompostos  = [[DQScrollView alloc]initWithFrame:CGRectMake(self.viewInfo.frame.size.width*0.05,self.viewInfo.frame.size.height*0.724, self.viewInfo.frame.size.width*0.9, self.viewInfo.frame.size.height*0.26)];
    
    
    for (int i = 0; i < compostos.count; i++) {
        
        CGSize tamanhoImagem = CGSizeMake(self.viewInfo.frame.size.height *0.20, self.viewInfo.frame.size.height *0.20);
        
        NSString *imagem ;
        Composto *composto = [DQCoreDataController procurarComposto:[compostos objectAtIndex:i]];
        
        if(composto == nil){
            
            Elemento *elemento = [DQCoreDataController procurarElemento:[compostos objectAtIndex:i]];
            
            imagem = elemento.imagem;
        }else{
            imagem = composto.imagem;
        }
        
        UIImageView *compostoImagem = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagem]];
        
        [compostoImagem setFrame:CGRectMake((tamanhoImagem.width * i)+(13.5*i), tamanhoImagem.height*0.2, tamanhoImagem.width, tamanhoImagem.height)];
        
        if (compostoImagem.frame.origin.x + compostoImagem.frame.size.width > self.scrollViewCompostos.frame.size.width) {
            [self.scrollViewCompostos setContentSize:CGSizeMake(compostoImagem.frame.origin.x + compostoImagem.frame.size.width, self.scrollViewCompostos.frame.size.height)];
        }
      
        
        
        
        [self.scrollViewCompostos addSubview:compostoImagem];
    }
    [self.scrollViewCompostos setCanCancelContentTouches:YES];
    
    
    
    [self.viewInfo addSubview:self.scrollViewCompostos];

}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}



@end

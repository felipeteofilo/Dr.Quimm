//
//  DQViewCompostosMix.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 04/12/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQViewCompostosMix.h"

@implementation DQViewCompostosMix

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initComTamanho:(CGRect)frame{
    
    if(self = [super init]){
        
        self.compostosParaMix = [[NSMutableArray alloc]init];
        
        [self setFrame:CGRectMake(frame.size.width * 0.5 - (frame.size.width * 0.3)/2,0,frame.size.width * 0.3,frame.size.width * 0.09)];
        
        
        [self setBackgroundColor:[UIColor blackColor]];
        
        self.botaoMix =[[UIButton alloc]initWithFrame:CGRectMake(frame.size.width* 0.5 - (frame.size.width * 0.08)/2, frame.size.height*0.12, frame.size.width * 0.08, frame.size.width * 0.08)];
        
        
        
        [self.botaoMix setBackgroundImage:[UIImage imageNamed:@"btnMIX"] forState:UIControlStateNormal];
        
        [self.botaoMix addTarget:self action:@selector(mix) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
    
}

-(void)mostrarBotaoMix{
    [self.botaoMix setEnabled:NO];
    [self.superview addSubview:self.botaoMix];
}





-(void)verificarComposto:(NSString*)composto{
    
    for (int i = 0; i< [self.receita.compostos allKeys].count;i++) {
        
        if([[[self.receita.compostos allKeys] objectAtIndex:i] isEqualToString:composto]){
            
            for (int j = 0; j< self.compostosParaMix.count; j++) {
                if ([[self.compostosParaMix objectAtIndex:j]isEqualToString:composto]) {
                    break;
                }
                if (j == self.compostosParaMix.count -1) {
                    [self.compostosParaMix addObject:composto];
                    if(self.compostosParaMix.count == [self.receita.compostos allKeys].count){
                        [self.botaoMix setEnabled:YES];
                    }
                    
                }
            }
            if (self.compostosParaMix.count  == 0) {
                [self.compostosParaMix addObject:composto];
            }
            break;
        }
    }
}

-(void)mix{
    
    DQViewControllerTransformacao *viewTransformacao =[[DQViewControllerTransformacao alloc]initWithReceita:self.receita.nome];
    
    if([self.superview.nextResponder isKindOfClass:[UIViewController class]]){
        [((UIViewController*)self.superview.nextResponder)presentViewController:viewTransformacao animated:NO completion:nil];
    }

}

-(void)adicionarComposto :(NSString*)nome{
    
    [self verificarComposto:nome];
    if([self subviews]){
        [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    }
    
    for (int i = 0; i < self.compostosParaMix.count; i++) {
        CGSize tamanhoImagem = CGSizeMake(self.frame.size.height *0.7, self.frame.size.height *0.7);
        
        NSString *imagem ;
        Composto *composto = [DQCoreDataController procurarComposto:[self.compostosParaMix objectAtIndex:i]];
        
        if(composto == nil){
            
            Elemento *elemento = [DQCoreDataController procurarElemento:[self.compostosParaMix objectAtIndex:i]];
            
            imagem = elemento.imagem;
        }else{
            imagem = composto.imagem;
        }
        
        UIImageView *compostoImagem = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagem]];
        
        [compostoImagem setFrame:CGRectMake((tamanhoImagem.width * i)+(13.5*i), tamanhoImagem.height*0.2, tamanhoImagem.width, tamanhoImagem.height)];
        
        if (compostoImagem.frame.origin.x + compostoImagem.frame.size.width > self.frame.size.width) {
            [self setContentSize:CGSizeMake(compostoImagem.frame.origin.x + compostoImagem.frame.size.width, self.frame.size.height)];
        }
        [self addSubview:compostoImagem];
    }
    [self setCanCancelContentTouches:YES];
    
    
}






@end

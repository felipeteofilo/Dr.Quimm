//
//  DQTelaInfoComposto.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTelaInfoComposto.h"
#import "DQCoreDataController.h"
#import "Composto.h"
#import "MarqueeLabel.h"

@implementation DQTelaInfoComposto



-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho nomeComposto:(NSString*)nome{
    
    [self.view setFrame:CGRectMake(posicao.x, posicao.y, tamanho.width *0.25, tamanho.height *0.4)];
    
    UIImageView *imagemFundo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"descript"]];
    
    [imagemFundo setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    Composto *composto = [DQCoreDataController procurarComposto:nome];
    
    MarqueeLabel *nomeComposto1 = [[MarqueeLabel alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.3, imagemFundo.frame.size.height*0.07, imagemFundo.frame.size.width*0.65, imagemFundo.frame.size.height*0.07) duration:5 andFadeLength:10];
    
    [nomeComposto1 setText:nome];
    
    [nomeComposto1 setTextColor:[UIColor blueColor]];
    
    
    
    
    [self.view addSubview:imagemFundo];
    [self.view addSubview:[self montarInfoComposto:composto frameImagem:imagemFundo.frame]];
    [self.view addSubview:nomeComposto1];
    
    [self montarBotoesElementos:composto.elementos];
    
}

-(void)montarBotoesElementos :(NSArray*)nomesElementos{
    
    
    self.scrollViewElementos = [[DQScroolView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.724, self.view.frame.size.width*0.9, self.view.frame.size.height*0.23)];
    
    
    for (int i = 0; i < nomesElementos.count; i++) {
        
        CGSize tamanhoBotao = CGSizeMake(self.view.frame.size.height *0.22, self.view.frame.size.height *0.22);
        
        UIButton *elemento = [[UIButton alloc]init];
        
        [elemento setFrame:CGRectMake((tamanhoBotao.width * i)+(13.5*i), tamanhoBotao.height*0.03, tamanhoBotao.width, tamanhoBotao.height)];
        
        
        [elemento setBackgroundImage:[UIImage imageNamed:@"descript_elementos"] forState:UIControlStateNormal];
        
        if (elemento.frame.origin.x > self.scrollViewElementos.frame.size.width) {
            [self.scrollViewElementos setContentSize:CGSizeMake(elemento.frame.origin.x + elemento.frame.size.width, self.scrollViewElementos.frame.size.height)];
        }
        
        [elemento addTarget:self action:@selector(mostrarInfoElemento:) forControlEvents:UIControlEventTouchUpInside];
        
        [elemento setTitle:[nomesElementos objectAtIndex:i] forState:UIControlStateDisabled];
        
        
        
        [self.scrollViewElementos addSubview:elemento];
    }
    [self.scrollViewElementos setCanCancelContentTouches:YES];
    
    [self.view addSubview:self.scrollViewElementos];
    
}




-(void)mostrarInfoElemento :(UIButton*)button{
    
    
    if([self.view.subviews containsObject:self.infoElemento] ){
        [self.infoElemento removeFromSuperview];
        [self.botaoFechar removeFromSuperview];
    }
    
    
    self.infoElemento = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height *0.7)];
    
    UIImageView *imagemFundo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"descript_popup"]];
    
    [imagemFundo setFrame:self.infoElemento.frame];
    
    Elemento *elemento = [DQCoreDataController procurarElemento:[button titleForState:UIControlStateDisabled]];
    
    
    
    MarqueeLabel *nomeElemento = [[MarqueeLabel alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.33, imagemFundo.frame.size.height*0.1, imagemFundo.frame.size.width*0.65, imagemFundo.frame.size.height*0.07) duration:5 andFadeLength:10];
    
    
    [nomeElemento setText:[button titleForState:UIControlStateDisabled]];
    
    [self.infoElemento setBackgroundColor:[UIColor blueColor]];
    
    
    self.botaoFechar = [[UIButton alloc]initWithFrame:CGRectMake(0 ,0, self.infoElemento.frame.size.height*0.1, self.infoElemento.frame.size.height*0.1)];
    
    [self.botaoFechar setBackgroundColor:[UIColor blackColor]];
    
    
    
    [self.botaoFechar addTarget:self action:@selector(fecharInfo:) forControlEvents:UIControlEventTouchUpInside];
    

    
    [self.infoElemento addSubview:imagemFundo];
    [self.infoElemento addSubview:[self montarInfoElemento:elemento frameImagem:imagemFundo.frame]];
    [self.infoElemento addSubview:nomeElemento];
    [self.view addSubview:self.infoElemento];
    [self.infoElemento addSubview:self.botaoFechar];
    
}


-(UITextView*)montarInfoElemento :(Elemento*)elemento frameImagem :(CGRect)frameImagem{
    
    UITextView * telaInfo = [[UITextView alloc]initWithFrame:CGRectMake(frameImagem.size.width*0.05, frameImagem.size.height*0.25, frameImagem.size.width * 0.895, frameImagem.size.height * 0.68)];
    
    [telaInfo setBackgroundColor:[UIColor clearColor]];
    
    UIFont *boldFontName = [UIFont boldSystemFontOfSize:14];
    
    NSDictionary *info = elemento.info_elemento;
    
    
    NSMutableAttributedString *simbolo= [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Símbolo: %@\n\n",elemento.simbolo]];
    
    [simbolo beginEditing];
    [simbolo addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 7)];
    [simbolo endEditing];
    
    
    NSMutableAttributedString *categoria = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Categoria: %@\n\n",[info objectForKey:@"Categoria"]]];
    
    [categoria beginEditing];
    [categoria addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 9)];
    [categoria endEditing];
    
    NSMutableAttributedString *lugarEncontrado = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Lugar Encontrado: %@\n\n",[info objectForKey:@"LugarEncontrado"]]];
    [lugarEncontrado beginEditing];
    [lugarEncontrado addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 16)];
    [lugarEncontrado endEditing];
    
    NSMutableAttributedString *estadoEncontrado = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Estado Encontrado: %@\n\n",[info objectForKey:@"EstadoEncontrado"]]];
    [estadoEncontrado beginEditing];
    [estadoEncontrado addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 17)];
    [estadoEncontrado endEditing];
    
    
    NSMutableAttributedString *historia = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"História: %@",[info objectForKey:@"Historia"]]];
    [historia beginEditing];
    [historia addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 8)];
    [historia endEditing];
    
    
    
    NSMutableAttributedString * textInfo =[[NSMutableAttributedString alloc]initWithAttributedString:simbolo];
    
    [textInfo appendAttributedString:categoria];
    [textInfo appendAttributedString:lugarEncontrado];
    [textInfo appendAttributedString:estadoEncontrado];
    [textInfo appendAttributedString:historia];
    
    [telaInfo setAttributedText:textInfo];
    [telaInfo setEditable:NO];
    
    return telaInfo;
}

-(UITextView*)montarInfoComposto :(Composto*)composto frameImagem:(CGRect)frameImagem{
    
    UITextView * telaInfo = [[UITextView alloc]initWithFrame:CGRectMake(frameImagem.size.width*0.05, frameImagem.size.height*0.182, frameImagem.size.width * 0.895, frameImagem.size.height * 0.512)];
    
    [telaInfo setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    NSString *infoAplicacao = [composto.info_Composto objectForKey:@"Aplicacao"];
    
    NSString *infoObtencao = [composto.info_Composto objectForKey:@"Obtencao"];
    
    UIFont *boldFontName = [UIFont boldSystemFontOfSize:14];
    
    NSMutableAttributedString *formula = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Formula: %@\n\n",composto.formula_molecular]];
    
    [formula beginEditing];
    [formula addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 7)];
    [formula endEditing];
    
    
    NSMutableAttributedString *aplicacao = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Aplicação: %@\n\n",infoAplicacao]];
    
    [aplicacao beginEditing];
    [aplicacao addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 9)];
    [aplicacao endEditing];
    
    NSMutableAttributedString *obtencao = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Obtenção: %@",infoObtencao]];
    [obtencao beginEditing];
    [obtencao addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 8)];
    [obtencao endEditing];
    
    
    
    NSMutableAttributedString * textInfo =[[NSMutableAttributedString alloc]initWithAttributedString:formula];
    
    [textInfo appendAttributedString:aplicacao];
    [textInfo appendAttributedString:obtencao];
    
    [telaInfo setAttributedText:textInfo];
    
    [telaInfo setTextAlignment:NSTextAlignmentLeft];
    
    [telaInfo setEditable:NO];
    
    return telaInfo;
}

-(IBAction)fecharInfo:(id)sender{
    [self.infoElemento removeFromSuperview];
    [self.botaoFechar removeFromSuperview];
}




@end

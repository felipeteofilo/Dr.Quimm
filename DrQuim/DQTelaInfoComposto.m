//
//  DQTelaInfoComposto.m
//  DrQuim
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQTelaInfoComposto.h"

@implementation DQTelaInfoComposto

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho informacao:(NSDictionary*)info{
    
    [self setFrame:CGRectMake(posicao.x, posicao.y, tamanho.width *0.25, tamanho.height *0.4)];
    
    UIImageView *imagemFundo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"descript"]];
    
    [imagemFundo setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    UITextView * telaInfo = [[UITextView alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.05, imagemFundo.frame.size.height*0.182, imagemFundo.frame.size.width * 0.895, imagemFundo.frame.size.height * 0.512)];
    
    [telaInfo setBackgroundColor:[UIColor clearColor]];
    
   
    NSString * fomula = [NSString stringWithFormat:@"Formula: %@",@"H2O"];
    
    
    NSMutableAttributedString *formula = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Formula: %@",@"H2O"]];
    NSString *boldFontName = [[UIFont boldSystemFontOfSize:12] fontName];
    [formula beginEditing];
    [formula addAttribute:NSFontAttributeName value:boldFontName range:NSMakeRange(0, 6)];
    [formula endEditing];
   
    
    NSString * aplicacao = [NSString stringWithFormat:@"Aplicação: %@",@"pode ser aplicado nos mais variados tipos de coisas, mas a principal e nas pastas de dente"];
    
    NSString * obtencao =[NSString stringWithFormat:@"Obtenção: %@", @"pode ser obtido em qualquer lugar, masi e mais facil em rios e no mar hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhjjjdrtfghjgfdgjknhgfdsghjkhgfhjkgfhjkgfdhjgfdhjkgfhjgfhjgfhjkgfhjkhghjkhgfhjkgfhjgfghjgfghjkhgfdhjkgfghjgfdghjgfdhjkhgfdhjkhgfdghjkhgfdghjkhgfdghjkhgfdghjkhgfdfghjkhgfdghjkhgfdghjkhgfdghjkhgfdghjkhgfdghjkhgfdghjkhgfdfghjkhgfdrfghjkhgfdrfghjgftrftyhujkgfdghjkhgftdrfhjtdrftghjgfdghjnkhgfcgbhjn jvyfcgvbhjnmngvyftcgvyjnkhbgfctgvybhjnkmgf"];
    
    NSString * infor = [NSString stringWithFormat:@"%@\n\n%@\n\n%@",fomula,aplicacao,obtencao];
    
   [telaInfo setAttributedText:formula];
//    
//    telaInfo
//    
    [telaInfo setEditable:NO];
    
    UILabel *nome = [[UILabel alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.3, imagemFundo.frame.size.height*0.07, imagemFundo.frame.size.width*0.65, imagemFundo.frame.size.height*0.07)];
    
    nome.text = @"Componente";
    
    [nome setTextColor:[UIColor blueColor]];
    [nome setBackgroundColor:[UIColor greenColor]];
    
    
    [self addSubview:imagemFundo];
    [self addSubview:telaInfo];
    [self addSubview:nome];
    
    
    //[self setBackgroundColor:[UIColor blackColor]];
}

@end

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)colocarNaPosicao :(CGPoint)posicao tamanho:(CGSize)tamanho nomeComposto:(NSString*)nome{
    
    [self.view setFrame:CGRectMake(posicao.x, posicao.y, tamanho.width *0.25, tamanho.height *0.4)];
    
    UIImageView *imagemFundo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"descript"]];
    
    [imagemFundo setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    UITextView * telaInfo = [[UITextView alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.05, imagemFundo.frame.size.height*0.182, imagemFundo.frame.size.width * 0.895, imagemFundo.frame.size.height * 0.512)];
    
    [telaInfo setBackgroundColor:[UIColor clearColor]];
    
    
    Composto *composto = [DQCoreDataController procurarComposto:nome];
    
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
  
    [telaInfo setEditable:NO];
    
  //  UILabel *nomeComposto = [[UILabel alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.3, imagemFundo.frame.size.height*0.07, imagemFundo.frame.size.width*0.65, imagemFundo.frame.size.height*0.07)];
    
    MarqueeLabel *nomeComposto1 = [[MarqueeLabel alloc]initWithFrame:CGRectMake(imagemFundo.frame.size.width*0.3, imagemFundo.frame.size.height*0.07, imagemFundo.frame.size.width*0.65, imagemFundo.frame.size.height*0.07) duration:5 andFadeLength:10];
    
    nomeComposto1.text = nome;
    
    [nomeComposto1 setTextColor:[UIColor blueColor]];
    
    
    
    
    [self.view addSubview:imagemFundo];
    [self.view addSubview:telaInfo];
    [self.view addSubview:nomeComposto1];
    
    [self montarBotoesElementos:nil];
    //[self setBackgroundColor:[UIColor blackColor]];
}

-(void)montarBotoesElementos :(NSArray*)nomesElementos{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    UICollectionView *viewElementos = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.724, self.view.frame.size.width*0.9, self.view.frame.size.height*0.23)collectionViewLayout:layout];
    
    [viewElementos setDataSource:self];
    [viewElementos setDelegate:self];
     [viewElementos registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
   // [viewElementos ]
    
    
    [viewElementos setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:viewElementos];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    
//    [cell.
//    
//    
   return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}



@end

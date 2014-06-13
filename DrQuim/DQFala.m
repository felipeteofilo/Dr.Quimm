//
//  DQFala.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFala.h"

@implementation DQFala

//init com SUJEITO que fala e TEXTO do que fala
-(id)initComSujeito: (NSString *)sujeito_ Texto:(NSString *)texto_
{
    self = [super init];
    if(self)
    {
        self.sujeito = sujeito_;
        self.texto = texto_;
    }
    return self;
}

//Método de retorno VOID que mostra a fala na tela
-(void)desenhaNaTela
{
    //PARTE PARA DESENHAR O RETÂNGULO QUE CONTEM AS FALAS
    //Definindo variaveis para armazenar o tamanho da tela
        //limites de tamanho da tela
        CGRect telaLimites = [[UIScreen mainScreen] bounds];
        CGSize telaTamanho = telaLimites.size;
    
        //tamanho da largura
        CGFloat telaLargura = telaTamanho.height;
    
        //tamanho da altura
        CGFloat telaAltura = telaTamanho.width;
    //fim - Definindo variaveis para armazenar o tamanho da tela

    //Definindo o tamanho e localização do SKSpriteNode
        //define cor de fundo e o alpha
        self.color = [UIColor blackColor];
        self.alpha = 0.6f;
    
        //define a "âncora" do sprite para o canto inferior esquerdo
        self.anchorPoint = CGPointMake(0, 0);
    
        //define variaveis para armazenar localização
        CGFloat posicaoX = telaLargura * 0.1f; //10%
        CGFloat posicaoY = 0; //no canto inferior da tela
        CGFloat largura = telaLargura * 0.8f; //80%
        CGFloat altura = telaAltura * 0.25f; //25%
    
        //define o tamanho
        [self setSize:CGSizeMake(largura, altura)];
    
        //define a posicao
        [self setPosition:CGPointMake(posicaoX, posicaoY)];
    //fim - Definindo o tamanho e localização do SKSpriteNode

    
    
    //PARTE PARA DESENHAR O TEXTO DE FALA DENTRO DO RETÂNGULO
    SKLabelNode *textoFala = [[SKLabelNode alloc]init];
    [textoFala setColor:[UIColor whiteColor]];
    
    //adiciona o texto
    [textoFala setText:[NSString stringWithFormat:@"%@ : %@", self.sujeito, self.texto]];
    
    //define o alinhamento do texto
    [textoFala setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    
    //define a posicao
    [textoFala setPosition:CGPointMake(20, altura - 60)];
    
    //adiciona como filha
    [self addChild:textoFala];
     
}

@end

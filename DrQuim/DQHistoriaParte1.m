//
//  DQHistoriaParte1.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 13/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQHistoriaParte1.h"

@implementation DQHistoriaParte1

//Metodo que inicia a cena
-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.cenaAtual = 0;
        self.cutSceneControle = [[DQCutsceneControle alloc]initComParte:1];
        
        //Adiciona o novo fundo
        [self mostrarFundoAtual];
        //Adiciona o sprite da caixa de texto
        [self mostrarCaixaTexto];
        //Adiciona a fala atual
        [self mostrarFalaAtual];
    }
    return self;
}

-(void)mostrarFundoAtual
{
    self.fundo = [SKSpriteNode spriteNodeWithImageNamed:[[[self.cutSceneControle arrayCenas]objectAtIndex:self.cenaAtual] nomeDaImagem]];
    
    [self.fundo setAnchorPoint:CGPointMake(0, 0)];
    [self.fundo setSize:self.frame.size];
    [self addChild:self.fundo];
}

-(void)mostrarCaixaTexto
{
    self.caixaDeFala = [[SKSpriteNode alloc]initWithColor:[UIColor blackColor] size:CGSizeMake(self.frame.size.width * 0.8, self.frame.size.height * 0.25f)];
    self.caixaDeFala.alpha = 0.6f;
    
    //define a "âncora" do sprite para o canto inferior esquerdo
    self.caixaDeFala.anchorPoint = CGPointMake(0, 0);
    
    //define a posicao
    [self.caixaDeFala setPosition:CGPointMake(self.frame.size.width * 0.1f, 0)];
    
    //Adiciona como filha
    [self addChild:self.caixaDeFala];
}

-(void)mostrarFalaAtual
{
    self.fala = [[SKLabelNode alloc]init];
    [self.fala setColor:[UIColor whiteColor]];
    
    NSString *sujeitoTemporario = [NSString stringWithFormat:@"%@", [[[self.cutSceneControle arrayFalas]objectAtIndex:self.cenaAtual] sujeito]];
    NSString *textoTemporario = [NSString stringWithFormat:@"%@", [[[self.cutSceneControle arrayFalas]objectAtIndex:self.cenaAtual] texto]];
    
    //adiciona o texto
    [self.fala setText:[NSString stringWithFormat:@"%@ : %@",sujeitoTemporario, textoTemporario]];
    
    //define o alinhamento do texto
    [self.fala setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    
    //define a posicao
    [self.fala setPosition:CGPointMake(self.caixaDeFala.frame.origin.x + 20, self.caixaDeFala.frame.size.height - 60)];
    
    //adiciona como filha
    
    [self addChild:self.fala];
}

-(void)fimDasCenas
{
    //MUDAR DE CENA
    NSLog(@"E acabou!");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   if (self.cenaAtual == [self.cutSceneControle.arrayCenas count]-1) {
       //remove nós que serão alterados
       [self.fundo removeFromParent];
       [self.caixaDeFala removeFromParent];
       [self.fala removeFromParent];
       
       [self fimDasCenas];
   }
   else{
       NSLog(@"%i", self.cenaAtual);
       
       //Altera o que precisar
       self.cenaAtual += 1;
       
       //remove nós que serão alterados
       [self.fundo removeFromParent];
       [self.caixaDeFala removeFromParent];
       [self.fala removeFromParent];
       
       //Adiciona o novo fundo
       [self mostrarFundoAtual];
       //Adiciona o sprite da caixa de texto
       [self mostrarCaixaTexto];
       //Adiciona a fala atual
       [self mostrarFalaAtual];
   }
}

@end

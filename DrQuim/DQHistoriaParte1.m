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
        
        [self atualizaTela];
    }
    return self;
}

-(void)atualizaTela
{
    //NSStrings temporarias para armazenar o sujeito e fala atual
    NSString *sujeitoTemporario = [NSString stringWithFormat:@"%@", [[[self.cutSceneControle arrayFalas]objectAtIndex:self.cenaAtual] sujeito]];
    NSString *textoTemporario = [NSString stringWithFormat:@"%@", [[[self.cutSceneControle arrayFalas]objectAtIndex:self.cenaAtual] texto]];
    
    //NSString temporaria para armazenar o texto que será mostrado na tela já formatado
    NSString *textoFormatado;
    
    //BOOL que indica de tem texto na cutscene ou não
    BOOL *temTexto = NO;
    
    //Se existir uma fala, formata a fala
    if(![sujeitoTemporario isEqualToString:@""]){
        temTexto = YES;
        textoFormatado = [NSString stringWithFormat:@"%@: %@", sujeitoTemporario, textoTemporario];
    }
    
    //remove nós que não devem aparecer a tela
    [self.fundo removeFromParent];
    [self.caixaDeFala removeFromParent];
    [self.fala removeFromParent];
    
    //Adiciona o novo fundo
    [self mostrarFundoAtual];
    
    //Adiciona o sprite da CAIXA DE TEXTO e a FALA - SE tiver texto para colocar
    if(temTexto){
        [self mostrarCaixaTexto];
        [self mostrarFalaAtual:textoFormatado];
    }
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
    
    //Adiciona como filha - se tiver texto
    if(![[[[self.cutSceneControle arrayFalas]objectAtIndex:self.cenaAtual] sujeito] isEqual:@""]){
        [self addChild:self.caixaDeFala];
    }
}

-(void)mostrarFalaAtual:(NSString *)texto
{
    //Inicia o node
    self.fala = [[SKLabelNode alloc]init];
    [self.fala setColor:[UIColor whiteColor]];
    
    //adiciona o texto passado
    [self.fala setText:[NSString stringWithFormat:@"%@", texto]];
    
    //define o alinhamento do texto
    [self.fala setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    
    //define a posicao
    [self.fala setPosition:CGPointMake(self.caixaDeFala.frame.origin.x + 20, self.caixaDeFala.frame.size.height - 60)];
    
    //adiciona como filha
    [self addChild:self.fala];
}

-(void)trocarCena
{
    if (self.cenaAtual == [self.cutSceneControle.arrayCenas count]-1) {
        [self fimDasCenas];
    }
    else{
        //Altera o que precisar
        self.cenaAtual += 1;
        
        //Atualiza a tela
        [self atualizaTela];
    }
}

-(void)fimDasCenas
{
    //remove nós que não devem aparecer a tela
    [self.fundo removeFromParent];
    [self.caixaDeFala removeFromParent];
    [self.fala removeFromParent];
    
    //MUDAR DE CENA
    NSLog(@"E acabou!");
    
    SKScene *cenaNova = [[DQFlorestaParte1 alloc]initWithSize:self.frame.size];
    SKTransition *transicao = [SKTransition crossFadeWithDuration:0.5f];
    [self.view presentScene:cenaNova transition:transicao];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self trocarCena];
}

@end

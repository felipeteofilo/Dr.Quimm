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
    BOOL temTexto = NO;
    
    //Se existir uma fala, formata a fala
    if(![sujeitoTemporario isEqualToString:@""]){
        temTexto = YES;
        textoFormatado = [NSString stringWithFormat:@"%@: %@", sujeitoTemporario, textoTemporario];
    }
    
    //NSArray que irá conter o textoFormatado cortado em frases
    NSArray *frases = [self separarTextoEmFrasesPassandoTexto:textoFormatado eComprimentoFrase:50];
    
    //remove nós que não devem aparecer a tela
    [self.fundo removeFromParent];
    [self.caixaDeFala removeFromParent];
    for(int i = 0; i < [self.arrayDefalasEmFrases count]; i++){
        [[self.arrayDefalasEmFrases objectAtIndex:i] removeFromParent];
    }
    
    //Adiciona o novo fundo
    [self mostrarFundoAtual];
    
    //Adiciona o sprite da CAIXA DE TEXTO e a FALA - SE tiver texto para colocar
    if(temTexto){
        [self mostrarCaixaTexto];
        [self mostrarFalaAtual:frases];
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


//funcao que retorna a caixa de texto para ser mostrada dentro do jogo
-(SKSpriteNode*)mostrarCaixaTextoNoJogo{
    SKSpriteNode *caixaDeFala = [[SKSpriteNode alloc]initWithColor:[UIColor blackColor] size:CGSizeMake(self.frame.size.width * 0.8, self.frame.size.height * 0.25f)];
    caixaDeFala.alpha = 0.6f;
    
    caixaDeFala.anchorPoint = CGPointMake(0, 0);
    
    [caixaDeFala setPosition:CGPointMake(self.frame.size.width * 0.1f, self.frame.size.height * 0.1f)];
    
    return caixaDeFala;
}


//funcao a fazer de mostrar as falas dentro do jogo
//-(void)mostrarFalaNoJogo Scene:(SKScene*)cena{
//    
//    
//    
//    
//    
//}

-(void)mostrarFalaAtual:(NSArray *)frases
{
    //Inicia o array de falas que conterá os nodes
    self.arrayDefalasEmFrases = [[NSMutableArray alloc]init];
    
    //Variaveis que contém as coordenadas das primeira fala e o espaço entre elas
    CGFloat posicaoX = self.caixaDeFala.frame.origin.x + 20;
    CGFloat posicaoY = self.caixaDeFala.frame.origin.y + 150;
    CGFloat distancia = 40;
    
    //cria um NSArray de irá armazenar as falas
    for(int i = 0; i < [frases count]; i++){
        //cria a fala com cor, posição, alinhamento e texto
        SKLabelNode *fala = [[SKLabelNode alloc] init];
        [fala setColor:[UIColor whiteColor]];
        [fala setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
        [fala setPosition:CGPointMake(posicaoX, posicaoY - (distancia * i))];
        [fala setText:[frases objectAtIndex:i]];
        
        //adiciona ao array
        [self.arrayDefalasEmFrases addObject:fala];
    }
    
    //Adicona as falas na tela
    for(int i = 0; i < [self.arrayDefalasEmFrases count]; i++){
        NSLog(@"%@", [[self.arrayDefalasEmFrases objectAtIndex:i]text]);
        [self addChild:[self.arrayDefalasEmFrases objectAtIndex:i]];
    }
}

-(NSArray *)separarTextoEmFrasesPassandoTexto: (NSString *)texto eComprimentoFrase:(int)comprimentoFrase
{
    NSArray *arrayDePalavras = [texto componentsSeparatedByString:@" "];
    NSMutableArray *arrayDeFrases = [[NSMutableArray alloc]init];
    
    NSString *palavraAtual = @"";
    NSString *fraseAtual = @"";
    
    //Laço passando por todas as palavras
    for(int i = 0; i < [arrayDePalavras count]; i++){
        
        //armazena a palavra da vez
        palavraAtual = [arrayDePalavras objectAtIndex:i];

        //Se o tamanho da palavra atual + tamanho da frase atual + 1 for maior que o comprimento passado
        if([palavraAtual length] + [fraseAtual length] + 1 > comprimentoFrase){
            //passa a fraseAtual para o array de frases e zera a fraseAtual
            [arrayDeFrases addObject:fraseAtual];
            fraseAtual = @"";
            
            //adiciona a palavra na nova frase
            fraseAtual = palavraAtual;
        } else{
            fraseAtual = [NSString stringWithFormat:@"%@ %@", fraseAtual, palavraAtual];
        }
    }
    
    [arrayDeFrases addObject:fraseAtual];
    
    //retorna o array com as frases
    return arrayDeFrases;
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
    for(int i = 0; i < [self.arrayDefalasEmFrases count]; i++){
        [[self.arrayDefalasEmFrases objectAtIndex:i] removeFromParent];
    }
    
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

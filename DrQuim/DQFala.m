//
//  DQFala.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 09/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQFala.h"

@implementation DQFala

//inicia o SKSpriteNode com seu tamanho e cor
-(id)initComDicionario: (NSDictionary *)dicionarioDaFala eTamanho:(CGSize)tamanho{
    if (self = [super initWithColor:[UIColor blackColor] size:CGSizeMake(tamanho.width * 0.8, tamanho.height * 0.25f)]) {
        //inicia as variaveis auxiliares
        self.sujeito = [[NSString alloc]init];
        self.texto = [[NSString alloc]init];
        self.foto = [[NSString alloc]init];
        
        //coloca os valores pegos do dicionario de fala nas variaveis auxiliares
        self.sujeito = [dicionarioDaFala objectForKey:@"Sujeito"];
        self.texto = [dicionarioDaFala objectForKey:@"Texto"];
        self.foto = [dicionarioDaFala objectForKey:@"Foto"];
        
        //inicia as variaveis de tamanho de texto
        self.tamanhoTextoComFoto = CGSizeMake(self.frame.size.width * 0.7, self.frame.size.height * 0.8);
        self.tamanhoTextoSemFoto = CGSizeMake(self.frame.size.width * 0.8, self.frame.size.height * 0.8);

        //inicia as variaveis de posicao de texto
        self.posicaoTextoComFoto = CGSizeMake(self.frame.size.width * 0.25, self.frame.size.height * 0.12);
        self.posicaoTextoSemFoto = CGSizeMake(self.frame.size.width * 0.8, self.frame.size.height * 0.8);
        
        
        //VERIFICA SE TEM FOTO
        //se tem...
        if(self.foto != nil){
            //o tamamho do texto é o com foto
            self.tamanhoTexto = self.tamanhoTextoComFoto;
            self.posicaoTexto = self.posicaoTextoComFoto;
            
            //chama a classe de foto
            [self criarFoto];
        }
        //se não tem...
        else{
            //o tamanho do texto é sem a foto
            self.tamanhoTexto = self.tamanhoTextoSemFoto;
            self.posicaoTexto = self.posicaoTextoSemFoto;
        }
        
        //cria o aviso
        [self criarAviso];
        
        //cria o texto
        [self criarTexto];
    }
    return self;
}

//cria a foto e a adiciona
-(void)criarFoto
{
    //cria o SKSpriteNode com a imagem da foto
    SKSpriteNode *spriteFoto = [[SKSpriteNode alloc]initWithImageNamed:self.foto];
    
    //define tamanho
    CGFloat lado = self.frame.size.height * 0.8; //o tamanho do quadrado da foto será 80% o tamanho da caixa
    [spriteFoto setSize:CGSizeMake(lado, lado)];
    
    //define a posição
    CGFloat espacamento = self.frame.size.height * 0.1; //o espaçamento (entre a foto e as "paredes") será 10% o tamanho da caixa
    [spriteFoto setAnchorPoint:CGPointMake(0, 0)];
    [spriteFoto setPosition:CGPointMake(espacamento, espacamento)];
    
    //adiciona a foto no SKSpriteNode principal - caixa
    [self addChild:spriteFoto];
}

//cria o aviso de "toque para continuar" e o adiciona
-(void)criarAviso
{
    //cria e define texto, cor, fonte, alinhamento e posição
    SKLabelNode *aviso = [[SKLabelNode alloc]init];
    [aviso setText:@"[Toque para continuar]"];
    [aviso setFontColor:[UIColor yellowColor]];
    [aviso setFontSize:25.0f];
    [aviso setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeRight];
    [aviso setPosition:CGPointMake(self.frame.size.width * 0.98, self.frame.size.height * 0.1)];
    
    //Adiciona o aviso no SKSpriteNode principal - caixa
    [self addChild:aviso];
    
    //FAZENDO ANIMAÇÃO
    //Ação para ficar piscando
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.8f];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.8f];
    SKAction *piscar = [SKAction sequence:@[fadeIn, fadeOut]];

    //Fica repetindo a ação
    [aviso runAction:[SKAction repeatActionForever:piscar] withKey:@"textoPiscando"];
}

//cria o texto e o adiciona
-(void)criarTexto
{
    DQTexto *texto = [[DQTexto alloc]initTexto:self.texto espacoLimite:self.tamanhoTexto fonte:25];
    
    [texto setPosition:CGPointMake(self.posicaoTexto.width + texto.frame.size.width/2, self.posicaoTexto.height + texto.frame.size.height/2)];
    
    
    [texto mudaCorTexto:[UIColor whiteColor]];
    [self addChild:texto];
    
    
}

//...
//TEMPORÁRIO - APENAS PARA NÃO DAR ERRO
-(id)initComSujeito:sujeitoTemporario Texto:textoTemporario
{
    if (self = [super init]) {}
    return self;
}

@end

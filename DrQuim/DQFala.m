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
-(id)initComDicionario: (NSDictionary *)dicionarioDaFala{
    if (self = [super initWithColor:[UIColor blackColor] size:CGSizeMake(self.scene.frame.size.width * 0.8, self.scene.frame.size.height * 0.25f)]) {
        //inicia as variaveis auxiliares
        self.sujeito = [[NSString alloc]init];
        self.texto = [[NSString alloc]init];
        self.foto = [[NSString alloc]init];
        
        //coloca os valores pegos do dicionario de fala nas variaveis auxiliares
        self.sujeito = [dicionarioDaFala objectForKey:@"Sujeito"];
        self.texto = [dicionarioDaFala objectForKey:@"Texto"];
        self.foto = [dicionarioDaFala objectForKey:@"Foto"];
        
        //inicia as variaveis de tamanho de texto
        self.tamanhoTextoComFoto = CGSizeMake(self.frame.size.width * 0.6, self.frame.size.height * 0.8);
        self.tamanhoTextoSemFoto = CGSizeMake(self.frame.size.width * 0.8, self.frame.size.height * 0.8);
        
        //VERIFICA SE TEM FOTO
        //se tem...
        if(self.foto != nil){
            //o tamamho do texto é o com foto
            self.tamanhoTexto = self.tamanhoTextoComFoto;
            
            //chama a classe de foto
            [self criarFoto];
        }
        //se não tem...
        else{
            //o tamanho do texto é sem a foto
            self.tamanhoTexto = self.tamanhoTextoSemFoto;
        }
        
        

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

//cria o texto e o adiciona
-(void)criarTexto
{
    
}

//cria o aviso de "toque para continuar" e o adiciona
-(void)criarAviso
{
    
}

//Limita o texto de acordo com o tamanho da "caixa" que irá recebê-lo
-(void)configurarLimitesTexto
{
    
}


//...
//TEMPORÁRIO - APENAS PARA NÃO DAR ERRO
-(id)initComSujeito:sujeitoTemporario Texto:textoTemporario
{
    if (self = [super init]) {}
    return self;
}

@end

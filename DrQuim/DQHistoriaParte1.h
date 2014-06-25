//
//  DQHistoriaParte1.h
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 13/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DQCutsceneControle.h"
#import "DQFlorestaParte1.h"

@interface DQHistoriaParte1 : SKScene

@property int cenaAtual;
@property DQCutsceneControle *cutSceneControle;

@property SKSpriteNode *fundo;
@property SKSpriteNode *caixaDeFala;
@property NSMutableArray *arrayDefalasEmFrases;
@property NSArray *falasAtuais;
@property int falaAtual;


//Método usado para desenhar os dados na tela (apaga os nós anteriores e insere os novos)
-(void)atualizaTela;

//Método usado para separar um texto passado em frases que caibam no quadrado separado a elas.
-(NSArray *)separarTextoEmFrasesPassandoTexto: (NSString *)texto eComprimentoFrase:(int)comprimentoFrase;

//Métodos usados para mostrar os diferentes nós que estão compondo a cena
-(void)mostrarFundoAtual;
-(void)mostrarCaixaTexto;
-(void)mostrarFalaAtual:(NSArray *)frases;

//Método usado para trocar uma cena para outra
-(void)trocarCena;

//Método usado no final
-(void)fimDasCenas;

@end

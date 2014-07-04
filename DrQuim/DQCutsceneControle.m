//
//  DQCutsceneView.m
//  DrQuim
//
//  Created by Júlia Yamamoto on 10/06/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQCutsceneControle.h"

@implementation DQCutsceneControle


//Metodo para iniciar a classe Cutscene
-(id)initComParte:(int)parte_ Fase :(int)fase
{
    self = [super init];
    if (self) {
        
        //Cria uma string que contem o caminho (path) do arquivo plist de falas
        self.plistFalaPath = [[NSBundle mainBundle] pathForResource:@"Falas" ofType:@"plist"];
        //Cria um NSArray com o conteudo da pList.
        self.arrayDeFalasPLists = [[NSArray alloc]initWithContentsOfFile:self.plistFalaPath];
        
        
        //Cria uma string com o caminho do arquivo plist de Falas In Game
        NSString *urlFalasDoJogo = [[NSBundle mainBundle] pathForResource:@"FalasDoJogo" ofType:@"plist"];
        //Cria um NSArray com as Falas In Game
        self.arrayFalasDentroDoJogo = [[NSArray alloc]initWithContentsOfFile:urlFalasDoJogo];
        
        
        //define a parte, fase atual, e cena.
        self.parte = parte_;
        self.faseAtual = fase;
        self.cenaAtual = 0;
        self.falaAtual = 0;
        
        //inicia a parte dependendo do numero passado como parte
        [self iniciaFalas];
    }
    return self;
}


//Metodo para iniciar uma cutscene
-(void)iniciarCutscene :(SKScene*)cena Seletor:(SEL)seletor{
    //seta a SKscene que ela ira controlar , o seletor para iniciar a fase e comeca a exibir a cutscene
    self.cutscene = cena;
    self.iniciarGameplay = seletor;
    [self atualizaTela];
}


//Metodo para iniciar as falas
-(void)iniciaFalas
{
    //Aloca o arrayCutScene - Ele irá guardar os dicionarios da parte passada por parâmetro
    self.arrayCutscenes = [[NSArray alloc]init];
    self.arrayCutscenes = [self.arrayDeFalasPLists objectAtIndex:(self.parte-1)];
    
    
    //Aloca o NSMutableDictionary - Ele ira armazenar as falas da fase Atual
    self.falasDoJogo = [[NSMutableDictionary alloc]init];
    self.falasDoJogo = [[self.arrayFalasDentroDoJogo objectAtIndex:(self.faseAtual-1)]objectForKey:@"Falas"];
    
    //Aloca os arrays de FALA e CENA
    self.arrayFalas = [[NSMutableArray alloc]init];
    self.arrayCenas = [[NSMutableArray alloc]init];
    
    //Instanciando as falas e cenas
    for(int i = 0; i < [self.arrayCutscenes count]; i++){
        //NSStrings temporárias
        NSString *sujeitoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Sujeito"]];
        NSString *textoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Texto"]];
        NSString *fundoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayCutscenes objectAtIndex:i] objectForKey:@"Fundo"]];
        
        //FALA e CENA - Instancias
        //objeto de fala que será, posteriormente, colocada no array definitivo de falas.
        DQFala *falaTemporaria;
        //objeto de cena que será, posteriormente, colocada no array definitivo de cenas.
        DQCena *cenaTemporaria;
        
        //FALA e CENA - Conteúdo
        //inicia o objeto temporário de fala com as informações adquiridas
        falaTemporaria = [[DQFala alloc]initComSujeito:sujeitoTemporario Texto:textoTemporario];
        //inicia o objeto temporário de cena com as informações adquiridas
        cenaTemporaria = [[DQCena alloc]initComNomeDaImagem:fundoTemporario];
        
        //FALA e CENA - Adiciona as temporárias
        [self.arrayFalas addObject:falaTemporaria];
        [self.arrayCenas addObject:cenaTemporaria];
    }
}


//Metodo para atualizar a tela em uma cutscene
-(void)atualizaTela
{
    //NSStrings temporarias para armazenar o sujeito e fala atual
    NSString *sujeitoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayFalas objectAtIndex:self.cenaAtual]sujeito]];
    NSString *textoTemporario = [NSString stringWithFormat:@"%@", [[self.arrayFalas objectAtIndex:self.cenaAtual]texto]];
    
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
    [self.cutscene removeAllChildren];
    
    //Adiciona o novo fundo
    [self mostrarFundoAtual];
    
    //Adiciona o sprite da CAIXA DE TEXTO e a FALA - SE tiver texto para colocar
    if(temTexto){
        [self mostrarCaixaTexto];
        [self mostrarFalaAtual:frases];
    }
    
    //Adicionar o "Toque para continuar"
    [self mostrarInstrucao];
}

-(void)mostrarInstrucao
{
    self.instrucao = [[SKLabelNode alloc]init];
    [self.instrucao setText:@"[Toque para continuar]"];
    [self.instrucao setFontColor:[UIColor yellowColor]];
    [self.instrucao setFontSize:25.0f];
    [self.instrucao setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self.instrucao setPosition:CGPointMake(self.cutscene.frame.size.width * 0.65f , 0+20)];
    
    [self.cutscene addChild:self.instrucao];
    
    //Ação para ficar piscando
    SKAction *fadeIn = [SKAction fadeInWithDuration:1.0f];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0f];
    SKAction *piscar = [SKAction sequence:@[fadeIn, fadeOut]];
    
    //Fica repetindo a ação
    [self.instrucao runAction:[SKAction repeatActionForever:piscar] withKey:@"textoPiscando"];
}

//Metodo para separar o texto em frases
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

//Mostra a falas
-(void)mostrarFalaAtual:(NSArray *)frases
{
    //Inicia o array de falas que conterá os nodes
    self.arrayDefalasEmFrases = [[NSMutableArray alloc]init];
    
    //Variavel que contém o espaço entre as falas
    CGFloat distancia = 40;
    
    //cria um NSArray de irá armazenar as falas
    for(int i = 0; i < [frases count]; i++){
        //cria a fala com cor, posição, alinhamento e texto
        SKLabelNode *fala = [[SKLabelNode alloc] init];
        [fala setColor:[UIColor whiteColor]];
        [fala setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
        [fala setPosition:CGPointMake(40, 150 - (distancia * i))];
        [fala setText:[frases objectAtIndex:i]];
        
        //adiciona ao array
        [self.arrayDefalasEmFrases addObject:fala];
    }
    
    //Adicona as falas na tela
    for(int i = 0; i < [self.arrayDefalasEmFrases count]; i++){
        [self.caixaDeFala addChild:[self.arrayDefalasEmFrases objectAtIndex:i]];
    }
}

//Mostra a falas do jogo
-(void)mostrarFalaAtualNoJogo:(NSArray *)frases
{
    //Inicia o array de falas que conterá os nodes
    self.arrayDefalasEmFrases = [[NSMutableArray alloc]init];
    
    //Variavel que contém o espaço entre as falas
    CGFloat distancia = 40;
    
    //cria um NSArray de irá armazenar as falas
    for(int i = 0; i < [frases count]; i++){
        //cria a fala com cor, posição, alinhamento e texto
        SKLabelNode *fala = [[SKLabelNode alloc] init];
        [fala setColor:[UIColor whiteColor]];
        [fala setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
        [fala setPosition:CGPointMake(190, 150 - (distancia * i))];
        [fala setText:[frases objectAtIndex:i]];
        
        //adiciona ao array
        [self.arrayDefalasEmFrases addObject:fala];
    }
    
    //Adicona as falas na tela
    for(int i = 0; i < [self.arrayDefalasEmFrases count]; i++){
        [self.caixaDeFala addChild:[self.arrayDefalasEmFrases objectAtIndex:i]];
    }
}

//Mostra o fundo em uma cutscene
-(void)mostrarFundoAtual
{
    //cria o fundo de acordo com o arquivo da pList de cutscenes
    self.fundo = [SKSpriteNode spriteNodeWithImageNamed:[[self.arrayCenas objectAtIndex:self.cenaAtual] nomeDaImagem]];
    
    [self.fundo setAnchorPoint:CGPointMake(0, 0)];
    [self.fundo setSize:self.cutscene.frame.size];
    [self.cutscene addChild:self.fundo];
}


//Mostrar caixa texto em uma cutscene
-(void)mostrarCaixaTexto
{
    self.caixaDeFala = [[SKSpriteNode alloc]initWithColor:[UIColor blackColor] size:CGSizeMake(self.cutscene.frame.size.width * 0.8, self.cutscene.frame.size.height * 0.25f)];
    NSLog(@"%0.0f", self.cutscene.frame.size.height * 0.25f);
    self.caixaDeFala.alpha = 0.6f;
    
    //define a "âncora" do sprite para o canto inferior esquerdo
    self.caixaDeFala.anchorPoint = CGPointMake(0, 0);
    
    //define a posicao
    [self.caixaDeFala setPosition:CGPointMake(self.cutscene.frame.size.width * 0.1f, 0)];
    
    //Adiciona como filha - se tiver texto
    if(![[[self.arrayFalas objectAtIndex:self.cenaAtual] sujeito] isEqual:@""]){
        [self.cutscene addChild:self.caixaDeFala];
    }
}

//funcao que retorna a caixa de texto para ser mostrada dentro do jogo
-(SKSpriteNode*)mostrarCaixaTextoNoJogo :(SKScene*)cena{
    
    //Cria a caixa de texto localizada na parte superior
    SKSpriteNode *caixaDeFala = [[SKSpriteNode alloc]initWithColor:[UIColor blackColor] size:CGSizeMake(cena.frame.size.width * 0.8, cena.frame.size.height * 0.25f)];
    caixaDeFala.alpha = 0.6f;
    caixaDeFala.anchorPoint = CGPointMake(0, 0);
    [caixaDeFala setPosition:CGPointMake(cena.frame.size.width * 0.1f, cena.frame.size.height *0.7)];
    
    return caixaDeFala;
}

//Método para mostrar o rosto do sujeito
-(void)mostraRostoDeQuemFala: (NSString *)imagem naCena: cena
{
    self.rosto = [[SKSpriteNode alloc] initWithImageNamed:imagem];
    [self.rosto setSize:CGSizeMake(150, 150)];
    [self.rosto setAnchorPoint:CGPointMake(0, 0)];
    [self.rosto setPosition:CGPointMake(20, 20)];
    [self.caixaDeFala addChild:self.rosto];
}

///Metodo a fazer de mostrar as falas dentro do jogo
-(void)mostrarFalaNoJogo :(SKScene*)cena KeyDaFala:(NSString*)key{
    //Verifica se ha alguma fala em andamento, se nao lemos uma pela key passada
    if (self.falasAtuais == nil) {
        self.falasAtuais = [[NSArray alloc]init];
        self.falasAtuais = [self.falasDoJogo objectForKey:key];
    }

    [self.caixaDeFala removeAllChildren];
    
    //NSStrings temporarias para armazenar o sujeito e fala atual
    NSString *sujeitoTemporario = [[self.falasAtuais objectAtIndex:self.falaAtual]objectForKey:@"Sujeito"];
    NSString *textoTemporario = [[self.falasAtuais objectAtIndex:self.falaAtual]objectForKey:@"Texto"];
    
    //Formata o texto lido do Arquivo Plist
    NSString *textoFormatado = [NSString stringWithFormat:@"%@: %@", sujeitoTemporario, textoTemporario];
    
    //Separa o texto em frases
    NSArray *frases = [self separarTextoEmFrasesPassandoTexto:textoFormatado eComprimentoFrase:40];
    
    //Cria a caixa de texto
    self.caixaDeFala = [self mostrarCaixaTextoNoJogo:cena];
    
    //Mostra as falas
    [self mostrarFalaAtualNoJogo:frases];
    
    //Adiciona a caixa de fala no jogo
    [cena addChild:self.caixaDeFala];
    
    //Adiciona uma imagem com a carinha de quem está falando
    [self mostraRostoDeQuemFala:[[self.falasAtuais objectAtIndex:self.falaAtual] objectForKey:@"Imagem"] naCena:cena];
    
    //Pula para a proxima fala
    self.falaAtual ++;
}

//Trocar fala dentro do jogo
-(BOOL)trocarFala{
    if (self.falaAtual < self.falasAtuais.count) {
        [self.caixaDeFala removeFromParent];
        return true;
    }
    else{
        self.falasAtuais = nil;
        self.falaAtual = 0;
        [self.caixaDeFala removeAllChildren];
        [self.caixaDeFala removeFromParent];
        //[self.rosto removeFromParent];
        return false;
    }
}

//Troca cena da cutscene
-(void)trocarCena
{
    if (self.cenaAtual == [self.arrayCenas count]-1) {
        [self fimDasCenas];
    }
    else{
        //Altera o que precisar
        self.cenaAtual += 1;
        
        //Atualiza a tela
        [self atualizaTela];
    }
}

//Se for fim da cutscene inicia a fase
-(void)fimDasCenas
{
    //remove nós que não devem aparecer a tela
    [self.fundo removeFromParent];
    [self.caixaDeFala removeFromParent];
    [self.instrucao removeFromParent];
    for(int i = 0; i < [self.arrayDefalasEmFrases count]; i++){
        [[self.arrayDefalasEmFrases objectAtIndex:i] removeFromParent];
    }
    if ([self.cutscene respondsToSelector:self.iniciarGameplay]) {
        [self.cutscene performSelector:self.iniciarGameplay];
    }
}



@end

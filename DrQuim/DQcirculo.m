//
//  UIControl+DQcirculo.m
//  DrQuim
//
//  Created by JULIA ARISSA COPPOLA YAMAMOTO on 17/11/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "DQcirculo.h"


static float anguloDelta;
static float alphaMinimo = 0.6;
static float alphaMaximo = 1.0;

@implementation DQcirculo

-(id)initComFrame: (CGRect)frame comDelegate:(id)del comNumeroDeCompostos:(int)numeroDeCompostos eCompostos:(NSArray *)arrayDeCompostos
{
    if(self = [super initWithFrame:frame]){
        self.arrayDeCompostos = [[NSArray alloc]initWithArray:arrayDeCompostos];
        self.tagImagemSelecionada = 0;
        
        self.compostoAtual = 0;
        self.numeroDeCompostos = numeroDeCompostos;
        self.delegate = del;
        
        [self desenharCirculo];
        
    }
    return self;
}

//METODOS PARA DESENHO - INICIO
-(void)desenharCirculo
{
    self.base = [[UIView alloc] initWithFrame:self.frame];
    CGFloat tamanhoAngulo = 2 * M_PI / self.numeroDeCompostos;
    
    for(int i = 0; i < self.numeroDeCompostos; i++){
        
        Composto * composto = [DQCoreDataController procurarComposto:[self.arrayDeCompostos objectAtIndex:i]];
        
        DQComposto * areaComposto = [[DQComposto alloc]initComEntidadeComposto:composto :CGRectMake(self.base.bounds.size.width/2, self.base.bounds.size.height/2, self.base.bounds.size.height * 0.5f, self.base.bounds.size.height * 0.5f)];
        areaComposto.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
        areaComposto.contentMode = UIViewContentModeScaleAspectFit;
        areaComposto.layer.position = CGPointMake(self.base.bounds.size.width/2 - self.base.frame.origin.x, self.base.bounds.size.height/2 - self.base.frame.origin.y);
        areaComposto.transform = CGAffineTransformMakeRotation(tamanhoAngulo * i);
        areaComposto.alpha = alphaMinimo; //???
        areaComposto.tag = i;
        
        [self.base addSubview:areaComposto];
    }
    self.base.userInteractionEnabled = NO;
    [self criarFundoNormal];
    [self criarFundoTransparente];
    [self addSubview:self.base];
    
    self.arrayDeCompostosDesenho = [NSMutableArray arrayWithCapacity:self.numeroDeCompostos];
    
    if(self.numeroDeCompostos %2 == 0) { [self desenharCirculoPar]; }
    else { [self desenharCirculoImpar]; }
    
    
    
    //[self.delegate mudouDeValor:[self pegarNomeComposto:self.compostoAtual]]; //???
}

-(void)desenharCirculoPar
{
    CGFloat largura = M_PI * 2 / self.numeroDeCompostos;
    CGFloat meio = 0;
    
    for(int i = 0; i < self.numeroDeCompostos; i++){
        DQCirculoComposto *compostoDesenho = [[DQCirculoComposto alloc]init];
        compostoDesenho.valorMediano = meio;
        compostoDesenho.valorMinimo = meio - (largura/2);
        compostoDesenho.valorMaximo = meio + (largura/2);
        compostoDesenho.valor = i;
        
        if(compostoDesenho.valorMaximo - largura < -M_PI){
            meio = M_PI;
            compostoDesenho.valorMediano = meio;
            compostoDesenho.valorMediano = fabsf(compostoDesenho.valorMaximo);
        }
        
        meio -= largura;
        [self.arrayDeCompostosDesenho addObject:compostoDesenho];
    }
}

-(void)desenharCirculoImpar
{
    CGFloat largura = M_PI * 2 / self.numeroDeCompostos;
    CGFloat meio = 0;
    
    for(int i = 0; i < self.numeroDeCompostos; i++){
        DQCirculoComposto *compostoDesenho = [[DQCirculoComposto alloc]init];
        compostoDesenho.valorMediano = meio;
        compostoDesenho.valorMinimo = meio - (largura/2);
        compostoDesenho.valorMaximo = meio + (largura/2);
        compostoDesenho.valor = i;
        meio -= largura;
        
        if(compostoDesenho.valorMaximo - largura < -M_PI){
            meio = -meio;
            meio -= largura;
        }
        
        [self.arrayDeCompostosDesenho addObject:compostoDesenho];
    }
}

-(void)criarFundoNormal{
    UIImageView *imagemFundo = [[UIImageView alloc]initWithFrame:self.base.frame];
    [imagemFundo setImage:[UIImage imageNamed:@"fundo"]];
    [imagemFundo.layer setZPosition:-100];
    imagemFundo.tag = 1000;
    [self.base addSubview:imagemFundo];
}

-(void)criarFundoTransparente{
    UIImageView *imagemFundo = [[UIImageView alloc]initWithFrame:self.base.frame];
    [imagemFundo setImage:[UIImage imageNamed:@"fundoTransparente"]];
    [imagemFundo.layer setZPosition:100];
    imagemFundo.tag = 1000;
    [self addSubview:imagemFundo];
}
//METODOS PARA DESENHO - FIM


//METODOS PARA GIRAR - INICIO
-(float)calculaDistanciaDoCentro:(CGPoint)ponto
{
    CGPoint centro = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = ponto.x - centro.x;
    float dy = ponto.y - centro.y;
    return sqrt(dx*dx + dy*dy);
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pontoDeToque = [touch locationInView:self];
    float distancia = [self calculaDistanciaDoCentro:pontoDeToque];
    
    if(distancia < self.base.frame.size.height * 0.1f || distancia > self.base.frame.size.height){
        return NO;
    }
    
    float dx = pontoDeToque.x - self.base.center.x;
    float dy = pontoDeToque.y - self.base.center.y;
    anguloDelta = atan2(dy, dx);
    
    self.iniciaTransformacao = self.base.transform;
    
    UIImageView *imagem = [self pegarNomeCompostoPeloValor:self.compostoAtual];
    if(imagem.tag != 1000){
        imagem.alpha = alphaMinimo;
    }
    
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pontoDeToque = [touch locationInView:self];
    
    float dx = pontoDeToque.x  - self.base.center.x;
    float dy = pontoDeToque.y  - self.base.center.y;
    float angulo = atan2(dy,dx);
    
    float diferencaDoAngulo = anguloDelta - angulo;
    self.base.transform = CGAffineTransformRotate(self.iniciaTransformacao, -diferencaDoAngulo);
    
    UIImageView *imagem = [self pegarNomeCompostoPeloValor:self.compostoAtual];
    imagem.alpha = alphaMinimo;
    
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGFloat radianos = atan2f(self.base.transform.b, self.base.transform.a);
    CGFloat novoValor = 0.0;
    
    for(DQCirculoComposto *composto in self.arrayDeCompostosDesenho){
        if(composto.valorMinimo > 0 && composto.valorMaximo < 0){
            if(composto.valorMaximo > radianos || composto.valorMinimo < radianos){
                if(radianos > 0){ novoValor = radianos - M_PI; }
                else{ novoValor = M_PI + radianos; }
            }
        }
        else if(radianos > composto.valorMinimo && radianos < composto.valorMaximo){
            novoValor = radianos - composto.valorMediano;
            self.compostoAtual = composto.valor;
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    
    CGAffineTransform t = CGAffineTransformRotate(self.base.transform, -novoValor);
    self.base.transform = t;
    
    [UIView commitAnimations];
    
    UIImageView *imagem = [self pegarNomeCompostoPeloValor:self.compostoAtual];
    
    DQComposto *composto = (DQComposto*)imagem;
    [self.infoComposto atualizarInfoComposto:composto.nome];
    
    
    if(touch.tapCount > 1){
        
        [self.mix adicionarComposto:composto.nome];
    }
    
    
    imagem.alpha = alphaMaximo;
}

-(void)mostrarInfoComposto{
    self.infoComposto = [[DQTelaInfoComposto alloc]init];
    
    UIImageView *imagem = [self pegarNomeCompostoPeloValor:self.compostoAtual];
    
    DQComposto *composto = (DQComposto*)imagem;
    [self.superview addSubview:self.infoComposto.view];
    [self.infoComposto colocarNaPosicao:CGPointMake(self.superview.bounds.size.width *0.7, 0) tamanho:self.superview.bounds.size nomeComposto:composto.nome];
    
    self.infoComposto.view.tag = 100;
    
    self.mix = [[DQViewCompostosMix alloc]initComTamanho:self.superview.bounds];
    
    
    [self.superview addSubview:self.mix];
    
    [self.mix mostrarBotaoMix];

   
}


//METODOS PARA GIRAR - FIM

-(NSString *)pegarNomeComposto:(int)posicao{
    NSString *nome = [NSString stringWithFormat:@"%@", [self.arrayDeCompostos objectAtIndex:posicao]];
    return nome;
}
-(UIImageView*)pegarNomeCompostoPeloValor:(int)valor{
    UIImageView *imagem;
    NSArray *views = [self.base subviews];
    for(UIImageView *img in views){
        if(img.tag == valor) {
            imagem = img;
        }
    }
    return imagem;
}

@end

//
//  ViewController.m
//  NSthreadLoadImage
//
//  Created by hoyi on 9/22/15.
//  Copyright (c) 2015 hoyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

    UIImageView *imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)layoutUI{
    imageView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(NSData *)requestData{
    NSURL *url=[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/f3d3572c11dfa9eceee8a0e660d0f703908fc179.jpg"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    return data;
}

-(void)updateImage:(NSData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData];
    imageView.image=image;
}

-(void)loadImageWithMultiThread {
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
    
///--------------------------延迟－－－－------
//    NSMutableArray *threads=[NSMutableArray array];
//    int count=ROW_COUNT*COLUMN_COUNT;
//    //创建多个线程用于填充图片
//    for (int i=0; i<count; ++i) {
//        //        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
//        NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
//        thread.name=[NSString stringWithFormat:@"myThread%i",i];//设置线程名称
//        if(i==(count-1)){
//            thread.threadPriority=1.0;
//        }else{
//            thread.threadPriority=0.0;
//        }
//        [threads addObject:thread];
//    }
//    
//    for (int i=0; i<count; i++) {
//        NSThread *thread=threads[i];
//        [thread start];
//    }
    
    
///-------------------------执行多个线程－－－－------
//    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; ++i) {
//        //        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
//        NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
//        thread.name=[NSString stringWithFormat:@"myThread%i",i];//设置线程名称
//        [thread start];
//    }
    
    
///-----------------------暂停-----－－－－－－－－－－－－－－
//    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; i++) {
//        NSThread *thread= _threads[i];
//        //判断线程是否完成，如果没有完成则设置为取消状态
//        //注意设置为取消状态仅仅是改变了线程状态而言，并不能终止线程
//        if (!thread.isFinished) {
//            [thread cancel];
//            
//        }
//    }
}

-(void)loadImage{
    //请求数据
    NSData *data= [self requestData];
    /*将数据显示到UI控件,注意只能在主线程中更新UI,
     另外performSelectorOnMainThread方法是NSObject的分类方法，每个NSObject对象都有此方法，
     它调用的selector方法是当前调用控件的方法，例如使用UIImageView调用的时候selector就是UIImageView的方法
     Object：代表调用方法的参数,不过只能传递一个参数(如果有多个参数请使用对象进行封装)
     waitUntilDone:是否线程任务完成执行
     */
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  GCDDemo
//
//  Created by mac on 2020/6/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
    [self test2];
    
    
    
    
}

- (void)test1 {
    //串行队列，同步死锁
    NSLog(@"1");//任务1

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(dispatch_get_main_queue(),^{
        NSLog(@"2");//任务2
    });

    NSLog(@"3");//任务3
    /*
     
     分析：
     1.dispatch_sync表示是一个同步线程；
     2.dispatch_get_main_queue表示运行在主线程中的主队列，这是一个串行队列；
     3.任务2是同步线程的任务。
     首先执行任务1，这是肯定没问题的，只是接下来，程序遇到了同步线程，那么它会进入等待，等待任务2执行完，然后执行任务3。但这是队列，有任务来，当然会将任务加到队尾，然后遵循FIFO原则执行任务。那么，现在任务2就会被加到最后，任务3排在了任务2前面，问题来了：
     任务3要等任务2执行完才能执行，任务2由排在任务3后面，意味着任务2要在任务3执行完才能执行，所以他们进入了互相等待的局面。【既然这样，那干脆就卡在这里吧】这就是死锁。
     
     */
}

- (void)test2 {
    NSLog(@"1");//任务1

    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0),^{

        NSLog(@"2");//任务2

    });

    NSLog(@"3");//任务3
    
    /*
     
     
     
     */
    
    
   
}

- (void)goToDeadLock1 {
    //1.队列-串行
    /*
    参数1：队列名称
    参数2：队列属性 DISPATCH_QUEUE_SERIAL 串行，等价于NULL
    */
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    
//    dispatch_sync(queue, ^{
//        [self plantA];
//
//        queue
//    });
    

    

}


- (void)plantA {
    
}

- (void)plantB {
    
}


//串行队列每次只能执行一个任务，只开启一个线程
//简单描述下：
//
//tableView A启动了数据库访问​，在数据库队列里进行查询，而在success回调block里，执行了UI刷新的任务。而UI刷新的时候，某个cell又需要进行数据库查询来决定内部的元素显示，最终导致数据库访问出现死锁。
//
//这里很明显是出现了循环，数据库队列Q里的任务A在等待回调​block释放，而block又在等待UI刷新结束，UI刷新又在等待另一个新的数据库访问任务B回调，而B必须要在A执行结束后才能结束。这样就构成了一个循环引用。
//
//解决方案：
//
//将数据库任务B​放到其他线程去处理。或者将UI刷新拿回主线程内（这是应该的），刷新的任务不要在数据库队列（也就是个线程）里面去做。

@end

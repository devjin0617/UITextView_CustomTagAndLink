//
//  ViewController.m
//  UITextViewURLLink
//
//  Created by jin on 2015. 10. 14..
//  Copyright (c) 2015년 jin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _linkTextView.delegate = self;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithString:@"#태그"
                                            attributes:@{
                                                         @"JinTag" : @"태그",
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:14],
                                                         NSForegroundColorAttributeName : [UIColor grayColor]
//                                                         NSLinkAttributeName : @"http://"
                                                         }
                                            ];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTap:)];
    [_linkTextView addGestureRecognizer:tap];

    NSMutableAttributedString *mAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    
    [mAttributedString appendAttributedString:_linkTextView.attributedText];
    
    _linkTextView.attributedText = mAttributedString;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tagTap:(UIGestureRecognizer *)gesture {

    [_linkTextView setSelectedRange:NSMakeRange(0, 0)];
    
    UITextView *textView = (UITextView *)gesture.view;
    CGPoint tapLocation = [gesture locationInView:gesture.view];
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:textView.attributedText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    
    // init text container
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(textView.frame.size.width, textView.frame.size.height) ];
    textContainer.lineFragmentPadding  = 0;
    
    [layoutManager addTextContainer:textContainer];
    
    NSUInteger characterIndex = [layoutManager characterIndexForPoint:tapLocation
                                                      inTextContainer:textContainer
                             fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (characterIndex < textStorage.length) {
        
        NSRange range;
        id value = [textView.attributedText attribute:@"JinTag" atIndex:characterIndex effectiveRange:&range];
        
        if(value) {
            NSLog(@"%@, %lu, %lu", value, (unsigned long)range.location, (unsigned long)range.length);
        } else {
            NSLog(@"태그가 아님");
        }
        
    }

    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
//    NSString *strLink = [textView.text substringWithRange:characterRange];
//
//    if([strLink characterAtIndex:0] == '#') {
//
//        NSLog(@"태그클릭 : %@", [strLink substringFromIndex:1]);
//    }
    
    return YES;
}


@end

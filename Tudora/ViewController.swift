//
//  ViewController.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/17/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit
//就是view的生命周期，下面已经按方法执行顺序进行了排序
class ViewController: UIViewController {

    // view是延迟加载，只要view加载完毕就调用这个方法
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // view即将显示
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    //view即将开始布局子控件
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    // view已经完成子控件的布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    // view已经出现
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    // view即将消失
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // view已经消失
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    // 收到内存警告
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


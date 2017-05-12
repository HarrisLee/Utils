# Utils
Utils Collection


调试用到的命令
LLDB 命令
1. po    p    call    打印某个东西
2. expression    执行某个方法。  如   expression self.view.backgroundColor = [UIColor redColor]
3. thread backtrace ，  bt   查看当前堆栈
4. thread info     查看当前线程
5. thread list   列出所有的线程
6. thread select 2   选择线程2
7. thread until 70    执行到第70行
8. frame variable  此步骤下所有的变量
9. frame variable self.name 打印指定变量的值
10. frame info 此步骤下的信息
11. frame select 1    选择第几个步骤
12. breakpoint set -n insertStudent  在某方法处设置断点
13. watchpoint set variable items   监测对象items变化
14. image lookup --address 0x0000000107b63e90   查看某地址下的信息（一般是奔溃的时候用到）
15.  image lookup --name viewWillAppear:    查看多少文件有viewWillAppear方法
16. image lookup -t NKMObject   查看某个对象的结构
17. e @import UIKit   当使用 第一条的命令 查看某个参数的值失败时可以使用此命令，然后再次执行命令即可
18. apropos expression   可以查看expression的使用命令

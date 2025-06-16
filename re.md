~/.my.cnf：MySQL 客户端的配置文件

这是 MySQL 客户端特有的登录配置方式，用于简化连接命令。

[client]
user=root
password=yourpassword
host=localhost

mysql

MySQL 客户端就会自动读取这个文件，填入账号密码，帮你登录，不需要使用 export 环境变量。


二、export 是 Linux 的 shell 命令：设置环境变量
就不需要写 -p 或手动输密码了，因为 MySQL 客户端会去读取环境变量 MYSQL_PWD。

export MYSQL_PWD=yourpassword
mysql -uroot -h127.0.0.1 < init.sql
unset MYSQL_PWD

export PATH=$PATH:/usr/local/myapp/bin
export PYTHONPATH=/my/custom/python/modules

这些是 环境变量（Environment Variables），它们控制着你在 Linux/Mac 终端中如何运行命令、找库、找工具等等。我们来系统解释一下你提到的这几个关键点。
✅ 一、什么是环境变量？

环境变量是 shell（如 bash、zsh）中存储的 键值对，它们会影响程序的运行方式。
echo $PATH
输出的是你所有的可执行命令路径列表（: 分隔）。如果你运行一个命令，shell 就会到这些目录里找。
✅ 二、常见的几个环境变量
变量名
含义说明
PATH
命令搜索路径，决定你输入命令时从哪里找可执行文件
PYTHONPATH
Python 模块搜索路径（让你自定义导入模块目录）
LD_LIBRARY_PATH
动态链接库（.so 文件）搜索路径
HOME
当前用户主目录
SHELL
当前使用的 shell 类型（bash、zsh）
EDITOR
默认文本编辑器

✅ 三、你看到的 export 是什么意思？
export PATH=$PATH:/your/new/path
这个命令的意思是：

把新的路径（/your/new/path）加入到已有的 PATH 环境变量中，并将它导出为当前 shell 会话及其子进程可见。

✅ 四、关于 $PATH 的例子解释

python script.py
背后 Linux 会：
	1.	查看 PATH，比如：
/usr/local/bin:/usr/bin:/bin

	2.	依次在这些路径中找有没有 python 可执行文件
	3.	找到 /usr/bin/python 就运行它

    如果你安装了一个新版本 Python 在 /opt/python3.12/bin/ 里，就可以：
    export PATH=/opt/python3.12/bin:$PATH

    这样它会优先使用新的路径。

    ✅ 五、关于 PYTHONPATH

你写 Python 脚本可能会遇到：
import mymodule  # 找不到
export PYTHONPATH=/path/to/your/module:$PYTHONPATH

这样你就告诉 Python：

“除了默认路径，我还要你去 /path/to/your/module 那里找模块。”


✅ 六、如何永久生效？

上面的 export 只对当前终端窗口有效。

要永久生效，需要加到你的配置文件中，比如：
	•	~/.bashrc（如果你用 bash）
	•	~/.zshrc（如果你用 zsh）
	•	~/.profile（部分系统）



    echo 'export PATH=$PATH:/opt/mytools/bin' >> ~/.bashrc
source ~/.bashrc
✅ 七、查看所有环境变量
printenv      # 显示所有
echo $PATH    # 显示某一个

✅ 总结一句话：

环境变量就像是系统运行命令和程序时的“配置表”，用 export 是在动态地告诉 shell “该怎么找路径、找库、找配置”。

是否你想设置某个 Python 库目录或工具路径？我可以帮你写具体的 export 命令或 .bashrc 配置。
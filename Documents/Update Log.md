# Update Log

- 2021/12/07: 新建Log文件，使用说明：每次git push需要更新一下日志哦，写上日期、自己的名字和更新内容，以便解决冲突哦。Git使用：
  - 首先在主目录下右键打开git bash或使用cmd
  - 获取github上最新的程序：``git pull origin master:master`` 或 ``git pull``
  - 将自己的更改更新到本地git：``git add .`` 然后``git commit -m "your log"``
  - 将自己的更改更新到github上：``git push origin master:yourname``
  - 注意在github上最好创建一个自己的分支，最好是一台电脑一个分支或者一个人一个分支，push的时候会创建原本不存在的分支
  - 注意：4楼右边电脑config使用的是github此项目拥有者的身份信息，可以直接更改github上的master主分支，更改的时候一定要注意不要push到主分支上，否则roll back会影响其他使用者，请push到自己名字的分支上或者right4分支


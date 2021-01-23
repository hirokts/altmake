# altmake
altmake works like make commands for the current directory.

#### 説明
makeコマンドの代わりとして、カレントディレクトリに紐付けてシェルスクリプトのコマンドを登録します。  
実体はホームディレクトリ配下の `.altmake` ディレクトリに置くようにしています。  
使用例としては、「dockerコンテナを停止して, ボリュームも削除し、 再作成後にdbのマイグレーションも行う」など複数のコマンドを `altmake init` として実行できるようにすることを想定しています。  

#### 注意点
Visual Studio Codeが `code` コマンドとしてインストールされていると編集のときにVisual Studio Codeで開きます。  
インストールされていないとviで開きます。

#### Install
```
$ cp altmake.sh ${any_path_directory}/altmake
$ chmod a+x ${any_path_directory}/altmake
```

#### Usage
```
altmake [command] [<options>]
    Executes ~/.altmake/${hashed-currentdir}/${command}.sh with options.
altmake ls
    Print list of commands for the current directory.
altmake edit [command]
    Edit ~/.altmake/${hashed-currentdir}/${command}.sh with VSCode.
altmake rm [command]
    Remove  ~/.altmake/${hashed-currentdir}/${command}.sh
altmake --help
    Print this
```

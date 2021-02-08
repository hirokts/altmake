# altmake
altmake works like make commands for the current directory.

#### 説明
makeでのコマンド実行の代わりとして、すでにあるMakefile汚さずに、個人的によく使うコマンド群をカレントディレクトリに紐付けてシェルスクリプトのコマンドを登録できます。 
使用例としては、「dockerコンテナを停止して, ボリュームも削除し、 再作成後にdbのマイグレーションも行う」など複数のコマンドを `altmake init` として実行できるようにすることを想定しています。  

#### 注意点
保存するシェルスクリプトの実体はホームディレクトリ配下の `.altmake` ディレクトリに置くようにしています。  
Visual Studio Codeが `code` コマンドとしてインストールされていると編集のときにVisual Studio Codeで開き、インストールされていないとviで開きます。

#### 使用例
1. ふだん作業しているディレクトリで、 `db_init` というコマンド群を編集（作成)する
```
$ altmake edit db_init
```
2. `vscode` で `db_init.sh` が開かれるので、編集して保存する ( `~/.altmake/${hashed_current_dir}/db_init.sh` に保存されます)
```
# db_init.shの内容。dockerを停止、削除して、再度runで立ち上げる
docker stop local-postgres
docker rm local-postgres
docker run --name local-postgres -e POSTGRES_PASSWORD=XXXXX -p 5432:5432 -d postgres
```
3. 上記の `db_init.sh` 実行する
```
$ altmake db_init
```

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

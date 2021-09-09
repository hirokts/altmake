# altmake
altmake works like `make` commands for the current directory.

#### 説明
- `make` コマンドの代替として、シェルスクリプトを実行する
- すでにあるMakefileを変更せず、カレントディレクトリにはファイルも作らない
- 作業ディレクトリでよく使うコマンド群をシェルスクリプトとして記述し、そのディレクトリに紐付けたaltmakeコマンドとして登録

作業ディレクトリで繰り返し実行しているシェルコマンド群を `altmake ${command}` という形でパーソナルに実行できるようにすることを想定しています。  

#### 注意点
- コマンドは登録したディレクトリでしか実行できない
- 保存するシェルスクリプトの実体は `~/.altmake` ディレクトリに存在
- コマンド編集時、VSCodeが `code` コマンドとしてインストールされているとVSCodeで開き、それ以外の場合はviで開く

#### 使用例
「dockerコンテナを停止・削除し、 再作成後にdbのマイグレーションも行う」という処理を `db_init` というコマンドとして登録して実行する場合

1. 作業しているディレクトリで、 `db_init` というコマンドを編集開始
```
$ altmake edit db_init
```
2. `vscode` で `db_init.sh` が開かれるので、編集して保存する （作業ディレクトリには保存されません)
```bash
# db_init
docker stop local-postgres
docker rm local-postgres
docker run --name local-postgres -e POSTGRES_PASSWORD=XXXXX -p 5432:5432 -d postgres
```
3. コマンドを実行する
```
$ altmake db_init
```

#### Install
```
$ cp altmake.sh ${any_path_directory}/altmake
$ chmod a+x ${any_path_directory}/altmake
```
`any_path_directory` は `/usr/local/bin/` など、コマンドが実行可能なディレクトリです。

#### Uninstall
```
$ which altmake
$ rm ${any_path_directory}/altmake
$ rm -r ~/.altmake
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

#### Tips
```bash
# my_manage
docker-compose exec my_service python manage.py $@
```
というように `$@` を末尾につけたコマンドを登録することで、 `altmake my_manage test my_app.tests` というようにパラメータをそのまま渡せます。

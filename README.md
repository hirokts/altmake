# altmake
ディレクトリ特有のよく使うコマンド群を再利用したいが、Makefileを編集したくない場合に使えるシェルスクリプトコマンドです。

#### 説明
- 作業ディレクトリでよく使うコマンド群を登録することができ、作業ディレクトリは汚さない
- `altmake ${my_command}` といったカスタムコマンドをシェルスクリプトとして登録できる

#### 注意点
- コマンドは登録したディレクトリでしか実行できない
- 保存するシェルスクリプトの実体は `~/.altmake` ディレクトリに存在

#### 使用例
「dockerコンテナを停止・削除し、 再作成後にdbのマイグレーションも行う」という処理を `db_init` というコマンドとして登録して実行する場合

1. 作業しているディレクトリで、 `db_init` というコマンドを編集開始
```
$ altmake edit db_init
```
2. `db_init.sh` が編集状態で開かれるので、編集して保存する （ `~/.altmake/` 以下にある特定ディレクトリに保存)
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
- `altmake [command] [<options>]`  
登録されているコマンドを実行

- `altmake ls`  
作業ディレクトリで実行できるコマンドの一覧を表示

- `altmake cat_all`  
作業ディレクトリで実行できるコマンドの実体となるシェルスクリプトを全表示

- `altmake edit [command]`  
コマンドを編集。VSCodeがある場合はVSCodeが起動する

- `altmake rm [command]`  
コマンドを削除

#### Tips
```bash
# my_manage (djangoのmanage.pyコマンドをショートカットする)
docker-compose exec my_service python manage.py $@
```
というように `$@` を末尾につけたコマンドを登録することで、 `altmake my_manage test my_app.tests` というようにパラメータをそのまま渡せます。

aaa

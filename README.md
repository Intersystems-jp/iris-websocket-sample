# iris WebSocket サンプル

## 構成

### サーバー側

#### src/User/WebSocket.cls

サーバ側の処理

### クライアント側

#### html/websocket.html

クライアント側の処理

## 設定方法

### サーバー

#### src/User/WebSocket.cls

IRISインスタンスのUserネームスペースにこのクラスをロードしてコンパイル

`>do $system.OBJ.Import("c:¥git¥iris-websocket-sample¥src¥User¥WebSocket.cls","ck")`

### クライアント

#### html/websocket.html

このファイルに記載されているWebサーバーのIPアドレスとポート番号は環境に合わせて変更する

このファイルを'<IRISインストールディレクトリ>'/csp/userにコピーする

## テスト実行方法

### 初期処理

サーバー側で以下のメソッドを実行

`>Write ##class(User.WebSocket).Init()`

### ブラウザーでwebsocket.htmlを呼び出す(同期モード)

http://localhost:8080/csp/user/websocket.html

ipアドレスとポート番号は環境に合わせる

#### Create Socketボタンを押す

WebSocket接続を確立する

#### helloボタンを押す

クライアント（ブラウザ）にXYZと返ってくることを確認

#### タイムアウトを待つ

200秒経過すると、クライアントにclosedと返ってくる

### ブラウザーでwebsocket.htmlを呼び出す(非同期モード)

#### サーバー側で以下のメソッドを実行

`>Write ##class(User.WebSocket).Init(1)`

#### ブラウズを２個起動し、websocket.htmlを呼び出す

http://localhost:8080/csp/user/websocket.html

ipアドレスとポート番号は環境に合わせる

#### Create Socketボタンを押す(2回)

WebSocket接続を確立する

#### helloボタンを押す(2回)

クライアント（ブラウザ）にXYZと返ってくることを確認

### サーバー側で非同期処理を実行

`>write ##class(User.WebSocket).SendDataAsync()`

2個のブラウザ画面にHow are you?と返ってくることを確認


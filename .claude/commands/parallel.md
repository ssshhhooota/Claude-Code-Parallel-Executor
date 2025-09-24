## 前提条件
- $1にタスクの内容が与えられます。
- @instructions/manager.md の参照が必要です。
- @instructions/worker.md の参照が必要です。
- @instructions/tmux-example.md の参照が必要です。
- worker → manager, manager → worker のメッセージ送信には scripts/send-message.sh を利用してください。
  - 第一引数: 送信先のpaneタイトル (例: "manager", "worker1", "worker2", ...)
  - 第二引数: 送信するメッセージ内容 (例: "claude code", "タスクを完了しました。", ...)

## 実行内容
### 環境構築
- $1で与えられたタスクの内容に基づいて、適切なuniqueIDを作成してください。
- $1のタスクの内容を理解して、並列で実行可能か判断してください。
  - 並列で実行可能な場合は、workerの数を決定してください。
- scripts/prepare-environment.sh スクリプトを実行して、環境を構築してください。
  - 第一引数: 並列で実行するworkerの数を整数で与えてください。並列で実行しない場合は1を与えてください。
  - 第二引数: $1で与えられたタスクの内容を元に、適切なuniqueIDを引数として渡してください。
- 作業ドキュメントディレクトリを作成してください
  - tmp/配下に{{uniqueID}}ディレクトリを作成してください。
  - tmp/{{uniqueID}}/配下にworkerごとの作業ドキュメントを作成してください。
    - 例: tmp/{{uniqueID}}/worker1.md, tmp/{{uniqueID}}/worker2.md, ...
  - workerごとの作業ドキュメントには@instructions/work-template.mdの内容をコピーして作成してください。

## 実行
@instructions/manager.md の指示に従って進めてください。




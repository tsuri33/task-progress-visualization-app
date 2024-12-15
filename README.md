# タスク進捗度可視化アプリ（iOS）

AppStoreのリンクは[こちら](https://apps.apple.com/jp/app/id6461378188)

1. [概要](#概要)
2. [開発背景](#開発背景)
3. [開発環境](#開発環境)

## 概要
タスクの進捗度を目標期限までの残り日数とともに可視化するアプリです。

## 開発背景
高校時代、教科書や問題集を使うときに、どれくらいのペースで進めたら良いのかわからない、現状のペースを維持して期限内に終わらせられるかが不安、という経験があったことから、タスクの進捗度と期限までの残り日数をわかりやすく可視化するアプリを開発したいと思い、本アプリを開発しました。

## 開発環境

| | バージョン |
| --- | --- |
| Xcode | 16.2 |
| Swift | 5.10 |
| 対応iOS | 16.2以上 |

### セットアップ手順

1. [Mac App Store](https://apps.apple.com/jp/app/xcode/id497799835) で**Xcode**をダウンロードしてください。
2. 本リポジトリをクローンします。

```
git clone git@github.com:y-ma3/task-progress-visualization-app.git
```
3. `TaskProgressVisualizationApp.xcodeproj`を開きます。

### ビルド

`TaskProgressVisualizationApp.xcodeproj`を開いた状態で、`⌘`+`B`

### 実行

`TaskProgressVisualizationApp.xcodeproj`を開いた状態で、`⌘`+`R`

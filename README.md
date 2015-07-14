report template
===============

レポートなんてくそ食らえ！

## What is this?
tex / gnuplotでレポートを書くためのひな形です。
フォークしてよしなに使ってください。

日本語のレポートのみを想定しています。
jsarticleオンリーです。

## How to use?
### Write
**report.tex** にレポートの本体を書きます。
report.texでなくても拡張子が.texのものであれば何でも対応出来ます。

グラフを使用する場合は **plot.plt** に記述してください。
こちらも.pltなら何でも対応しています。

### Check
ファイルを書き終わったら
```
	$ make check
```
とすることで.texファイルや依存するファイルを検証することが出来ます。
errorから始まるものは.pdfファイルを作成することが出来ない致命的なエラー、warningから始まるものは余分な記述があるなどの警告です。

errorが存在する状況ではコンパイルすることが出来ません。
なので、いちいち手動でチェックしなくても問題ないかもしれません。

### Compile
レポートの作成が終わったら
```
	$ make
```
としてコンパイルしてください。 **report.pdf** が生成されます。
texファイルに report.tex 以外を使用した場合は、それに合わせた名前で生成されます。

### Cleanup
以下のようにすると、pdf, eps以外の不要なファイルを削除します。
```
	$ make clean
```

また、以下のようにするとpdf, epsファイルを含めて不当なファイルを削除します。
```
	$ make cleanall
```

## License / Author
MIT License (c)2015 [MacRat](http://blanktar.jp/)

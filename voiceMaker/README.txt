sudo apt install sox libsox-fmt-mp3

# check properties
soxi input.wav

# change sample rate
ffmpeg -i input.wav -ar 44100 output.wav

# change channel 1 or 2
sox input.wav -c 1 output.wav

# convert .mp3 to .wav
sox input.mp3 output.wav

# concat .wav
sox input1.wav input2.wav output.wav


## .mp3のSEをダウンロードしたとき
### プロパティをチェック
soxi sound.mp3

### .mp3から.wavに変換，ついでにチャンネル数を1（モノラル）に変換
sox sound.mp3 -c 1 sound.wav

### 音声ファイルのサンプルレートを変換
ffmpeg -i voice.wav -ar 44100 voice_44100.wav

### SEと音声ファイルを合成
sox sound.wav voice_44100.wav output.wav


const spawn = require('child_process').spawn
const fs = require('fs')
const del = require('del')

const util = require(__dirname + '/lib/util')
const c = require(__dirname + '/lib/constant')

const TMP_DIR = __dirname + '/__WAV_TMP/'
const SE_DIR = __dirname + '/se/'
const BGM_DIR = __dirname + '/bgm/'
const WAV_RESULT_DIR = __dirname + '/../result/wav/'
const BGM_RESULT_DIR = __dirname + '/../result/bgm/'
const JSON_RESULT_DIR = __dirname + '/../result/json/time/'


const textToWav = (line, speed, weight, tmpFilePath, filePath) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('echo', ['"' + line + '"', '|', 'open_jtalk', '-x', '/var/lib/mecab/dic/open-jtalk/naist-jdic', '-m', '/usr/share/hts-voice/mei/mei_normal.htsvoice', '-r', speed, '-jf', weight, '-ow', tmpFilePath, '&&', 'ffmpeg', '-i', tmpFilePath, '-ar', '44100', '-y', filePath], { shell: true, })

    proc.stderr.on('data', (err) => {
//            console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
//            console.log('stdout:', data.toString())
    })
    proc.on('close', (code) => {
      console.log('[ok] textToWav:', line, code)
      resolve()
    })
  })
}

const wavToDuration = (wavFilePath) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('soxi', ['-d', wavFilePath], { shell: true, })
    let duration = 0

    proc.stderr.on('data', (err) => {
      //      console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
      console.log('stdout .wav duration:', data.toString())
      const durStr = data.toString()
      const _dur = durStr.split(/[:\.]/)
      duration = _dur[0] * 3600*1000 + _dur[1] * 60*1000 + _dur[2] * 1000 + _dur[3] * 10
    })
    proc.on('close', (code) => {
      console.log('[ok] wavToDuration:', wavFilePath, duration, code)
      resolve(duration)
    })
  })
}

const extendWav = (duration, tmpFilePath, wavFilePath) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('sox', [tmpFilePath, wavFilePath, 'fade', 't', '0', (duration / 1000).toFixed(2), '0.1'])

    proc.stderr.on('data', (err) => {
      //      console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
      //      console.log('stdout:', data.toString())
    })
    proc.on('close', (code) => {
      console.log('[ok] extendWav:', wavFilePath, code)
      resolve(duration)
    })
  })
}

const mergeWav = (wavPathList, outputWavPath) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('sox', [].concat(wavPathList, outputWavPath))

    proc.stderr.on('data', (err) => {
      //      console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
      //      console.log('stdout:', data.toString())
    })
    proc.on('close', (code) => {
      console.log('[ok] mergeWav:', code)
      resolve()
    })
  })
}

const playVoice = (wavFilePath) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('play', [wavFilePath])

    proc.stderr.on('data', (err) => {
//            console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
//            console.log('stdout:', data.toString())
    })
    proc.on('close', (code) => {
      console.log('[ok] playVoice:', wavFilePath, code)
      resolve()
    })
  })
}


const trimBgm = (duration, bgmFileName, outputBgmPath) => {
  return new Promise((resolve, reject) => {
    /* 最初の6秒はフェードイン、最後の5秒はフェードアウト、音量は13下げる */
    const proc = spawn('sox', [].concat(bgmFileName, '-c', '1', outputBgmPath, 'fade', 't', '6', 'fade', 't', '0', duration, '5', 'gain', '-13'))

    proc.stderr.on('data', (err) => {
      console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
      console.log('stdout:', data.toString())
    })
    proc.on('close', (code) => {
      console.log('[ok] trimBgm:', code)
      resolve()
    })
  })
}

const mixWavAndBgm = (wavFileName, bgmFileName, outputBgmPath) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('sox', [].concat('-m', wavFileName, bgmFileName, outputBgmPath))

    proc.stderr.on('data', (err) => {
      console.error('stderr:', err.toString())
    })
    proc.stdout.on('data', (data) => {
      console.log('stdout:', data.toString())
    })
    proc.on('close', (code) => {
      console.log('[ok] mixWavAndBgm:', code)
      resolve()
    })
  })
}

const getWavList = async (jsonForAudio, speakVoice) => {
  const result = { durList: {}, wavList: [], bgmFileName: null, }
  for(const i in jsonForAudio) {
    const row = jsonForAudio[i]
    if(row.type === c.TYPE_ARTICLE) {
      console.log('- [', i, ']', row.title)
      const tmpFileName1 = TMP_DIR + '_' + i + '.wav'
      const tmpFileName2 = TMP_DIR + '__' + i + '.wav'
      const wavFileName = TMP_DIR + i + '.wav'
      await textToWav(row.voice, 1.2, 1.16, tmpFileName1, tmpFileName2)
      if(speakVoice === '1') {
        await playVoice(tmpFileName2)
      }
      let duration = (await wavToDuration(tmpFileName2)) + c.EXTEND_WAV_MS
      await extendWav(duration, tmpFileName2, wavFileName)
      result.wavList.push(wavFileName)
      result.durList[row.type + row.voice] = duration 
    } else if(row.type === c.TYPE_SE || row.type === c.TYPE_SE_OPENING) {
      const wavFileName = SE_DIR + row.file + '.wav'
      result.wavList.push(wavFileName)

      if(!result.durList[row.type + row.file]) {
        const duration = await wavToDuration(wavFileName)
        result.durList[row.type + row.file] = duration 
      }
    } else if(row.type === c.TYPE_BGM) {
      result.bgmFileName = BGM_DIR + row.file + '.wav'
    } else {
      console.log('[fatal] unimplemented row type:', row.type, row)
      process.exit(0)
      return
    }
  }
  return result
}

const makeVoice = async (jsonForAudioFilePath, speakVoice) => {
  if(!jsonForAudioFilePath) {
    console.log('usage: node generate.js jsonForAudioFilePath')
    return null
  }

  let jsonForAudio = null
  try {
    const fileContent = fs.readFileSync(jsonForAudioFilePath, 'utf-8')
    jsonForAudio = JSON.parse(fileContent)
  } catch(e) {
    console.log('[error] invalid file or json:', e)
    return null
  }

  fs.mkdirSync(TMP_DIR, { recursive: true, })

  /* wav */
  const result = await getWavList(jsonForAudio, speakVoice)
  const newWavFilePath = WAV_RESULT_DIR + util.formatDate(new Date()) + '.wav'
  await mergeWav(result.wavList, newWavFilePath)

  /* bgm */
  if(!result.bgmFileName) {
    console.log('[error] no bgm specified')
    process.exit(0)
  }
  const bgmDuration = (await wavToDuration(newWavFilePath) / 1000)
  const tmpBgmFilePath = TMP_DIR + util.formatDate(new Date()) + '.wav'
  await trimBgm(bgmDuration, result.bgmFileName, tmpBgmFilePath)
  const newBgmFilePath = BGM_RESULT_DIR + util.formatDate(new Date()) + '.wav'
  await mixWavAndBgm(newWavFilePath, tmpBgmFilePath, newBgmFilePath)

  /* play */
//  await playVoice(newBgmFilePath)

  /* json */
  const jsonWithTime = jsonForAudio.map((row) => {
    if(row.type === c.TYPE_ARTICLE) {
      return Object.assign({ time: result.durList[row.type + row.voice], }, row)
    } else if(row.type === c.TYPE_SE) {
      return Object.assign({ time: result.durList[row.type + row.file], }, row)
    } else if(row.type === c.TYPE_SE_OPENING) {
      return Object.assign({ time: c.OPENING_DURATION, }, row)
    } else if(row.type === c.TYPE_BGM) {
      return null
    } else {
      console.log('[fatal] invalid row type:', row)
      process.exit(0)
    }
  }).filter((row) => { return row })
  const newJsonFilePath = JSON_RESULT_DIR + util.formatDate(new Date()) + '.json'
  fs.writeFileSync(newJsonFilePath, JSON.stringify(jsonWithTime, null, 2).replace(/\n      "/g, '"'))
  
  await del([TMP_DIR])
  return [newBgmFilePath, newJsonFilePath]
}

const main = async () => {
  const jsonForAudioFilePath = process.argv[2]
  await makeVoice(jsonForAudioFilePath)
  process.exit(0)
}

if(require.main === module) {
  main()
} else {
  module.exports = {
    makeVoice,
  }
}



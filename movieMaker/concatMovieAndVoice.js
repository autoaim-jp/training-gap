const spawn = require('child_process').spawn

const OUTPUT_DIR = __dirname + '/../result/final/'

const util = require(__dirname + '/lib/util')

const concatMovieAndVoice = (wavFilePath, mp4FilePath) => {
  const outputFilePath = OUTPUT_DIR + util.formatDate(new Date(), 'YYYY-MM-DD_hh-mm-ss') + '.mp4'
  return new Promise((resolve, reject) => {
    const proc = spawn(__dirname + '/bash/concat.sh', [mp4FilePath, wavFilePath, outputFilePath])

    proc.stderr.on('data', (err) => {
      console.error('stderr:', err.toString())
      process.stdout.write('.')
    })
    proc.stdout.on('data', (data) => {
      console.log('stdout:', data.toString())
      process.stdout.write('.')
    })
    proc.on('close', (code) => {
      console.log()
      console.log('[ok] concatMovieAndVoice:', code)
      resolve(outputFilePath)
    })
  })
}

const main = async () => {
  const wavFilePath = process.argv[2]
  const mp4FilePath = process.argv[3]
  await concatMovieAndVoice(wavFilePath, mp4FilePath)
  process.exit(0)
}

if(require.main === module) {
  main()
} else {
  module.exports = {
    concatMovieAndVoice,
  }
}


const spawn = require('child_process').spawn

const OUTPUT_DIR = __dirname + '/../result/movie/'
const THUBMNAIL_OUTPUT_DIR = __dirname + '/../result/thumbnail/'

const util = require(__dirname + '/lib/util')

const makeMovie = (timeJsonFilePath) => {
  const outputFilePath = OUTPUT_DIR + util.formatDate(new Date(), 'YYYY-MM-DD_hh-mm-ss') + '.mp4'
  return new Promise((resolve, reject) => {
    const proc = spawn(__dirname + '/bash/generateMovieByProcessing.sh', [timeJsonFilePath, THUBMNAIL_OUTPUT_DIR, outputFilePath])

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
    proc.on('error', (error) => {
      console.log(error)
    })
  })

}

const main = async () => {
  const timeJsonFilePath = process.argv[2]
  await makeMovie(timeJsonFilePath)
  process.exit(0)
}

if(require.main === module) {
  main()
} else {
  module.exports = {
    makeMovie,
  }
}


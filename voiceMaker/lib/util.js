const request = require('request')
const readline = require('readline')
const Writable = require('stream').Writable

const apiRequest = (isPost, url, param, header = {}) => {
  return new Promise((resolve, reject) => {
    const query = param && Object.keys(param).map((key) => { return key + '=' + param[key] }).join('&')
    const opt = {
      method: isPost? 'POST': 'GET',
      url: url + (isPost? '': (query? '?' + query: '')),
      headers: Object.assign({
      }, header),
    }
    if(isPost) {
      opt.body = param? param: {}
    }
    request(opt, (fetchErr, fetchRes, fetchBody) => {
      resolve(fetchBody)
    })
  })
}

const mutableStdout = new Writable({
  write: function(chunk, encoding, callback) {
    if (!this.muted) {
      process.stdout.write(chunk, encoding)
    }
    callback()
  }
})
const inputLine = (label, isInvisible) => {
  return new Promise((resolve, reject) => {
    const rl = readline.createInterface({
      input: process.stdin,
      output: mutableStdout,
      terminal: true
    })

    process.stdout.write(label)
    if(isInvisible) {
      mutableStdout.muted = true
    }
    rl.question(label, (line) => {
      if(isInvisible) {
        process.stdout.write('\n')
        mutableStdout.muted = false
      }
      rl.close()
      resolve(line)
    })
  })
}

const formatDate = (date, format) => {
  return (format || 'YYYY-MM-DD_hh-mm-ss').replace(/YYYY/g, date.getFullYear())
    .replace(/MM/g, ('0' + (date.getMonth() + 1)).slice(-2))
    .replace(/DD/g, ('0' + date.getDate()).slice(-2))
    .replace(/hh/g, ('0' + date.getHours()).slice(-2))
    .replace(/mm/g, ('0' + date.getMinutes()).slice(-2))
    .replace(/ss/g, ('0' + date.getSeconds()).slice(-2))
}


module.exports = {
  apiRequest,
  inputLine,
  formatDate,
}


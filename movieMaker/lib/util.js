const crypto = require('crypto')
const request = require('request')

const getRandomHex = (len) => {
  return crypto.randomBytes(len / 2 + 1).toString('hex').substr(0, len)
}
const getUuidv4 = () => {
  return getRandomHex(8) + '-' + getRandomHex(4) + '-4' + getRandomHex(3) + '-' + getRandomHex(4) + '-' + getRandomHex(12)
}
const formatDate = (date, format) => {
  return (format || 'YYYY-MM-DD_hh-mm-ss').replace(/YYYY/g, date.getFullYear())
    .replace(/MM/g, ('0' + (date.getMonth() + 1)).slice(-2))
    .replace(/DD/g, ('0' + date.getDate()).slice(-2))
    .replace(/hh/g, ('0' + date.getHours()).slice(-2))
    .replace(/mm/g, ('0' + date.getMinutes()).slice(-2))
    .replace(/ss/g, ('0' + date.getSeconds()).slice(-2))
}

const apiRequest = (isPost, url, param, header = {}) => {
  return new Promise((resolve, reject) => {
    const query = param && Object.keys(param).map((key) => { return key + '=' + param[key] }).join('&')
    const opt = {
      method: isPost? 'POST': 'GET',
      url: url + (isPost? '': (query? '?' + query: '')),
      headers: Object.assign({
      }, header),
      json: true,
      body: isPost? (param? param: {}): {},
    }
    request(opt, (err, res, body) => {
      if(err || !body) {
        console.log('[error] util.apiRequest:', err)
        resolve(null)
        return
      }
      resolve(body)
    })
  })
}




module.exports = {
  getRandomHex,
  getUuidv4,
  formatDate,
  apiRequest,
}


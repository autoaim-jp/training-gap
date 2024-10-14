const fs = require('fs')
const util = require(__dirname + '/lib/util')

const registerPathApiEndpoint = 'https://goontv.com/api/v1/private/path/registerNordot'
const ACCESS_TOKEN = 'tl5q5rbghmr3cqdopjmpeffo2rd28tl8h5k0c3movqbo4lci'
const newsUrl = 'https://goontv.com'

const makeDescription = async (timeJsonFilePath) => {
  const title = util.formatDate(new Date(), 'YYYY年MM月DD日') + 'のニュース[goontv.com]'
  const json = JSON.parse(fs.readFileSync(timeJsonFilePath, 'utf-8'))

  const nordotIdList = json.filter((row) => { return row.type === 'article' }).map((row, i) => {
    return row.meta.id
  })

  const authorizatoinHeader = 'Bearer ' + ACCESS_TOKEN
  const requestResult = await util.apiRequest(true, registerPathApiEndpoint, { nordotIdList, }, { 'Authorization': authorizatoinHeader, })
 
  const resultList = json.filter((row) => { return row.type === 'article' }).map((row, i) => {
    const textList = [] 
    textList.push(row.title.trim())
//    textList.push('https://www.google.co.jp/search?q=' + encodeURIComponent(row.title))
    textList.push(newsUrl + requestResult.linkPathList[row.meta.id])
    return textList.join('\n')
  })
  resultList.unshift(title)
  return resultList.join('\n')
}

const main = async () => {
  const timeJsonFilePath = process.argv[2]
  const description = await makeDescription(timeJsonFilePath)
  console.log(description)
  process.exit(0)
}

if(require.main === module) {
  main()
} else {
  module.exports = {
    makeDescription,
  }
}


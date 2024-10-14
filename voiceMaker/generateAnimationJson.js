const fs = require('fs')

const util = require(__dirname + '/lib/util')
const c = require(__dirname + '/lib/constant')

const JSON_RESULT_FILE = __dirname + '/../result/20241010/adjusted/__animation.json'
const FRAME_RATE = 60

const getFrameCount = (msec) => {
  return Math.ceil(msec / FRAME_RATE)
}

const getLeftTopObj = (openingTime, totalSumTime) => {
 const vertexLeftTopComponentList = [
    { "type": "vertexFixed", "positionList": [[20,20], [350,20], [390,50], [20, 50]], "x": "0", "y": "0", "fillColor": [206, 64, 95, 220], "strokeColor": [100, 100, 100, 60], "strokeWeight": "3" },
    { "type": "lineFixed", "positionList": [[28, 20, 28, 50], [32, 20, 32, 50], [38, 20, 38, 50], [42, 20, 42, 50]], "x": "0", "y": "0", "fillColor": [206, 64, 95, 220], "strokeColor": [255, 255, 255, 100], "strokeWeight": "2" },
    { "type": "lineFixed", "positionList": [[30, 20, 30, 50], [40, 20, 40, 50]], "x": "0", "y": "0", "fillColor": [206, 64, 95, 220], "strokeColor": [255, 255, 255, 255], "strokeWeight": "2" },
   { "type": "textUnderlineFixed", "text": "研修くん GOLD α プレミアム", "x": "50", "y": "40", "textColor": [255, 255, 255, 255], "strokeColor": [100, 100, 100, 200], "strokeWeight": "3", "textSize": "20", "textFont": "Source Han Sans Bold" }
  ]
  const leftTopObj = { startFrame: getFrameCount(openingTime), endFrame: getFrameCount(totalSumTime), objectList: vertexLeftTopComponentList, }
  return leftTopObj
}

const getOpeningObjList = (openingTime) => {
  const objList = []
  const openingComponentList = [
    { "type": "frameOpening" }
  ]
  const openingObj = { startFrame: 0, endFrame: getFrameCount(openingTime), objectList: openingComponentList, }
  objList.push(openingObj)

  const generatedDate = `PGMによる生成日時: ${util.formatDate(new Date(), 'YYYY/MM/DD hh:mm:ss')}`
  const titleFadeInComponentList = [
    { "type": "boxFadeIn", "fillColor": [206, 64, 95, 80], "strokeWeight": "1", "x": "TOP", "y": "LEFT", "width": "1920", "height": "1080", "maxAlpha": "200" },
    { "type": "textFadeIn", "textSize": "30", "text": "BBS AI アイデアソン 2024 応募作品", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER -100", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeIn", "textSize": "50", "text": "研修くん GOLD α プレミアム", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER -30", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeIn", "textSize": "20", "text": "BBS名古屋支店 豊岡佑真", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER 70", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeIn", "textSize": "20", "text": generatedDate, "x": "LEFT", "y": "BOTTOM -10", "fillColor": [255, 255, 255, 220] },
  ]
  const titleFadeInObj = { startFrame: getFrameCount(openingTime * 0.65), endFrame: getFrameCount(openingTime * 0.8) - 1, objectList: titleFadeInComponentList, }
  objList.push(titleFadeInObj)

  const titleFadeOutComponentList = [
    { "type": "boxFadeOut", "fillColor": [206, 64, 95, 80], "strokeWeight": "1", "x": "TOP", "y": "LEFT", "width": "1920", "height": "1080", "maxAlpha": "200" },
    { "type": "textFadeOut", "textSize": "30", "text": "BBS AI アイデアソン 2024 応募作品", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER -100", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeOut", "textSize": "50", "text": "研修くん GOLD α プレミアム", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER -30", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeOut", "textSize": "20", "text": "BBS名古屋支店 豊岡佑真", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER 70", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeOut", "textSize": "20", "text": generatedDate, "x": "LEFT", "y": "BOTTOM -10", "fillColor": [255, 255, 255, 220] },
  ]
  const titleFadeOutObj = { startFrame: getFrameCount(openingTime * 0.8), endFrame: getFrameCount(openingTime), objectList: titleFadeOutComponentList, }
  objList.push(titleFadeOutObj)
  return objList
}

const getEndingObjList = (endingTime, totalSumTime) => {
	console.log({ endingTime, totalSumTime })
  const objList = []

  const generatedDate = `PGMによる生成日時: ${util.formatDate(new Date(), 'YYYY/MM/DD hh:mm:ss')}`
  const titleFadeInComponentList = [
    { "type": "boxFadeIn", "fillColor": [206, 64, 95, 80], "strokeWeight": "1", "x": "TOP", "y": "LEFT", "width": "1920", "height": "1080", "maxAlpha": "200" },
    { "type": "textFadeIn", "textSize": "30", "text": "BBS AI アイデアソン 2024 応募作品", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER -100", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeIn", "textSize": "50", "text": "研修くん GOLD α プレミアム", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER -30", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeIn", "textSize": "20", "text": "BBS名古屋支店 豊岡佑真", "x": "X_LINE_CENTER", "y": "Y_LINE_CENTER 70", "fillColor": [255, 255, 255, 220], "textFont": "Source Han Sans Bold" },
    { "type": "textFadeIn", "textSize": "20", "text": generatedDate, "x": "LEFT", "y": "BOTTOM -10", "fillColor": [255, 255, 255, 220] },
  ]
  const titleFadeInObj = { startFrame: getFrameCount(totalSumTime - endingTime), endFrame: getFrameCount(totalSumTime) - 1, objectList: titleFadeInComponentList, }
  objList.push(titleFadeInObj)

  return objList
}



const getRightBottomObj = (openingTime, totalSumTime) => {
 const rightBottomComponentList = [
    { "type": "framePieCountDown" }
  ]
  const rightBottomObj = { startFrame: getFrameCount(openingTime), endFrame: getFrameCount(totalSumTime), objectList: rightBottomComponentList, }
  return rightBottomObj
}

const getNewsObjList = (isFirstArticle, isLastArticle, row, currentSumTime) => {
	console.log({ isFirstArticle, isLastArticle, row, currentSumTime })
  const newsTagObjList = []
  const addNewsObjectList = (animationType, startFrame, endFrame) => {
    const newsObj = { startFrame, endFrame, objectList: [], }
    if (isFirstArticle && animationType === "FadeIn") {
      newsObj.objectList.push({ "type": "boxFadeIn", "fillColor": [200,200,200,100], "strokeWeight": "1", "x": "X_CENTER -900", "y": "BOTTOM -200 -20", "width": "1800", "height": "200" })
    } else if (isLastArticle && animationType === "FadeOut") {
      newsObj.objectList.push({ "type": "boxFadeOut", "fillColor": [200,200,200,100], "strokeWeight": "1", "x": "X_CENTER -900", "y": "BOTTOM -200 -20", "width": "1800", "height": "200" })
    } else {
      if (animationType === "Fixed") {
        newsObj.objectList.push({ "type": "@fixedScene" })
      }
      newsObj.objectList.push({ "type": "boxFixed", "fillColor": [200,200,200,100], "strokeWeight": "1", "x": "X_CENTER -900", "y": "BOTTOM -200 -20", "width": "1800", "height": "200" })
    }
    newsObj.objectList.push({ "type": "text" + animationType, "textSize": "40", "text": row.title1, "x": "X_LINE_CENTER", "y": "BOTTOM -160" })
    newsObj.objectList.push({ "type": "text" + animationType, "textSize": "40", "text": row.title2, "x": "X_LINE_CENTER", "y": "BOTTOM -70" })
    newsObj.objectList.push({ "type": "text" + animationType, "textSize": "20", "text": row.sceneName, "x": "LINE_RIGHT_IN -20", "y": "LINE_TOP_IN" })
    newsObj.objectList.push({ "type": "image" + animationType, "fileName": row.image, "x": "260", "y": "60" })
    newsTagObjList.push(newsObj)
  }

  const minFrame = getFrameCount(currentSumTime)
  const maxFrame = getFrameCount(currentSumTime + row.time)
  const tenPercentFrame = Math.ceil((maxFrame - minFrame) / 10)
  addNewsObjectList('FadeIn', minFrame, minFrame + tenPercentFrame)
  addNewsObjectList('Fixed', minFrame + tenPercentFrame, maxFrame - tenPercentFrame)
  addNewsObjectList('FadeOut', maxFrame - tenPercentFrame, maxFrame)

  return newsTagObjList
}

const makeJson = (timeJsonFilePath) => {  
  let timeJson = null
  try {
    const fileContent = fs.readFileSync(timeJsonFilePath, 'utf-8')
    timeJson = JSON.parse(fileContent)
  } catch(e) {
    console.log('[error] invalid file or json:', e)
    return null
  }

  const animationJson = { totalFrame: 0, componentList: [], }
  let currentSumTime = 0
  let openingTime = timeJson[0].time
  const articleN = timeJson.filter((row) => { return row.type === c.TYPE_ARTICLE }).length
  let articleCount = 0
  timeJson.forEach((row) => {
    if(row.type === c.TYPE_ARTICLE) {
      articleCount += 1
      animationJson.componentList.push(...getNewsObjList(articleCount === 1, articleN === articleCount, row, currentSumTime))
    }
    currentSumTime += row.time
  })
  const totalSumTime = currentSumTime
  const endingTime = timeJson[timeJson.length - 1].time

  animationJson.componentList.push(...getOpeningObjList(openingTime))
  animationJson.componentList.push(getLeftTopObj(openingTime, totalSumTime))
  // debug comment out for speedup
  // animationJson.componentList.push(getRightBottomObj(openingTime, totalSumTime))
  animationJson.componentList.push(...getEndingObjList(endingTime, totalSumTime))
  animationJson.totalFrame = '' + getFrameCount(totalSumTime)
  const newJsonFilePath = JSON_RESULT_FILE
  fs.writeFileSync(newJsonFilePath, JSON.stringify(animationJson, null, 2).replace(/\n      "/g, '"'))
  return newJsonFilePath
}

const main = () => {
  const timeJsonFilePath = process.argv[2]
  const animationJsonPath = makeJson(timeJsonFilePath)
  console.log(animationJsonPath)
  process.exit(0)
}

if(require.main === module) {
  main()
} else {
  module.exports = {
    makeJson,
  }
}



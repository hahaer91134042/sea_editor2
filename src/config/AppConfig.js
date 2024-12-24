const lang = require('@/config/Lang')
const {
  checkDirOrCreate,
  checkFileExist,
  writeFile,
  readFile
} = require('@/plugin/Utils')

let dir = './_config' //編輯器設定資料夾
let file = `${dir}/setting.json`
let supportLang = []
for (const key in lang.Support) {
  supportLang.push(key)
}
const def = {
  lang: {
    use: supportLang[0]
  }
}

module.exports = {
  init: function () {
    checkDirOrCreate(dir)
    //console.log(`app config file exist->${checkFileExist(file)}`)
    if (!checkFileExist(file)) {
      writeFile(file, JSON.stringify(def))
      return def
    } else {
      return readFile(file)
    }
  },
  save:function(config){
    writeFile(file,JSON.stringify(config))
  }
}

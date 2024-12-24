const fs = require('fs')
const iconv = require('iconv-lite')
const l2j = require('lua-json')
const moment = require('moment')
const _=require('lodash')

module.exports = {
  /**
   * 因為lua object沒有明確定義是object還是array 所以轉換成js的時候可能會是空物件(但其實是array的情況出現)
   * @param {*} data lua obj
   * @returns
   */
  tryObjToArray: function (data) {
    //console.log(`tryObjToArray ${data.isArr()}`)
    return Array.isArray(data) ? data : []
  },
  /**
   * 確認對象是否array
   * @param {*} data input
   * @param {*} success finall invoke
   * @param {*} error not array invoke
   */
  tryArray: function (data, success, error) {
    if (!Array.isArray(data)) if (error) error()
    success()
  },
  /**
   * 處理字串轉number
   * @param {*} str input string
   * @returns when string empty return "" else number
   */
  tryZero: function (str) {
    return str.toNum() == 0 ? str : str.toNum()
  },
  /**
   *
   * @param {*} lua lua file
   * @param {*} option *本欄位另存須設定* {path:'指定存檔路徑',fileName:{ori:'原本檔案名稱',fix:'替換後的檔案名稱'}}
   */
  saveLuaFile (lua, option = { path: '', fileName: { ori: '', fix: '' } }) {
    console.log(`luaFile save`)
    //console.log(`luaFile save ->${JSON.stringify(lua)}`)
    const config = {
      UnSaveProp: ['rawTxt', 'comments', 'path']
    }
    let luaSavePath = option.path.length < 1 ? lua.path : option.path
    let txt = []
    //先印comments
    lua.comments.forEach(c => {
      txt.push(`${c}`)
    })

    for (let key in lua) {
      if (config.UnSaveProp.includes(key)) continue

      const element = lua[key]
      console.log(`luaFile obj key:${key} value:${JSON.stringify(element)}`)
      const value = l2j.format(element, { singleQuote: false }).slice(7)
      key = key.replace(option.fileName.ori, option.fileName.fix)
      console.log(`luaFile key->${key}`)
      console.log(`luaFile format->${value}`)
      txt.push(`\n${key}=${value}`)
    }
    let res = txt.join('')
    // console.log(`luaFile save result->${res}`)
    // console.log(`luaFile save path->${this.path}`)
    fs.writeFileSync(luaSavePath, iconv.encode(res, 'GB2312'))
  },
  /**
   * 解析檔案路徑
   * @param {*} path File path
   * @returns { fullName:'檔案全名',shortName:'主檔名',extend:'副檔名'}
   */
  parseFilePath (path) {
    let fName = path.split('\\').pop().split('/').pop()

    return {
      fullName: fName,
      shortName: fName.split('.')[0],
      extend: fName.split('.')[1]
    }
  },
  roundTo (num, digit = 2) {
    return +(Math.round(num + `e+${digit}`) + `e-${digit}`)
  },
  numberWithCommas: function (x) {
    return x.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ',')
  },

  checkDirOrCreate (dir) {
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir)
    }
  },
  checkFileExist (path) {
    return fs.existsSync(path)
  },
  writeFile (path, txt) {
    fs.writeFileSync(path, txt)
  },
  readFile (path, encode = 'utf8') {
    return JSON.parse(fs.readFileSync(path, encode))
  },
  selectDirFiles (path) {
    return fs.readdirSync(path)
  },
  mergeArray (a,b,group_by,fun) {
    let raw = a.concat(b)
    //console.log(`merge array raw->${raw.jsonString()}`)

    let group= _.groupBy(raw,group_by)
    // console.log(`merge array group->${group.jsonString()}`)
    let r=[]
    for (const key in group) {
      r.push({key:key,value:group[key]})
    }

    return r.map(o => fun(o.key,o.value))
  },
  Log: {
    print (msg, flag = null) {
      let now = moment()
      //console.log(`Log now date->${now.format('YYYY-MM-DD')} time->${now.format('YYYY-MM-DD HH:mm:ss')}`)

      fs.appendFile(
        `./_Log/${now.format('YYYY-MM-DD')}.txt`,
        `${now.format('YYYY-MM-DD HH:mm:ss')}${
          flag ? `[${flag}]` : ''
        }:${msg}\n`,
        err => {
          if (err) throw err
        }
      )
    }
  },
  Screen: class {
    constructor () {
      this.refresh()
      window.addEventListener('resize', this.refresh)
    }
    refresh () {
      this.w = window.innerWidth
      this.h = window.innerHeight
      //console.log(`screen resize W->${this.w} H->${this.h}`)
    }
    onChange (back) {
      window.addEventListener('resize', () => {
        back(window.innerWidth, window.innerHeight)
      })
    }
  }
}

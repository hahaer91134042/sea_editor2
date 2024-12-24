const fs = require('fs')
const luaparse = require('luaparse')
const iconv = require('iconv-lite')
const { tryObjToArray } = require('@/plugin/Utils')
import * as l2j from 'lua-json'

// const config={
//   UnSaveProp:['rawTxt','comments','path']
// }

class LuaFile {
  path = ''
  rawTxt = ''
  //items = []
  comments = []
  constructor (txt) {
    this.rawTxt = txt

    //const luO=l2j.parse(txt,{comments:true})
    //console.log(`lua-json parse->${luO}`)

    const ast = luaparse.parse(this.rawTxt)
    console.log(`parse lua`)
    console.log(ast)
    console.log('lua body')
    console.log(ast.body)
    //new LuaFile(ast.comments[0].value, ast.body)
    this.comments = ast.comments.map(c => c.raw)
    let lua = ast.body
    for (const element of lua) {
      console.log(element)
      let init = element.init[0]
      console.log(init)

      let name = element.variables[0].name
      console.log(`obj name->${name}`)
      let luObj = new LuaFileObj(element)

      this[name] = luObj
    }
    // lua.forEach(element => {
    //   console.log(element)
    //   let init = element.init[0]
    //   console.log(init)

    //   let luObj = new LuaFileObj(element)
    //   this[luObj.name] = luObj

    // })
  }

  // saveFile(option={path:'',fileName:''}){

  //   console.log(`luaFile save`)

  //   let txt=[]
  //   //先印comments
  //   this.comments.forEach(c=>{
  //     txt.push(`${c}`)
  //   })

  //   for (const key in this) {
  //     if(config.UnSaveProp.includes(key))
  //       continue

  //     if (Object.hasOwnProperty.call(this, key)) {
  //       const element = this[key];
  //       const value=l2j.format(element,{singleQuote:false}).slice(7)
  //       console.log(`luaFile key->${key}`)
  //       console.log(`luaFile format->${value}`)
  //       txt.push(`\n${key}=${value}`)
  //     }
  //   }
  //   let res=txt.join('')
  //   // console.log(`luaFile save result->${res}`)
  //   // console.log(`luaFile save path->${this.path}`)
  //   fs.writeFileSync(this.path,iconv.encode(res,'GB2312') );
  // }
}

class LuaFileObj {
  constructor (obj) {
    let init = obj.init[0]
    if (!init.fields) return
    if (init.fields.length < 1) return

    for (var item of init.fields) {
      console.log(item)
      console.log(`key->${item.key.name}`)
      //console.log(`value->${item.value.raw}`)
      this[item.key.name] = parseLuaFieldObjLv1(item)
    }
  }
}

function parseLuaFieldObjLv1 (obj) {
  console.log(`parse obj lv1 type->${obj.type} key->${obj.key.name} `)
  console.log(
    `parse obj lv1 value type->${obj.value.type}  raw->${obj.value.raw}`
  )

  try {
    switch (obj.value.type) {
      case 'BooleanLiteral':
      case 'NumericLiteral': //數字資料
      case 'StringLiteral': //字串資料
        return getLuaObjValue(obj.value)

      case 'TableConstructorExpression': {
        //物件資料
        if (!obj.value.fields || obj.value.fields.length < 1) return {}

        let tvList = obj.value.fields.filter(o => o.type == 'TableValue')

        if (tvList.length > 0) return tvList.map(o => getLuaObjValue(o.value))

        var o = {}

        for (const data of obj.value.fields) {
          o[data.key.name] = getLuaObjValue(data.value)
        }

        // if(a.length==1 && typeof a[0]==='object')
        //   return a[0]
        return o
      }
    }
  } catch (e) {
    return 'lua obj Lv1 fail->' + e
  }
}

function getLuaObjValue (obj) {
  try {
    switch (obj.type) {
      case 'TableValue': {
        var b = []
        for (const d1 of obj) {
          b.push(getLuaObjValue(d1.value))
        }
        return b
      }

      case 'NumericLiteral': //數字資料
        return Number(obj.raw)
      case 'StringLiteral': {
        //字串資料
        //return obj.raw
        return obj.raw.slice(1).slice(0, -1) //去除頭尾的(")字元
      }
      case 'BooleanLiteral':
        return obj.raw.toBool()
      case 'TableConstructorExpression':
        var o = {}
        var a = []
        for (const d1 of obj.fields) {
          if (d1.type == 'TableValue') {
            //console.log(`lv2 tableValue ${d1.jsonString()}`)
            // o=d1.value.fields.map(d=>{

            //   return getLuaObjValue(d.value)
            // })
            // o=[]
            // let o2={}
            o = {}

            // if(d1.value.fields){
            //   for (const d2 of d1.value.fields) {
            //     o[d2.key.name] = getLuaObjValue(d2.value)
            //   }
            //   a.push(o)
            // }else{
            //   o=getLuaObjValue(d1.value)
            //   a.push(o)
            // }
            o = getLuaObjValue(d1.value)
            a.push(o)
          } else {
            o[d1.key.name] = getLuaObjValue(d1.value)
          }
        }

        if (a.length > 0) return a
        else return o
    }
  } catch (e) {
    return 'get lua obj ->' + JSON.stringify(obj) + '  value fail->' + e
  }
}

function luaToObj (path, back = null) {
  fs.readFile(path, (err, data) => {
    let lua = luaTextToObj(data)
    lua.path = path
    //lua.saveFile()

    if (back) back(lua)
  })
}

function luaTextToObj (data) {
  console.log('load lua file')
  let str = iconv.decode(data, 'GB2312')
  console.log(str)
  // 解析 Lua 腳本
  try {
    // const ast = luaparse.parse(data)
    // console.log(`parse lua`)
    // console.log(ast)
    // console.log('lua body')
    // console.log(ast.body)

    //let lua = new LuaFile(ast.comments[0].value, ast.body)
    //iconv.decode(data, 'GB2312')
    let lua = new LuaFile(str)

    //let test=lua['MahSlot116000195']
    console.log(`luaFile->${lua.jsonString()}`)

    //let escapeKey=['comments','rawTxt','path']
    /**
     * 將空物件轉成空陣列
     */
    let normalLuaData = function (data) {
      // let testArr=["ss","dd"]
      // let testObj={}
      // console.log(`obj type->${typeof testObj}`)
      // console.log(`arr type->${typeof testArr}`)

      if (typeof data != 'object') return
      //if (data.isArr()) return

      //console.log(`normal data->${data.jsonString()}`)

      for (const key in data) {
        // if(escapeKey.indexOf(key)>=0)
        //   continue

        const element = data[key]

        if (typeof element != 'object') continue
        //if (element.isArr()) continue

        let props = element.getProps()
        //console.log(`lua key->${key}  props->${props.length}`)
        if (props.length < 1) {
          //console.log(`empty array->${key}`)
          data[key] = tryObjToArray(element)
        } else {
          //console.log(`element->${element.jsonString()}`)
          normalLuaData(element)
        }
      }
    }

    for (const key in lua) {
      normalLuaData(lua[key])
    }

    //console.log(`luaFile rawTxt->${lua.rawTxt}`)

    // ast.body.forEach(element => {
    //     console.log(element)
    //     let init=element.init
    //     console.log(init[0])
    //     init[0].fields.forEach(p=>{
    //       console.log(p)
    //       console.log(`key->${p.key.name}`)
    //       console.log(`value->${p.value.raw}`)
    //     })

    //     lua.push(new LuaFileObj(element))

    //     // element.variables.forEach(property => {
    //     //     console.log(`---property-->start  name->${property.name}`)
    //     //     console.log(JSON.stringify(property))
    //     //     console.log(`---property-->end`)
    //     //     // console.log(`key->${property.key}`)
    //     //     // console.log(`value->${property.value}`)
    //     // });
    // });
    return lua
    // 這裡可以根據需要處理解析後的數據
  } catch (parseError) {
    console.error('Error parsing the Lua script:', parseError)
    return null
  }
}

export { luaToObj, luaTextToObj }

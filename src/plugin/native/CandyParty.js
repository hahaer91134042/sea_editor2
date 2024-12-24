const ffi = require('ffi-napi')
const ref = require('ref-napi')
const ArrayType = require('ref-array-napi')
const StructType = require('ref-struct-napi')
const path = require('path')
const { Log } = require('@/plugin/Utils')

// 映射到C语言 int数组类型,并导出
const IntArray = ArrayType(ref.types.int)

// console.log(
//   `native MahJongWays path-> ${path.resolve('resources/MahJongWays.dll')} `
// )

// const dll = ffi.Library(path.resolve('resources/MahJongWays.dll'), {
//   RunTest:['void',['int','int','int','pointer']]//下注金額,次數,回傳結果
// })
// const dll = ffi.Library(path.resolve('resources/CandyParty/CandyParty.dll'), {
//   RunTest: ['void', ['pointer']] //下注金額,次數,回傳結果
// })

const dllPath='resources/CandyParty/CandyParty.dll'

/**
{
    "TP": 148956000, //總收益金額
    "TR": 1014, //總共跑了幾次(一般下注+freespin)
    "TRTP": 1489.56, //總收益率(總收益金額/總下注金額)
    "free": //Free spin相關區塊
    { 
        "PfCnt": 7, //中獎次數
        "Rs": 14, //總共跑了幾次freespin
        "TP": 556000 //freespin總收益金額
    },
    "normal": //一般下注區塊
    { 

        "MRTP": 1484.0,//一般下注收益率(一般下注總收益金額 / 總下注金類)
        "PfCnt": 455, //中獎幾次
        "TP": 148400000, //總收益金額
        "getFT": [ //中了freespin的次數 基礎 從12開始 每次+2
            0, //freespin 12次的次數
            1 //freespin 14次的次數
        ],

        "maxPrize": 9840000, //單次下注意最高收益金類(不含freespin)
        "nPfCntPnt": 0.455 //一般下注中獎率(中獎幾次/下注次數)
    }
}
 */
/**
 * 開跑測試
 * @param {{
 * betNum:0,
 * round:0,
 * thread:1,
 * path:'',
 * dir:'',
 * log:'',
 * gameLog:false,
 * gameLv:0
 * }} config betNum:投注金額,round:測試數量,thread:線程數,path:檔案路徑,dir:真實資料夾路徑,log:log資料夾路徑,luaLv:檔位選擇,gameLv:1~3 0:連續,
 * @returns
 */
export function calResult (
  config = {
    betNum: 0,
    round: 0,
    thread: 1,
    path: '',
    dir: '',
    log: '',
    luaLv: 0,
    gameLog: false,
    gameLv: 0
  },
  back = null
) {
  console.log(`calResult config->${config.jsonString()}`)
  Log.print(`calResult config->${config.jsonString()}`, 'CandyParty')
  let input = {
    betAmount: Number(config.betNum),
    runTimes: Number(config.round),
    threadNum: Number(config.thread),
    luaPath: config.path,
    luaFolder: config.dir,
    luaLevel: Number(config.luaLv),
    logFolder: config.log,
    GameLog: config.gameLog,
    GameLevel: Number(config.gameLv)
  }
  console.log(`calResult pointer->${input.jsonString()}`)
  Log.print(`calResult pointer->${input.jsonString()}`, 'CandyParty')
  try {
    let bufferSize=4096
    if (!back) {
      
      const dll = ffi.Library(
        path.resolve(dllPath),
        {
          RunTest: ['void', ['pointer']] //下注金額,次數,回傳結果
        }
      )

      //var res = ref.allocCString(JSON.stringify(input))
      var res = Buffer.alloc(bufferSize)
      res.fill(0)
      res.write(JSON.stringify(input),0,'utf-8')

      dll.RunTest(res)

      //console.log(`calResult result->${ref.readCString(res)}`)

      return JSON.parse(ref.readCString(res))
    }

    let maxRun=1000//最大1000筆
    let runInterval=100 //間隔0.1秒    

    let offset = Math.ceil(input.runTimes / 20)

    offset = offset > maxRun ? maxRun : offset 

    let run = 0
    let runResult = function () {
      run += offset
      run = run < input.runTimes ? run : input.runTimes

      //console.log(`async run->${run}`)

      let obj = {
        betAmount: input.betAmount,
        runTimes:
          input.runTimes - run > offset
            ? offset
            : run % offset == 0
            ? offset
            : run % offset,
        threadNum: input.threadNum,
        luaPath: input.luaPath,
        luaFolder: input.luaFolder,
        luaLevel: input.luaLevel,
        logFolder: input.logFolder,
        GameLog: input.GameLog,
        GameLevel: input.GameLevel
      }
      //console.log(`async run obj->${JSON.stringify(obj)}`)

      let dll = ffi.Library(
        path.resolve(dllPath),
        {
          RunTest: ['void', ['pointer']] //下注金額,次數,回傳結果
        }
      )

      //let res = ref.allocCString(JSON.stringify(obj))
      var res =  Buffer.alloc(bufferSize)
      res.fill(0)
      res.write(JSON.stringify(obj),0,'utf-8')

      dll.RunTest(res)

      //console.log(`async run result->${ref.readCString(res)}`)

      //dll = null

      back(run, JSON.parse(ref.readCString(res)))

      setTimeout(() => {
        if (run < input.runTimes) {
          runResult()
        }
      },runInterval)
    }
    runResult()
    
  } catch (error) {
    Log.print(`calResult error->${error}`)
  }

  return null

  // return {
  //     TRTP: 1348.8,
  //     free: { ProfitCnt: 0, Rs: 0, TP: 0 },
  //     normal: {
  //       MRTP: 1348.8,
  //       ProfitCnt: 51,
  //       TP: 13488000,
  //       getFT: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  //     }
  //   }
}

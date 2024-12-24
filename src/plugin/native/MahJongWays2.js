const ffi = require('ffi-napi')
const ref = require('ref-napi')
const ArrayType = require('ref-array-napi')
const StructType = require('ref-struct-napi')
const path = require('path')

// 映射到C语言 int数组类型,并导出
const IntArray = ArrayType(ref.types.int)

// console.log(
//   `native MahJongWays path-> ${path.resolve('resources/MahJongWays.dll')} `
// )

const dll = ffi.Library(path.resolve('resources/MahJongWays.dll'), {
  RunTest:['void',['int','int','pointer']]//下注金額,次數,回傳結果
})

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
 * @param {*} config {betNum:0,round:0}
 * @returns  
 */
export function calResult (config = {betNum:0,round:0,path:''}) {
    console.log(`501 calResult config->${config.jsonString()}`)
    return new Promise((resolve,reject)=>{
        try {
            var res=ref.allocCString(config.path)
            console.log(`501 calResult pointer->${res}`)
            dll.RunTest(Number(config.betNum),Number(config.round),res)
        
            resolve(JSON.parse(ref.readCString(res)))
        } catch (error) {
            reject(error)
        }

    })



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

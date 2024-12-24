const ffi = require('ffi-napi')
const ref = require('ref-napi')
const ArrayType = require('ref-array-napi')
const StructType = require('ref-struct-napi')
const path = require('path')

// 映射到C语言 int数组类型,并导出
const IntArray = ArrayType(ref.types.int)


console.log(`electron ${path.resolve('resources/hello.dll')} `)
/**
 *      int n;
        string s;
        string str;
        vector<int> vec;
 */
const MyData=StructType({
  n:ref.types.int,
  s:ref.types.CString,
  str:ref.types.CString,
  vec:IntArray
})

const MyData2=StructType({
  a:ref.types.int,
  b:ref.types.int,
  result:ref.types.int
})

const test=ffi.Library(path.resolve('resources/hello.dll'),{
    add:[ref.types.int,['int','int']],
    sub:['int',['int','int']],
    multi:['int',['int','int']],
    divi:['int',['int','int']],
    addDouble:['double',['double','double']],
    subDouble:['double',['double','double']],
    multiDouble:['double',['double','double']],
    diviDouble:['double',['double','double']],
    addPtr: ['void', ['int', 'int', 'int*']],
    initArray: ['void', [IntArray, 'int']],
    sayHi:['void',['pointer']],
    myFunction:['void',[MyData]],
    myFunction2:[MyData2,[MyData2]]
    //sayHi2:['string',['string']]
})


// let dllFilePath = path.resolve('resources/hello.dll')
// const MyDellDemo = new ffi.Library(dllFilePath, {
//   // 方法名必须与C函数名一致
//   add: [
//     'int', // 对应 C函数返回类型
//     ['int', 'int'] // C函数参数列表
//   ],
// })
export function myFun(data){
  let my=new MyData()
  my.s=data.s
  my.n=data.n
  my.str=data.str
  my.vec=new IntArray(1)
  test.myFunction(my)
  console.log(my)
}
export function myFun2(data){
  let my=new MyData2()
  my.a=data.a
  my.b=data.b
  my.result=0
  let r= test.myFunction2(my)
  console.log(r)
}
export function initArray(num){
  let arr=new IntArray(Number(num))
  test.initArray(arr,Number(num))
  let a=[]
  for (var i = 0; i < arr.length; i++) {
    //console.log(arr[i])
    a.push(arr[i])
  }
  return a
}

export function add(x, y) {
  return test.add(x, y)
}
export function sub(x, y) {
  return test.sub(x, y)
}
export function divi(x, y) {
  return test.divi(x, y)
}
export function multi(x, y) {
  return test.multi(x, y)
}

export function addDouble(x, y) {
  return test.addDouble(x, y)
}

export function subDouble(x, y) {
  return test.subDouble(x, y)
}
export function diviDouble(x, y) {
  return test.diviDouble(x, y)
}
export function multiDouble(x, y) {
  return test.multiDouble(x, y)
}

export function sayHi(name){
  var hi=ref.allocCString(name)
  test.sayHi(hi)
  return ref.readCString(hi)
}

// export function sayHi2(name){
//   return test.sayHi2(ref.writeCString(name))
// }
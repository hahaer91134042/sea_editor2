console.log('electron preload')

//通用Model start

function Exception (msg) {
  this.message = msg
}
//通用Model end

// 擴展函式 start
Object.defineProperty(Object.prototype, 'jsonString', {
  value () {
    return JSON.stringify(this)
  }
})

Object.defineProperty(String.prototype, 'jsonParse', {
  value () {
    return JSON.parse(this)
  }
})


Object.defineProperty(Array.prototype, 'first', {
  value (fun) {
    if (fun) {
      return this.find(fun)
    }
    return this.find(e => true) // or this.find(Boolean)
  }
})

Object.defineProperty(Array.prototype, 'remove', {
  value (obj) {    
    if(typeof obj =='number'){
      return this.splice(obj, 1);
    }

    if (typeof obj != 'function')
      throw new Exception('Need condition function and return boolean value')
    let l=this.filter(v => !obj(v))
    this.splice(0,this.length)
    //l.forEach(i=>this.push(i))
    this.push(...l)
    // this.push.apply(this, l)
    return this.length

    //return this.filter(v => !obj(v))
  }
})

Array.prototype.clear=function(){
  this.splice(0,this.length)
}

Array.prototype.sum=function(fun){
  return this.reduce((a,b)=>{
    if(fun)
      return a+fun(b)
    else
      return a+b
  },0)
}

Array.prototype.max = function () {
  return Math.max.apply(null, this);
};

Array.prototype.min = function () {
  return Math.min.apply(null, this);
};

String.prototype.cleanChar=function(){
    var specialChars = '!@#$^&%*()+=-[]\/{}|:<>?,.';
    
    let self=this
    //console.log('clean char->'+self)
    for (var i = 0; i < specialChars.length; i++) {
      self =self.replace(new RegExp('\\' + specialChars[i],'g'),'');
    }
    return self
}

String.prototype.toBool=function(){
    return (this + '').toLowerCase() === 'true';
}

// string.prototype.toNum=function(){
//   return Number(this+'')
// }
Object.defineProperty(Object.prototype, 'toNum', {
  value () {
    return Number(this+'')
  }
})


//這個format 使用%s來標記要替換的字串位置(按順序)
String.prototype.format = function () {
  return [...arguments].reduce((p, c) => p.replace(/%s/, c), this)
}

Object.defineProperty(Object.prototype, 'isArr', {
  value () {
    return Array.isArray(this)
  }
})

Object.defineProperty(Object.prototype, 'copy', {
  /**
   * 複製對象內的properties
   * @param {*} obj 目標對象 為空時會回傳新的複製物件
   * @param {boolean} allowNull 當對象無該property時是否設置null 
   */
  value (obj=null,allowNull=false) {
    if(!obj){
      let b={}
      for (const key in this) {
        b[key]=this[key]
      }
      return b
    }else{
      for (const key in this) {
        if (Object.hasOwnProperty.call(obj, key)) {
          //const v = obj[key];
          this[key]=obj[key]
        }else{
          if(allowNull)
            this[key]=null
        }      
      }
    }    
  }
})

Object.defineProperty(Object.prototype, 'also', {
  value (fun) {
    fun(this)
    return this
  }
})

Object.defineProperty(Object.prototype, 'let', {
  value (fun) {
    return fun(this)
  }
})

Object.defineProperty(Object.prototype, 'clazz', {
  value () {
    //有需要再新增加
    let cn = this.constructor.name
    return {
      name: cn
    }
  }
})

Object.defineProperty(Object.prototype,'getProps',{
  value(fun){
    let a=[]
    for (const key in this) {
      if (Object.hasOwnProperty.call(this, key)) {
        a.push({key:key,value:this[key]})
      }
    }
    if(fun)
      a.forEach(p=>fun(p.key,p.value))
    return a
  }
})


//end

window.sea = (function () {
  var sea = {msg:'hi sea'}
  return sea
})()

const {ApiAction} =require('../src/config/Enum') 

const {ipcRenderer } = require('electron')

console.log(`preload api action->${ApiAction.jsonString()}`)

window.ipcApi={
  ping:(args)=>ipcRenderer.invoke(ApiAction.Ping,args),

  onOpenSettingPage:function(back){
    ipcRenderer.invoke(ApiAction.OpenSettingPage,back)
  },

  // openDir:async function(){
  //   let res=await ipcRenderer.invoke(ApiAction.OpenDir)

  //   return res
  // },
  // openFile:async function(remote){
  //   let res=await ipcRenderer.invoke(ApiAction.OpenFile,remote)
  //   return res
  // },
  // openMultiFile:async function(){
  //   let res=await ipcRenderer.invoke(ApiAction.OpenMultiFile)
  //   return res
  // }
}

// contextBridge.exposeInMainWorld('ipcApi', {
//   ping:(args)=>ipcRenderer.invoke('ping',args)
//   //openFile: () => ipcRenderer.invoke('dialog:openFile')
// })

window.addEventListener('DOMContentLoaded', () => {
  console.log(`preload onLoad over sea->${window.sea.jsonString()}`)
  //window.ipcRenderer = require('electron').ipcRenderer;
  //console.log(`preload onLoad electron ipc->${ipcRenderer}`)
})

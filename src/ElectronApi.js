
const { remote } = require('electron')
const {ipcRenderer}=require('electron')
const {ApiAction}=require('@/config/Enum')
const {path}= require('path')


module.exports={
  openDir:function(){
    return remote.dialog.showOpenDialog({
      properties: ['openDirectory'],
      defaultPath: ''
    })
  },
  openFile:function(){
    return remote.dialog.showOpenDialog({
      properties: ['openFile'],
      defaultPath:''
    })        
  },
  openMultiFile:function(){
    return remote.dialog.showOpenDialog({
      properties: ['openFile','multiSelections'],
      defaultPath:''
    })        
  },
  saveAsFile:function(path=''){
    return remote.dialog.showSaveDialog({
      defaultPath:path,
      properties:['createDirectory'],
      filters:[{ name: 'lua', extensions: ['lua'] }]
    })
  },
  getAppPath:function(){
    console.log(`path home->${remote.app.getAppPath('home')}`)
    console.log(`path appData->${remote.app.getAppPath('appData')}`)
    console.log(`path useData->${remote.app.getAppPath('userData')}`)
    return remote.app.getAppPath()
  },
  IpcEvent:{
    onMenuSetting(back){
      ipcRenderer.on(ApiAction.OpenSettingPage,back)
    }
  },
  getSettingConfig:function (){
    return ipcRenderer.invoke(ApiAction.GetSettingConfig)
  },
  setSettingConfig:function(c){
    ipcRenderer.invoke(ApiAction.SetSettingConfig,c)
  }
}


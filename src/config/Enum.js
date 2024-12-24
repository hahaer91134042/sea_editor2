// const ApiAction={
//     Ping:'ping',
//     OpenDir:'dialog:openDir'
// }

module.exports = {
  ApiAction: {
    Ping: 'ping',
    OpenDir: 'dialog:openDir',
    OpenFile: 'dialog:openFile',
    OpenMultiFile: 'dialog:openMultiFile',
    OpenSettingPage: 'view:openSettingPage',
    GetSettingConfig:'config:getSettingValue',
    SetSettingConfig:'config:setSettingValue'
  },
  Page: {
    Main: 'main',
    Freespin: 'freespin',
    Jp: 'jp'
  },
  KO: {
    Multiple: 0,
    Quota: 1
  },
  ProvideFlag:{
    lua:'lua',
    free:'free',
    jp:'jp',
    parent:'parent',
    setConfig:'settingConfig',
    log:'log:msg'
  }
}

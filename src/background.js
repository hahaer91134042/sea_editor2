'use strict'

import { app, protocol, Menu, BrowserWindow, ipcMain } from 'electron'
import { createProtocol } from 'vue-cli-plugin-electron-builder/lib'
import installExtension, { VUEJS3_DEVTOOLS } from 'electron-devtools-installer'
import { ApiAction } from './config/Enum.js'
const fs = require('fs')
const { MenuTxt } = require('./config/Lang.js')
const appConfig = require('@/config/AppConfig.js')
//import ipcApis from '@/IpcApi'

const isDevelopment = process.env.NODE_ENV !== 'production'
const isMac = process.platform === 'darwin'

var dirs = [
  './_Log' //log 資料夾
]
dirs.forEach(dir => {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir)
  }
})

// app.commandLine.appendSwitch('remote-debugging-port', '8315')
// app.commandLine.appendSwitch('host-rules', 'MAP * 127.0.0.1')


let setting = appConfig.init()

// const electronApis=[
//   {
//     name:'ping',
//     action:function(event,args){
//       console.log('这里是主进程pong', args)
//       return '你好 我是主进程'
//     }
//   }
// ]

//開啟dialog功能在release版的時候會失效 可能之後ipc不這麼實用
const ipcApis = [
  {
    name: ApiAction.Ping,
    action: function (event, args) {
      console.log('这里是主进程pong', args)
      return '你好 我是主进程'
    }
  },
  {
    name: ApiAction.GetSettingConfig,
    action: function () {
      //console.log(`get setting config->${JSON.stringify(setting)}`)
      return setting
    }
  },
  {
    name:ApiAction.SetSettingConfig,
    action:function(event,set){
      console.log(`set setting config->${JSON.stringify(set)}`)
      setting=set

      
      setProjMenu()

      appConfig.save(setting)
    }
  }
]

const Event = {
  onOpenSettingPage () {
    BrowserWindow.getFocusedWindow().webContents.send(ApiAction.OpenSettingPage)
  }
}



function setProjMenu(){
  const menuTemplate = [
    // { role: 'appMenu' }
    ...(isMac
      ? [
          {
            label: app.name,
            submenu: [
              // { role: 'about' },
              // { type: 'separator' },
              // { role: 'services' },
              // { type: 'separator' },
              // { role: 'hide' },
              // { role: 'hideOthers' },
              // { role: 'unhide' },
              // { type: 'separator' },
              { role: 'quit' }
            ]
          }
        ]
      : []),
    // { role: 'fileMenu' }
    {
      label: 'File',
      submenu: [isMac ? { role: 'close' } : { role: 'quit' }]
    },
    // { role: 'editMenu' }
    {
      label: MenuTxt[setting.lang.use].edit,
      submenu: [
        // { role: 'undo' },
        // { role: 'redo' },
        { type: 'separator' },
        {
          label: MenuTxt[setting.lang.use].setting,
          click: function () {
            console.log(`---Menu setting click---`)
            Event.onOpenSettingPage()
          }
        }
      ]
    },
    {
      role: 'help',
      submenu: [
        {
          label: MenuTxt[setting.lang.use].contact_us,
          click: async () => {
            const { shell } = require('electron')
            await shell.openExternal('https://www.seagamingco.com/home/index/')
          }
        }
      ]
    }
  ]
  
  const menu = Menu.buildFromTemplate(menuTemplate)
  Menu.setApplicationMenu(menu)
}


setProjMenu()

// Scheme must be registered before the app is ready
protocol.registerSchemesAsPrivileged([
  { scheme: 'app', privileges: { secure: true, standard: true } }
])

async function createWindow () {
  // Create the browser window.
  const win = new BrowserWindow({
    width: 1680,
    height: 960,
    webPreferences: {
      // Use pluginOptions.nodeIntegration, leave this alone
      // See nklayman.github.io/vue-cli-plugin-electron-builder/guide/security.html#node-integration for more info
      // nodeIntegration: process.env.ELECTRON_NODE_INTEGRATION,
      // contextIsolation: !process.env.ELECTRON_NODE_INTEGRATION
      nodeIntegration: true,
      nodeIntegrationInWorker:true,
      contextIsolation: false,
      enableRemoteModule: true,
      webSecurity: false,
      preload: __static + '/preload.js'
      //preload: path.join(__dirname, "./src/preload.js")
    }
  })

  /**
   * load ipc api
   */
  ipcApis.forEach(api => {
    ipcMain.handle(api.name, api.action)
  })

  // 顺便这里放一个主进程的监听
  // ipcMain.on('ping', (e, args) => {
  //   console.log('这里是主进程pong', args)
  //   e.sender.send('pong', '你好 我是主进程')
  // })

  if (process.env.WEBPACK_DEV_SERVER_URL) {
    // Load the url of the dev server if in development mode
    await win.loadURL(process.env.WEBPACK_DEV_SERVER_URL)
    if (!process.env.IS_TEST) win.webContents.openDevTools()
  } else {
    createProtocol('app')
    // Load the index.html when not in development
    win.loadURL('app://./index.html')
  }
}

// Quit when all windows are closed.
app.on('window-all-closed', () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (BrowserWindow.getAllWindows().length === 0) createWindow()
})

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', async () => {
  if (isDevelopment && !process.env.IS_TEST) {
    // Install Vue Devtools
    try {
      await installExtension(VUEJS3_DEVTOOLS)
    } catch (e) {
      console.error('Vue Devtools failed to install:', e.toString())
    }
  }
  createWindow()
})

// Exit cleanly on request from parent process in development mode.
if (isDevelopment) {
  if (process.platform === 'win32') {
    process.on('message', data => {
      if (data === 'graceful-exit') {
        app.quit()
      }
    })
  } else {
    process.on('SIGTERM', () => {
      app.quit()
    })
  }
}

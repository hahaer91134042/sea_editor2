<template>
  <div class="home">
    <div class="row m-2" style="width:1000px;padding:10px;">
      <div class="col col-7" style="">

        <div class="input-group">
          <input type="text" style="" readonly v-model="selectFile.path" @click="selectFile.openFileDialog()"
            class="form-control" :placeholder="$t('please_select_profile')" v-tooltip :title="selectFile.path"
            data-bs-placement="bottom" />
          <!-- <input type="file" style="" @change="onFileChanged($event)" class="form-control" :placeholder="$t('please_select_profile')" /> -->
          <!-- <button class="btn btn-outline-secondary" type="button" id="">Button</button> -->
          <button type="button" style="width:70px;height:40px;" @click="onOpenFile()" class="btn btn-outline-secondary">
            {{ $t('open') }}
          </button>
          <button type="button" style="width:70px;height:40px;" @click="onSaveLua()" class="btn btn-outline-secondary">
            {{ $t('save') }}
          </button>
          <button type="button" style="width:70px;height:40px;" @click="onSaveAsLua()"
            class="btn btn-outline-secondary">
            {{ $t('saveAs') }}
          </button>
          <!-- <button class="btn btn-outline-secondary" @click="testImport()" style="width:70px;height:40px;" >
            test
          </button> -->
        </div>

      </div>


      <div class="col" style="">
        <select v-model="tempName" class="form-select">
          <option disabled value="">--{{ $t('gameTemp') }}--</option>
          <option v-for="(item, i) in SupportTemp.List()" :key="i" :value="item.flag">{{ $t(item.name) }}({{ item.flag
            }})
          </option>
        </select>
        <!-- <div class="form-floating">
          <select v-model="tempName" class="form-select">
            <option v-for="(item, i) in SupportTemp" :key="i" :value="item.flag">{{ item.name }}({{ item.flag }})</option>
          </select>
          <label>{{ $t('gameTemp') }}</label>
        </div> -->
      </div>
    </div>
    <!-- Nav tabs -->
    <ul class="nav nav-tabs ps-2" id="myTab" role="tablist">

      <template v-for="(t, i) in gameTemp.tabs" :key="`${tempName}_${i}`">
        <li class="nav-item" role="presentation">
          <button :class="t.init ? 'active' : ''" class="nav-link" :id="`tab_${t.flag}`" data-bs-toggle="tab"
            :data-bs-target="`#page_${t.flag}`" :aria-controls="`page_${t.flag}`" type="button" role="tab"
            aria-selected="true">
            {{ $t(t.name) }}
          </button>
        </li>
      </template>

    </ul>

    <!-- Tab panes -->
    <div class="tab-content overflow-y-auto " :style="{ height: `${viewStyle.main.h}px` }" style="">

      <template v-for="(t, i) in gameTemp.tabs" :key="`${tempName}_${i}`">
        <div :class="t.init ? 'active' : ''" class="tab-pane" :id="`page_${t.flag}`" role="tabpanel"
          :aria-labelledby="`tab_${t.flag}`">
          <component :is="t.view"  />
        </div>
      </template>

    </div>
    <!-- :style="{ height: `${viewStyle.console.h}px` }" -->
    <div class=" border-1 border-top" style="">
      <div class=" border border-1 border-secondary bg-light d-flex  flex-row p-1" style="height: 35px;">
        <input style="width: 200px;" type="text" v-model="consoleView.search" class="form-control"
          placeholder="內容搜尋..." />
        <select class="form-select form-select-sm ms-2" v-model="consoleView.selectType"
          :style="consoleView.selectStyle" style="width: 100px;font-size: 12px;">
          <option selected value="-1" style="background-color:white;color: black;">全部</option>
          <option value="0" style="background-color:white;color: black;">Debug</option>
          <option value="1" style="background-color:gold ;color:white;">warn</option>
          <option value="2" style="background-color:red ;color:white;">error</option>
        </select>
        <div class="col d-flex flex-row-reverse ">
          <button type="button" class=" me-1 btn btn-outline-danger fs-7 pt-0 pb-0" @click="consoleView.clearLog()">
            {{ $t("clean") }}
          </button>
        </div>


      </div>

      <div class="overflow-y-auto ps-2" :style="{ height: `${viewStyle.console.h}px` }"
        style="background-color: black;">

        <template v-for="(m) in consoleView.result" :key="m.id">
          <div class=" d-flex  flex-row " style="text-align: start;">
            <span class="" style="color: white;width: auto;">{{ m.time }}</span>
            <span class=" badge " v-show="m.flag"
              :style="{ backgroundColor: m.type == 1 ? 'gold' : m.type == 2 ? 'red' : 'white' }"
              style="color:black;width: auto;height: 23px;">{{ m.flag }}</span>
            <span class="col "
              :style="{ color: m.type == 1 ? 'gold' : m.type == 2 ? 'red' : 'white', width: `${viewStyle.console.w * 0.6}px` }"
              style="">: {{ m.msg }}</span>
          </div>
        </template>

      </div>

    </div>




    <!-- <router-link to="/about">About</router-link> -->
  </div>
  <MsgDialog ref="dialog">

  </MsgDialog>

  <ProgressDialog ref="progress" :msg="progressMsg"></ProgressDialog>
</template>

<script setup>
// @ is an alias to /src
//import HelloWorld from '@/components/HelloWorld.vue'
import { ref, provide, defineAsyncComponent, watch, reactive, computed, getCurrentInstance } from 'vue';
import { Lang } from '@/config/Lang'
import * as GameConfig from '@/config/GameConfig'
import { SupportTemp } from '@/config/TempleteConfig'
import MsgDialog from '@/views/components/MsgDialog.vue'
import ProgressDialog from '@/views/components/ProgressDialog.vue'
import * as _ from 'lodash'
import { luaToObj } from '@/plugin/Parser'
import { saveLuaFile, parseFilePath, Log, Screen } from '@/plugin/Utils'
import { ProvideFlag, Page } from '@/config/Enum'
import moment from 'moment';


const api = require("@/ElectronApi")
//const app=require('@/config/AppConfig')

// let screenW=screen.width
// let screenH=screen.height



new Screen().onChange((w, h) => {
  console.log(`Home window resize w->${w} H->${h}`)
  viewStyle.main.setH(h)
  viewStyle.console.setH(h)
  viewStyle.console.setW(w)
})

const viewStyle = reactive({
  main: {
    h: 0,
    setH(h) {
      viewStyle.main.h = h * 0.67//百分比
    }
  },
  console: {
    h: 0,
    w: 0,
    setH(h) {
      viewStyle.console.h = h * 0.16
    },
    setW(w) {
      viewStyle.console.w = w
    }
  }
})

viewStyle.main.setH(window.innerHeight)
viewStyle.console.setH(window.innerHeight)
viewStyle.console.setW(window.innerWidth)


let log = {
  debug(m) {
    consoleView.add(0, m)
  },
  warn(m) {
    consoleView.add(1, m)
  },
  error(m) {
    consoleView.add(2, m)
  }
}

// watch(log, () => {

//   console.log(`Home log change->${log.value.jsonString()}`)
// }, { deep: true })


let consoleView = reactive({
  list: [],
  search: '',
  selectType: -1,
  selectStyle: computed({
    get: function () {
      let s = {
        backgroundColor: 'white',
        color: 'black'
      }


      if (consoleView.selectType == 1) {
        s.backgroundColor = 'gold'
        s.color = 'white'
        return s
      }
      if (consoleView.selectType == 2) {
        s.backgroundColor = 'red'
        s.color = 'white'
        return s
      }

      return s
    }
  }),
  result: computed({
    get: function () {
      let a = consoleView.selectType == -1 ? consoleView.list
        : consoleView.list.filter(o => o.type == consoleView.selectType)

      if (consoleView.search.length > 0) {
        a = a.filter(o => {
          return (`${o.msg}`.indexOf(`${consoleView.search}`) != -1) || (o.flag ? (`${o.flag}`.indexOf(`${consoleView.search}`) != -1) : false)
        })
      }


      //console.log(`log result->${a.jsonString()}`)
      return a
      //return _.orderBy(a, 'id', 'desc')
    }
  }),
  add(t, m) {
    let now = moment()
    let obj = {
      id:consoleView.list.length==0?1:consoleView.list.first().id + 1,
      type: t,
      time: now.format(`${GameConfig.Common.format.fullTime}`)
    }
    //console.log(`Home log list new id->${obj.id}`)   

    if (typeof m == 'string') {
      obj.msg = m
    } else {
      obj.msg = m.msg
      if (m.flag)
        obj.flag = m.flag
      else
        obj.flag = tempName.value
    }

    // consoleView.list.push(obj)
    // consoleView.list=_.orderBy(consoleView.list, 'id', 'desc')
    
    var len=consoleView.list.length
    //新log加入到第一個
    consoleView.list=[obj]
    .concat(len<1?[]:_.slice(consoleView.list,0,len<9?len:9))
    
    // if(consoleView.list.length>10){
    //   consoleView.list=_.slice(consoleView.list,0,10)
    // }
    
    //console.log(`Home log list length->${consoleView.list.length}`)   

    //console.log(`Home log change->${consoleView.list.jsonString()}`)
  },
  clearLog() {
    consoleView.list.clear()
  }
})







//let setting= app.init()
// api.getSettingConfig()
// .then(config=>{
//   console.log(`app setting obj->${config.jsonString()}`)
//   config.lang.use='sc'
//   api.setSettingConfig(config)
// })


//Log.print(`app path->${api.getAppPath()} dir=${__dirname}`)

// const { proxy } = getCurrentInstance()
// console.log(`lodash->${_.add(1, 2)}`)
// console.log(`global test->${JSON.stringify(proxy.test)}`)
//appCon

//模板選擇 之後還要改目前先這樣
//let tempName = ref(SupportTemp.first(t => t.isSelect).flag)
let tempName = ref('')



/**
 * 畫面上顯示分頁控制項
 */
let gameTemp = reactive({
  page: SupportTemp.DefaultPage,
  tabs: computed({
    get: () => gameTemp.page.Tabs.map(t => {
      return {
        name: t.name,
        flag: t.flag,
        init: t.init ? t.init : false,
        view: defineAsyncComponent(() => t.view)
      }
    })
  }),

})


watch(tempName,() => {
  console.log(`select temp flag->${tempName.value}`)
  log.debug(`select game templete:${tempName.value}`)
  let config = SupportTemp.Page[tempName.value]
  if (config) {
    gameTemp.page = config    
    clearLuaFile() 
  }


})
/**
 * GameDataFlag see GameConfig>GameDataFlag class
 */
let luaName = null

//let inputFile = ref(null)
let luaFile = ref({})

let luaData = ref(null)//main
let luaData_FreeSpin = ref(null)
let luaData_Jp = ref(null)


// let jsNum = ref(100)

// watch(jsNum, (now, old) => {

//   console.log(`Home num watch change->${now}`)
// })

watch(luaFile,
  (now) => {
    if (!luaName)
      return

    console.log(`Home watch lua main->${luaFile.value[luaName[Page.Main]]?.jsonString()}`)
    //console.log(`Home watch lua freespin->${luaFile.value[luaName[Page.Freespin]]?.jsonString()}`)
    log.debug({
      flag: "Lua Update",
      msg: `${{}.also(o => {
        if (luaData.value)
          o[luaName[Page.Main]] = luaData.value
        if (luaData_FreeSpin.value)
          o[luaName[Page.Freespin]] = luaData_FreeSpin.value
        if (luaData_Jp.value)
          o[luaName[Page.Jp]] = luaData_Jp.value
      }).jsonString()}`
    })
    //console.log(`Home watch lua freespin->${luaFile.value[luaName.freespin]?.jsonString()}`)
    //console.log(`Home watch lua bets->${luaFile.value[luaName].bets.jsonString()}`)
    //console.log(`Home watch lua objs->${luaFile.value[luaName].objs.jsonString()}`)
    //console.log(`Home watch lua prize->${luaFile.value[luaName].prize_multi.jsonString()}`)
    //console.log(`Home watch lua roll_slots->${luaFile.value[luaName].roll_slots.jsonString()}`)

  },
  { deep: true }
)



let selectFile = reactive({
  path: '',
  openFileDialog: function () {
    if (tempName.value.length < 1) {
      dialog.value.show({ msg: window.$t('please_select_template') })
      return
    }
    // remote.dialog.showOpenDialog({
    //     properties: ['openDirectory'],
    //     defaultPath: ''
    // }).then(res => {
    //     console.log('selected directory:' + res.filePaths[0]);
    //     //dirPath.value = res.filePaths[0]
    // });
    api.openFile()
      .then(res => {
        console.log(`open file->${res.jsonString()}`)
        if (!res.canceled) {
          selectFile.path = res.filePaths[0]
        } else {
          selectFile.path = ''
        }
        log.debug(`select file :${selectFile.path}`)
      })
  }
})


function onOpenFile() {
  if (selectFile.path.length > 0) {
    //console.log(inputFile)
    console.log(`file path->${selectFile.path}`)
    //console.log(`file text->${await luaFile.value.text()}`)
    //JSON.stringify
    luaToObj(selectFile.path, (lua) => {
      setLuaFile(lua)

    })
  }
}

function setLuaFile(lua) {
  //luaName = `${tempName.value}${parseFilePath(lua.path).shortName}`;
  luaName = GameConfig[tempName.value].dataFlag(tempName.value, parseFilePath(lua.path).shortName)
  console.log(`luaName->${luaName.jsonString()}`)
  luaFile.value = lua
  let data = luaFile.value[luaName[Page.Main]]
  //console.log(`Home lua data->${data}`)
  if (!data) {
    //console.log('lua檔案是空值')
    dialog.value.show({ msg: window.$t('wrong_profile_selection') })
    return
  }
  luaData.value = data
  //luaData_FreeSpin.value = luaFile.value[`${luaName}_FreeSpin`]
  luaData_FreeSpin.value = luaFile.value[luaName[Page.Freespin]]
  luaData_Jp.value = luaFile.value[luaName[Page.Jp]]
}

function clearLuaFile() {
  log.warn(`clear lua file :${selectFile.path}`)
  luaName = null
  luaFile.value = {}
  luaData.value = null
  luaData_FreeSpin.value = null
  selectFile.path = ''
}

// let overAllRef = ref(null)
// let mainGameRef = ref(null)
/**
 * 用原檔案路徑save
 */
function onSaveLua() {
  // let od = overAllRef.value.data()
  // console.log(`get over all data->${od}`)
  log.warn({
    flag: 'save file',
    msg: `lua file save ${luaFile.value.path}`
  })
  if (luaFile.value.path)
    saveLuaFile(luaFile.value)
  else
    dialog.value.show({ msg: window.$t('please_select_profile') })
  //luaFile.value.saveFile()
}

let lastSavePath = ''
/**
 * 用選擇的路徑save
 */
function onSaveAsLua() {
  api.saveAsFile()
    .then(res => {
      console.log(`onSaveAsLua->${res.jsonString()}`)
      if (!res.canceled) {
        lastSavePath = res.filePath
        let oriName = parseFilePath(luaFile.value.path).shortName
        let fixName = parseFilePath(lastSavePath).shortName
        console.log(`onSaveAsLua file name ori->${oriName} fix->${fixName}`)
        log.warn({
          flag: 'save file',
          msg: `lua file save as ${lastSavePath}/${fixName}`
        })
        saveLuaFile(luaFile.value,
          {
            path: lastSavePath,
            fileName: {
              ori: oriName,
              fix: fixName
            }
          })

      }

    })
}

let progress = ref(null)
let dialog = ref(null)
let progressMsg=ref('')
let parent = {
  saveLua: function () {
    onSaveLua()
  },
  getLoadFilePath: function () {
    return luaFile.value.path
  },
  progress: {
    show: function (fun) {
      progress.value.show()
      if (fun) {
        //延遲0.7秒讓progress先顯示
        setTimeout(fun, 700)
      }
    },
    hide: function () {
      progress.value.hide()
      progressMsg.value=''
    },
    setMsg: function (m) {
      console.log(`Home progress set msg->${m}`)
      progressMsg.value=m
    },
    clearMsg: function () {
      progressMsg.value=''
    }
  },
  showDialog: function (option = { title: '', msg: '', checked: null }) {
    console.log(`Home show Dialog`)
    // option={
    //   title:'title123',
    //   msg:'Msg 123456',
    //   checked:function(){
    //     console.log(`Home dialog checked--`)
    //   }
    // }


    dialog.value.show(option)
    // dialog.value.checked=function(){
    //   console.log(`Home dialog checked--`)
    // }
  }
}

// async function testImport(){
//   let config = await import(`@/config/GameConfig`)
//   let ma=config['MahJongWays']
//   console.log(`import ma->${ma.createInitFile().jsonString()}`)
// }

//依賴注入只有在parent的setup裡面才會生效
provide(ProvideFlag.lua, luaData)
provide(ProvideFlag.free, luaData_FreeSpin)
provide(ProvideFlag.jp,luaData_Jp)
provide(ProvideFlag.parent, parent)
provide(ProvideFlag.log, log)

// export default {
//   name: 'HomeView',
//   components: {
//     HelloWorld
//   }
// }
</script>

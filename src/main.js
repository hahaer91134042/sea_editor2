import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import $ from 'jquery'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap'
import { library } from '@fortawesome/fontawesome-svg-core'
import {
  faPhone,
  faPlus,
  faCirclePlus,
  faCircleXmark,
  faArrowLeft,
  faXmark,
  faClone,
  faTableColumns
} from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { tooltip, popover } from '@/plugin/BootstrapTool'
import i18n from './i18n'

library.add(
  faPhone,
  faPlus,
  faCirclePlus,
  faCircleXmark,
  faArrowLeft,
  faXmark,
  faClone,
  faTableColumns
)

//import * as _ from 'lodash'
let test = [1, 2, 3]
console.log(
  `main sea->${window.sea.jsonString()} test->${test.jsonString()}  first->${test.first(
    i => i == 2
  )}`
)

//window.ipcRenderer = window.require('electron').ipcRenderer

const app = createApp(App).use(i18n)
//console.log(`main lodash->${_}`)
//app.config.globalProperties.test={msg:'hi'}//用這方式傳遞參數不好用
window.$t = i18n.global.t

app.use(router)

app.directive('tooltip', tooltip).directive('popover', popover)

app.component('fa-icon', FontAwesomeIcon)

app.mount('#app')

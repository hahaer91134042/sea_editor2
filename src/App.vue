<template>
  <!-- <nav>
    <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link>
  </nav> -->
  <router-view />
</template>

<script setup>
import { onMounted, provide, ref, watch } from 'vue'
import { IpcEvent } from '@/ElectronApi'
import { Page } from '@/router/Page'
import { ProvideFlag } from '@/config/Enum'
//import moment from 'moment';
import { useI18n } from "vue-i18n";

const api = require('@/ElectronApi')
const i18 = useI18n()




let setConfig = ref({})


api.getSettingConfig()
  .then(c => {
    console.log(`App getSetConfig->${c.jsonString()}`)
    setConfig.value = c
    i18.locale.value = c.lang.use
  })



$(async function () {

  console.log(`app onLoad`)


  let pong = await window.ipcApi.ping('你好呀，我是渲染进程123')
  console.log('渲染进程===我收到啦', pong)
  // window.ipcRenderer.on('pong', (e, arg) => {
  //   console.log('渲染进程===我收到啦', arg)
  // })
  // 渲染进程发送事件===这个可以放到一个点击事件里面去触发
  //window.ipcRenderer.send('ping', '你好呀，我是渲染进程')
})

//const router=useRouter()


onMounted(() => {

  IpcEvent.onMenuSetting(() => {
    console.log(`---App on Menu setting---`)
    Page.goSetting()


  })
})

// let time1='2023-03-20 11:22:33'

// let time=moment(time1,'YYYY-MM-DD hh:mm:ss')

// let time2=time.format('YYYY/MM/DD hh|mm|ss')

// console.log(`---moment---`)
// console.log(`time1->${time1}`)
// console.log(`time2->${time2}`)

provide(ProvideFlag.setConfig, setConfig)

</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.grid-view-y-1 {

  padding: 5px;
  text-align: start;
  overflow-y: auto;

}

.grid-view-y-2 {
  display: grid;
  /* grid-template-columns: 6ch auto; */
  overflow-y: scroll;
  padding: 10px;
  grid-template-columns: repeat(2, 1fr);
  grid-gap: 10px;
  grid-auto-columns: minmax(50px, auto);
  /*    grid-auto-rows: minmax(50px, auto);*/
}

.grid-view-y-5 {
  display: grid;
  /* grid-template-columns: 6ch auto; */
  overflow-y: scroll;
  padding: 10px;
  grid-gap: 10px;
  grid-template-columns: repeat(5, 1fr);
  grid-auto-columns: minmax(50px, auto);
  /* grid-auto-rows: minmax(50px,auto); */
}

.grid-view-y-6 {
  display: grid;
  /* grid-template-columns: 6ch auto; */
  overflow-y: scroll;
  padding: 10px;
  grid-gap: 10px;
  grid-template-columns: repeat(6, 1fr);
  grid-auto-columns: minmax(50px, auto);
  /* grid-auto-rows: minmax(50px,auto); */
}
.fs-7{
  font-size: 0.8rem !important;
}
.fs-8{
  font-size: 0.65rem !important;
}
.divider-w-1{
  height: auto;
  width: 1px;
  background: black;
}
.divider-h-1{
  height: 1px;
  width: auto;
  background: black;
}
/* span{
  font-size: 0.8rem !important;
} */
</style>
@/Page
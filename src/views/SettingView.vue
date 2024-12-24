<style></style>
<template>
  <div class="setting ">
    <!-- <img src="../../resources/building.jpg" @click="Page.goHome()" /> -->
    <div class="d-flex flex-row p-1" style="height:50px;">
      <fa-icon style="width:40px;height:40px;margin-left: 10px;" :icon="['fas', 'arrow-left']"
        @click="leftMenu.clickExist()" />
    </div>

    <div class="d-flex flex-row w-100 border border-1 border-secondary rounded rounded-2 ">

      <div class="list-group" style="width: 15%;height: 935px;" role="tablist">

        <template v-for="(o, i) in leftMenu.options" :key="i">
          <a :class="(o.flag == leftMenu.select.flag) ? 'active' : ''" class="list-group-item list-group-item-action"
            data-bs-toggle="list" role="tab" @click="leftMenu.select = o">
            {{ $t(o.flag) }}
          </a>
        </template>


      </div>
      <div class="p-0" style="">

        <component :is="leftMenu.view" />

      </div>
    </div>

  </div>
</template>

<script setup>
import { Page } from '@/router/Page'
import { inject, defineAsyncComponent, reactive, watch, computed, toRaw } from 'vue'
import moment from 'moment'
import { ProvideFlag } from '@/config/Enum'
import { useI18n } from "vue-i18n";

const api = require('@/ElectronApi')

const i18 = useI18n()

let setConfig = inject(ProvideFlag.setConfig)

watch(setConfig, (now, old) => {
  console.log(`SettingView setConfig change->${setConfig.value.jsonString()} i18->${i18.locale.value}`)

  //localStorage.setItem('language', setConfig.value.lang.use)

}, { deep: true })

let leftMenu = reactive({
  options: [
    {
      flag: 'menu.words_and_language',
      view: 'Page_LangSet'
    },
  ],
  select: { flag: '', view: '' },
  view: computed({
    get: () => defineAsyncComponent(() => import(`@/views/components/Setting/${leftMenu.select.view}.vue`))
  }),
  clickExist() {
    api.setSettingConfig(toRaw(setConfig.value))
    i18.locale.value = setConfig.value.lang.use
    //console.log(`leftMenu config raw->${toRaw(setConfig.value).jsonString()}`)

    Page.goHome()
  }

})

leftMenu.select = leftMenu.options.first()


</script>
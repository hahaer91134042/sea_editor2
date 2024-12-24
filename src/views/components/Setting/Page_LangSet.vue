<template>
    <div class="p-2">
        <div class="d-flex flex-row ">
            <div class="input-group">
                <span class="input-group-text">{{ $t('langSetting') }}</span>
                <select class="form-select" v-model="setting.lang" >
                    <template v-for="(l, i) in Support.getProps()" :key="i">
                        <option :value="l.key">{{ l.value }}</option>
                    </template>
                </select>
            </div>


        </div>
    </div>
</template>
<script setup>
import { reactive, watch, computed, inject } from 'vue'
import { Support} from '@/config/Lang'
import { ProvideFlag } from '@/config/Enum'
// const api = require('@/ElectronApi')

// api.getSettingConfig()
//     .then(c => {
//         setting.config = c
//         console.log(`Page LangSet config->${c.jsonString()}`)
//         setting.lang=c.lang.use
//     })

let setConfig = inject(ProvideFlag.setConfig)

console.log(`LangSet setConfig->${setConfig.value.jsonString()}`)

let setting = reactive({
    config: setConfig,
    lang: computed({
        get:()=>setConfig.value.lang.use,
        set:function(v){
            console.log(`onSelectLang->${v}`)
            setConfig.value.lang.use=v
            //history.go(0)
        }
    })
})



</script>
<style></style>
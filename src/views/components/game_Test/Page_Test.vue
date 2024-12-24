<style></style>
<template>
    <div>
        Test Page
        <button type="button" class="btn btn-primary" @click="countAdd()">
            click
        </button>

        <BgView style="width: 200px;height:100px;" :color-ratio="bgRatio" :color-init="bgColor">

            <button
                type="button"
                class="btn btn-primary" @click="addGreen()"
            >
                Add Greed
            </button>
            
        </BgView>

    </div>
</template>
<script setup>
import { inject,ref,toRefs } from 'vue'
import BgView from '@/views/components/ColorBgView'

// const {lua}=toRefs(defineProps({
//     lua: Object,
// }))

let count = 0

const lua = inject('lua')

console.log(`Test page lua->${lua.value}`)

function countAdd() {
    count++

    //lua.value.msg=`test child Page count->${count}`
}



function addGreen(){
    g=g+10
    bgRatio.value.g=g/255
}

let g=128
let bgRatio = ref({
    r: 0,
    g: g / 255,
    b: 0
})

let bgColor = {
    r: 255,
    g: 255,
    b: 0
}

</script>
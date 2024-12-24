<template>
    <div id="color_bg_view_main " style="" :style="[bgColor]">
        123
        <slot></slot>
    </div>

</template>
<script setup>
import { type } from 'jquery';
import { computed, ref, onMounted, } from 'vue';

let props = defineProps({
    colorRatio: {
        type: Object,
        default: function () {
            return {
                r: -1,
                g: -1,
                b: -1
            }
        }
    },
    colorOffset: {
        type: Object,
        default: function () {
            return {
                r: 0,
                g: 0,
                b: 0
            }
        }
    },
    colorInit: {
        r: 0,
        g: 0,
        b: 0
    }
})

//console.log(`color view props ratio->${props.colorRatio?.jsonString()} color->${props.colorInit.jsonString()}`)

let calValue = function (color, ratio, offset) {
    color.r = color.r < 0 ? 0 : color.r
    color.g = color.g < 0 ? 0 : color.g
    color.b = color.b < 0 ? 0 : color.b

    ratio.r = ratio.r < 0 ? 1 : ratio.r
    ratio.g = ratio.g < 0 ? 1 : ratio.g
    ratio.b = ratio.b < 0 ? 1 : ratio.b

    let r = Math.round((color.r + offset.r) * ratio.r)
    let g = Math.round((color.g + offset.g) * ratio.g)
    let b = Math.round((color.b + offset.b) * ratio.b)
    //console.log(`color view rgb->${[r, g, b].join()}`)

    return [r, g, b].join()
}

let bgColor = computed({
    get: () => {
        return {
            'background-color': `rgb(${calValue(props.colorInit, props.colorRatio, props.colorOffset)})`
        }
    }
})



</script>
<style></style>
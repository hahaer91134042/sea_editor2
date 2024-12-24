<template>
    <Vue3Menus :open="open" :event="event" :menus="props.menus">
        <template #label="{ menu, index, activeIndex }">
            <div
                :class="['my-menus-item', menu.disabled ? 'my-menus-item-disabled' : 'my-menus-item-available', activeIndex === index ? 'my-menus-item-active' : null]">

                <div>{{ menu.label }}</div>
                <div v-if="menu.children">▶</div>
            </div>
        </template>

    </Vue3Menus>
</template>

<script setup>
import { computed, ref, onMounted, nextTick } from 'vue';
import { Vue3Menus } from 'vue3-menus';
/**
 * 參考:https://doc.wssio.com/opensource/vue3-menus/example/11.html
 */

let props = defineProps({
    domId: {
        type: String,
        default: "",
    },
    menus: {
        type: Array,
        default: () => {
            return [];
        },
    },
})
//let uid = ref('')
let open = ref(false)
let event = ref({})

function init() {
    // 自定义鼠标右键菜单栏
    const dom = document.getElementById(props.domId);
    // console.log(`Mouse Menu parent id->${props.domId}`)
    // console.log(dom)
    if (!dom) return;

    // const menu = document.getElementById(uid.value);
    // console.log(`Mouse inti menu id->${uid.value}`)
    // console.log(menu)
    //const that = this;
    dom.oncontextmenu = function (e) {
        // const menu = document.getElementById(uid.value);
        // console.log(`Mouse click menu id->${uid.value}`)
        // console.log(menu)
        // console.log(e)

        hideAllMenu();
        e.preventDefault();

        nextTick(() => {
            event.value = e;
            open.value = true;
        })

    };
    // 鼠标点击其他位置时隐藏菜单
    document.onclick = function () {
        hideAllMenu();
    };
}
function hideAllMenu() {
    open.value = false
}


onMounted(() => {
    //uid.value = "j-mouse-menu_" + props.domId;
    init()
})

</script>

<style>
.vue3-menus-item {
    margin-top: 1rem;
    background-color: #eee;
    line-height: 7rem;
    height: 7rem;
    text-align: center;
}

.my-menus-item {
    display: flex;
    line-height: 2rem;
    padding: 0 1rem;
    margin: 0;
    font-size: 0.8rem;
    outline: 0;
    align-items: center;
    transition: 0.2s;
    box-sizing: border-box;
    list-style: none;
    border-bottom: 1px solid #00000000;
}

.my-menus-item-divided {
    border-bottom-color: #ebeef5;
}

.my-menus-item-available {
    color: #606266;
    cursor: pointer;
}

.my-menus-item-available:hover {
    background: #ecf5ff;
    color: #409eff;
}

.my-menus-item-active {
    background: #ecf5ff;
    color: #409eff;
}

.my-menus-item-disabled {
    color: #c0c4cc;
    cursor: not-allowed;
}
</style>
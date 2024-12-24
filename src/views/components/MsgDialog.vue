<style>
</style>

<template>
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="" data-bs-backdrop="static"
        data-bs-keyboard="false" aria-hidden="true" ref="modalEle">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header pt-0 pb-0">
                    <h5 class="modal-title" id="exampleModalLabel">{{ title }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body pt-2 pb-2 ">
                    <h3 v-show="msg.length > 0">{{ msg }}</h3>
                    <slot name="body"></slot>
                </div>
                <div class="modal-footer" v-show="checked">
                    <slot name="footer"></slot>
                    <button type="button" style="width: auto;" @click="onClick()" class="btn btn-primary "
                        data-bs-dismiss="modal">
                        {{ $t('determin') }}
                    </button>
                    <button type="button" style="width: auto;" class="btn btn-secondary " data-bs-dismiss="modal">
                        {{ $t('close') }}
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<!-- <MsgDialog ref="dialog" >
    <template #body>This should be in the body</template>
    <template #footer>
      <button class="btn btn-primary">Extra footer button</button>
    </template>
   </MsgDialog> -->
<script setup>
import { onMounted, toRefs, ref } from "vue";
import { Modal } from "bootstrap";
//  defineProps({
//   title: {
//     type: String,
//     default: Lang.tc.message_window,
//   },

// });
// let props=defineProps({
//     title: {
//         type: String,
//         default: Lang.tc.message_window,
//     },
//     msg: {
//         type:String,
//         default:''
//     }
// })

// const { title, msg } = toRefs(props)

let title = ref(window.$t("message_window"))
let msg = ref('')

let modalEle = ref(null);
let thisModalObj = null;

onMounted(() => {
    thisModalObj = new Modal(modalEle.value);
});

let checked = null

/**
 * 
 * @param {*} option { title: 'Dialog Title', msg: 'Dialog Message',checked:'Check call back function' }
 */
function _show(option = null) {
    if (option) {
        if (option.title)
            title.value = option.title
        else
            title.value = window.$t('message_window')

        if (option.msg)
            msg.value = option.msg
        else
            msg.value = ''

        if (option.checked)
            checked = option.checked
        else 
            checked = null

    } else {
        title.value = window.$t('message_window')
        msg.value = ''
        checked = null
    }


    thisModalObj.show();
}

function onClick() {
    if (checked)
        checked()
}



defineExpose({
    show: _show,
});
</script>
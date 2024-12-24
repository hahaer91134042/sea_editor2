<style></style>

<template>
    <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
    <div class="modal fade" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog" aria-labelledby="modalTitleId"
        aria-hidden="true" ref="modalEle" >
        <div class="modal-dialog modal-dialog-centered" role="document" 
        style="width: 200px;height: 100px;">
            <div class="modal-content" >
                <div class="modal-body row text-center" >
                    <!-- <div class="col ">
                        <span class="" style="font-weight:bold;font-size:20px;">Loading...</span>
                    </div> -->
                    <div class="col d-flex justify-content-center align-items-center">
                        <div class="spinner-border text-primary spinner-border-lg" role="status">
                            
                        </div>
                        <span class=" ms-2" style="font-weight:bold;font-size:20px;">Loading...</span>
                    </div>
                    
                    <!-- <div class="d-flex align-items-center">
                        <strong>Loading...</strong>
                        <div class="spinner-border ms-auto" role="status" aria-hidden="true"></div>
                    </div> -->

                </div>
                <div v-show="props.msg.length>0">{{ props.msg }}</div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, toRefs, ref } from "vue";
import { Modal } from "bootstrap";

let modalEle = ref(null);
let thisModalObj = null;

// defineProps({
//     // size:{
//     //     type:Object,
//     //     default:{
//     //         width:'100px',
//     //         height:'100px'
//     //     }
//     // }
// })
let props=defineProps({
    msg: {
        type:String,
        default:''
    }
})

//let msg=ref(props.msg)

onMounted(() => {
    thisModalObj = new Modal(modalEle.value);
});
defineExpose({
    show: function () {
        thisModalObj.show()
    },
    hide: function () {
        thisModalObj.hide()
        // msg.value=''
    },
    // setMsg:function(m){
    //     msg.value=m
    //     console.log(`Progress set msg->${m}`)
    // },
    // clearMsg:function(){
    //     msg.value=''
    // }
});
</script>
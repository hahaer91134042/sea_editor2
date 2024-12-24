<template>
    ---this is Jp Page---
    <br />
    ---Int Test start---
    <br />
    <input class="v-input" v-model="addInt.a" /> + <input class="v-input" v-model="addInt.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="addInt.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ addInt.result }}</label>
    <br />
    <br />
    <input class="v-input" v-model="subInt.a" /> - <input class="v-input" v-model="subInt.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="subInt.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ subInt.result }}</label>
    <br />
    <br />
    <input class="v-input" v-model="multiInt.a" /> * <input class="v-input" v-model="multiInt.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="multiInt.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ multiInt.result }}</label>
    <br />
    <br />
    <input class="v-input" v-model="diviInt.a" /> / <input class="v-input" v-model="diviInt.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="diviInt.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ diviInt.result }}</label>
    <br />
    ---Int Test End---
    <br />
    ---double Test start---
    <br/>
    <input class="v-input" v-model="double.add.a" /> + <input class="v-input" v-model="double.add.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="double.add.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ double.add.result }}</label>
    <br />
    <br />
    <input class="v-input" v-model="double.sub.a" /> - <input class="v-input" v-model="double.sub.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="double.sub.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ double.sub.result }}</label>
    <br />
    <br />
    <input class="v-input" v-model="double.multi.a" /> * <input class="v-input" v-model="double.multi.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="double.multi.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ double.multi.result }}</label>
    <br />
    <br />
    <input class="v-input" v-model="double.divi.a" /> / <input class="v-input" v-model="double.divi.b" />
    <button class="btn btn-primary " style="margin-left: 10px;" @click="double.divi.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ double.divi.result }}</label>
    <br/>
    ---double Test End---
    <br/>
    array 空位:<input class="v-input" v-model="arr.num" /> 
    <button class="btn btn-primary " style="margin-left: 10px;" @click="arr.exe">=</button>
    <label style="margin-left:10px;color: red;">{{ arr.result }}</label>
    <br/>
    <input class="v-input" v-model="name" />
    <button class="btn btn-danger" style="margin-left: 10px;width: 100px;" @click="onSay">Say Hi!</button>
    <label style="margin-left:10px;color: green;">{{ hi }}</label>
    <br />
    <label>add num count:{{ num2 }} </label>
    <br>
    <label>
        luaFile:{{ lua }}
    </label>
</template>

<script setup>

import { ref, reactive,toRefs, watch } from 'vue'
import {myFun2,initArray,add, sub, multi, divi, addDouble, subDouble, multiDouble, diviDouble, sayHi } from '@/MyDll';
// if(SeaNative.instance)
//     console.log(`view SeaNative instance true`)
// else
//     console.log(`view SeaNative instance true`)

const emits = defineEmits(['update:num'])

const props = defineProps({
    num: Number,
    lua: String,
})
const { num, lua } = toRefs(props)
console.log(`Page_JP ref num->${num.jsonString()}`)

let num2 = ref(num.value)

watch(num2, (now, old) => {
    console.log(`Page_JP num change->${now}`)
    emits('update:num', now)
})


// let arg1 = ref(0)
// let arg2 = ref(0)
// let result = ref(0)

let addInt = reactive({
    a: 0,
    b: 0,
    result: 0,
    exe: function () {
        addInt.result = add(addInt.a, addInt.b)
        num2.value++
        console.log(`add num2 ->${num2.value}`)
    }
})

let subInt = reactive({
    a: 0,
    b: 0,
    result: 0,
    exe: function () {
        subInt.result = sub(subInt.a, subInt.b)
    }
})

let multiInt = reactive({
    a: 0,
    b: 0,
    result: 0,
    exe: function () {
        multiInt.result = multi(multiInt.a, multiInt.b)
    }
})
let diviInt = reactive({
    a: 0,
    b: 0,
    result: 0,
    exe: function () {
        diviInt.result = divi(diviInt.a, diviInt.b)
    }
})

let double = reactive({
    add: {
        a: 0,
        b: 0,
        result: 0,
        exe(){
            double.add.result=addDouble(double.add.a,double.add.b)
        }
    },
    sub: {
        a: 0,
        b: 0,
        result: 0,
        exe(){
            double.sub.result=subDouble(double.sub.a,double.sub.b)
        }
    },
    multi: {
        a: 0,
        b: 0,
        result: 0,
        exe(){
            double.multi.result=multiDouble(double.multi.a,double.multi.b)
        }
    },
    divi: {
        a: 0,
        b: 0,
        result: 0,
        exe(){
            double.divi.result=diviDouble(double.divi.a,double.divi.b)
        }
    }
})

let arr=reactive({
    num:0,
    result:[],
    exe(){
       arr.result=initArray(arr.num)
    }
})

let name = ref('')
let hi = ref('')
// function onAdd() {
//     console.log(`onAdd arg1=>${arg1.value} arg2->${arg2.value} result->${add(arg1.value, arg2.value)}`)
//     //result.value= window.nativeEvent.test_add(arg1.value,arg2.value)
//     result.value = add(arg1.value, arg2.value)
//     //appWindow.nativeEvent.testAdd(arg1.value,arg2.value)

// }

// myFun({
//     n:1,
//     s:"2",
//     str:"hi"
// })

myFun2({a:1,b:2})


function onSay() {
    hi.value = sayHi(name.value)
}

//let num=ref(0)

// export default {
//     props:{
//         num:Number
//     },
//     setup() {

//         return {
//             arg1, arg2, result, name, hi,
//             onAdd() {
//                 console.log(`onAdd arg1=>${arg1.value} arg2->${arg2.value} result->${add(arg1.value, arg2.value)}`)
//                 //result.value= window.nativeEvent.test_add(arg1.value,arg2.value)
//                 result.value = add(arg1.value, arg2.value)
//                 //appWindow.nativeEvent.testAdd(arg1.value,arg2.value)
//             }, onSay() {
//                 hi.value = sayHi(name.value)
//             }

//         }
//     }
// }

</script>

<style>
.v-input {
    width: 100px;
}

.btn {
    width: 50px;
}
</style>
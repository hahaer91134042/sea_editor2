<style>
.over_all_head {
    margin-left: 0px;

    padding: 10px;

}
</style>
<template>
    <div class="container text-start mt-3" style="">
        <div class="over_all_head row align-items-center   border mb-3 ">
            <div class="col col-6">
                <div class="input-group">
                    <span class="input-group-text" id="">{{ Lang.tc.bet_size }}</span>
                    <input type="text" v-model="bets.betList" id="bet_lv" class="form-control" placeholder="" />
                    <!-- <div class="input-group-text">
                        <input v-model="bets.isEdit" class="form-check-input" type="checkbox" />
                        <label class="ms-2">新增</label>
                    </div> -->
                </div>
            </div>
            <div class="col col-6">
                <div class="input-group">
                    <span class="input-group-text" id="">{{ Lang.tc.bet_multiple }}</span>
                    <input type="text" v-model="bets.multi" class="form-control" placeholder="" />
                </div>
            </div>
            <div class="row mt-2 ">
                <div class=" input-group" style="width: 200px;">
                    <span class="input-group-text">{{ Lang.tc.basic_bet }}</span>
                    <input type="text" class="form-control" disabled v-model="bets.base" />
                </div>
                <div class=" input-group " style="width: 200px;">
                    <span class="input-group-text">{{ Lang.tc.line_coefficient }}</span>
                    <input
                        type="number"
                        class="form-control"
                        v-model="bets.lineCoef"
                    />                    
                </div>
                ({{ Lang.tc.explanation_of_line_coefficients }})
                <div class=" input-group " style="width: 200px;">
                    <span class="input-group-text">{{ Lang.tc.bonus_denominator }}</span>
                    <input
                        type="number"
                        class="form-control"
                        v-model="bets.prizeDen"
                    />                    
                </div>

            </div>
        </div>
        <div class="row align-items-start col-3">
            <!-- <div class="btn-group" role="group" aria-label="">
                <button type="button" class="btn btn-primary">+</button>
                <button type="button" class="btn btn-danger">-</button>
            </div> -->
        </div>
        <div class="row align-items-start" style="overflow-y:auto;height:450px;">
            <div class="table-responsive mt-3">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="col-1" scope="col">
                                {{ Lang.tc.id }}
                            </th>
                            <th class="col-2" scope="col">{{ Lang.tc.describe }}</th>
                            <th scope="col">{{Lang.tc.content}}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <template v-for="(data) in objs.items" :key="data.id">
                            <tr class="" >
                                <td scope="row">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" :id="'obj_item_'+data.id" />
                                        <label class="form-check-label" for="">{{data.id}}</label>
                                    </div>                                    
                                </td>
                                <td>
                                    <div class="mb-3">
                                        <label for="" class="form-label"></label>
                                        <input type="text" class="form-control form-control-sm"
                                            placeholder="" v-model="data.name" @input="onItemChange(data)" />
                                        <!-- <div class="btn-group mt-2" role="group">                                            
                                            <div class="btn-group" role="group">
                                                <button
                                                    type="button"
                                                    class="btn btn-secondary dropdown-toggle"
                                                    data-bs-toggle="dropdown"
                                                    aria-haspopup="true"
                                                    aria-expanded="false"
                                                >
                                                    <fa-icon :icon="['fas', 'circle-plus']" />
                                                </button>
                                                <div class="dropdown-menu" >
                                                    <a class="dropdown-item"  >First Dropdown</a>
                                                </div>
                                            </div>
                                            <button type="button" class="btn btn-danger p-0">
                                                <fa-icon :icon="['fas', 'circle-xmark']" />
                                            </button>
                                        </div> -->
                                        
                                    </div>

                                </td>
                                <td>
                                    <div class="table-responsive">
                                        <table class="table table-primary table-striped-columns">
                                            <thead>
                                                <tr>
                                                    <th class="col col-1 " scope="col">{{ Lang.tc.type }}</th>
                                                    <th class="col col-5">{{ Lang.tc.event }}</th>
                                                    <th class="col col-5">{{ Lang.tc.detail }}</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <template v-for="(con,i2) in data.content" :key="i2">
                                                    <tr class="">
                                                    <td scope="row">{{con.type}}</td>
                                                    <td>
                                                        <select class="form-select" v-model="con.event" @change="onItemChange(data)">
                                                            <template v-if="con.type=='W'">
                                                                <option >{{con.event}}</option>
                                                            </template>
                                                            <template v-else v-for="e,i3 in objs.events" :key="i3">
                                                                <option :value="e.key">{{e.value}}</option>
                                                            </template>
                                                            <!-- <option selected value="0">WILD work with</option>
                                                            <option value="1">FreeSpin x(num)</option>
                                                            <option value="2">Line Bet x</option> -->
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <div class="">
                                                            <input type="text" class="form-control" @input="onItemChange(data)"
                                                                placeholder="" v-model="con.param" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                </template>
                                                
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </template>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>

<script setup>
import { inject, reactive,toRefs, watch, computed } from 'vue'
import {MahJongWays} from '@/config/GameConfig'
import {Lang} from '@/config/Lang'
import {tryObjToArray,tryZero} from '@/plugin/Utils'


const lua=inject('lua')



let bets = reactive({
    base: computed({
        get: function () {
            if (!lua.value) return ''
            return lua.value.bets.Base
        }
    }),
    lineCoef:computed({
        get:function(){
            if (!lua.value) return ''
            return lua.value.line_coef
        },
        set:function(v){
            if(!lua.value) return
            lua.value['line_coef']=v.toNum()
        }
    }),
    prizeDen:computed({
        get:function(){
            if (!lua.value) return ''
            return lua.value.prize_den
        },
        set:function(v){
            if(!lua.value) return
            lua.value['prize_den']=v.toNum()
        }
    }),
    isEdit: false,//目前沒用
    betList: computed({
        get: function () {
            // console.log(`over all bet isAdd->${bets.isEdit}`)
            // console.log(`over all bet list data->${lua.value}`)
            if (!lua.value)
                return ''

            return lua.value.bets.bet.join()
            // let s = ''
            // lua.value.bets.bet.forEach(v => {
            //     s += `${v},`
            // });
            // return s.slice(0, -1)
        },
        set: function (value) {
            //console.log(`betList set value->${value}`)
            lua.value.bets.bet = value.split(',').map(v => tryZero(v))

            // if (bets.isEdit)
            //     lua.value.bets.bet = value.split(',').map(v => v.toNum())
            // else
            //     lua.value.bets.bet = value.split(',').map(v => v.toNum()).filter(v => v > 0)

        }
    }),
    multi: computed({
        get: function () {
            if (!lua.value)
                return ''

            return lua.value.bets.multi.join()
        },
        set:function(value){
            lua.value.bets.multi = value.split(',').map(v => tryZero(v))
        }
    })
})




let objs = reactive({
    events:computed({
        get:()=>MahJongWays.ObjEvent.getProps()
    }),

    items: computed({
        get: function () {
            if (!lua.value)
                return []
            return lua.value.objs.map(v=>MahJongWays.DataObj(v))
        },
    }),


})

function onItemChange(value){
    console.log(`objs change name value->${value.jsonString()}`)

    console.log(`objs in lua->${lua.value.objs.first(o=>o.id==value.id).jsonString()}`)

    let luaObj=MahJongWays.LuaObj(value)
    console.log(`data to lua ->${luaObj.jsonString()}`)
    lua.value.objs
    .first(o=>o.id==value.id)
    .also(obj=>{
        obj.copy(luaObj)
    })

}

// setTimeout(()=>{
//     console.log(`objs wild->${objs.items.first(o=>o.name=="WILD").jsonString()}`)
// },5000)

// function data(){
//     console.log(`---Over all on get data---`)
//     return 'over all data'
// }

// defineExpose({
//     data
// })


</script>


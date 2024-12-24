<template>
    <div class="p-1  ">
        <div class="p-1 d-flex flex-row justify-content-end " style="width: 450px;">
            <div class="col text-start ">
                <Popper placement="right" offsetDistance="3" :show="vm.popperShow">
                    <button @click="vm.onAdd" type="button" class="btn btn-outline-dark p-0"
                        style="width: 50px;height: 30px;">
                        <fa-icon :icon="['fas', 'plus']" />
                    </button>

                    <template #content>
                        <!-- Hover added -->
                        <div class="list-group">
                            <a class="list-group-item list-group-item-action" @click="vm.global.addJP()">Global JP</a>
                            <a class="list-group-item list-group-item-action" @click="vm.local.addJP()">Local JP</a>
                        </div>

                    </template>
                </Popper>
            </div>
            <div class="input-group " style="width: 300px;">
                <span class="input-group-text">RE Denominator</span>
                <input type="number" class="form-control" min="0" v-model="vm.total" />
            </div>
        </div>

        <div class=" d-flex flex-row">
            <div class=" overflow-y-auto" style="width: 600px;height: 600px;padding:3px;">
                <template v-for="(gjp, i) in vm.global.JPs" :key="i">
                    <div class=" d-flex flex-row border border-1 border-black rounded-2"
                        style="margin-bottom: 5px;padding: 3px;">
                        <div style="width: 170px;background-color:white;">
                            <div class=" d-flex flex-row align-items-center ">
                                <button class="btn btn-outline-danger p-0" type="button" @click="vm.global.remove(i)"
                                    style="width:30px;height:30px;">
                                    <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                </button>
                                <span class="ms-1">{{ `Global JP ${i + 1}` }}</span>
                            </div>
                            <div class=" border border-1 p-1">
                                <div class="input-group">
                                    <span class="input-group-text">Low:</span>
                                    <!-- <input type="number" min="0" class="form-control" /> -->
                                </div>
                                <input type="number" min="0" class="form-control" v-model="gjp.range.low" />
                            </div>
                            <div class=" border border-1 p-1">
                                <div class="input-group">
                                    <span class="input-group-text">Upper:</span>
                                    <!-- <input type="number" min="0" class="form-control" /> -->
                                </div>
                                <input type="number" min="0" class="form-control" v-model="gjp.range.high" />
                            </div>

                        </div>
                        <div style="width:430px;">
                            <div class="fs-7 d-flex flex-row">
                                <button type="button" class="btn btn-outline-dark p-0 me-2"
                                    @click="vm.global.addPrize(i)" style="width: 30px;height: 30px;">
                                    <fa-icon :icon="['fas', 'plus']" />
                                </button>
                                <!-- factor:<input class="fs-7" style="width: 70px;" min="1" type="number" /> -->
                            </div>
                            <div class=" overflow-y-auto " style="height:170px;">
                                <table class="table table-striped table-hover table-borderless  align-middle">
                                    <thead class=" table-dark ">
                                        <tr>
                                            <th style="width: 40px;">T</th>
                                            <th>{{ $t("event") }}</th>
                                            <th>{{ $t("detail") }}</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <tr class="">
                                            <td>TB</td>
                                            <td class="fs-7">Total Bet *</td>
                                            <td><input style="width: 100px;" type="number" min="0"
                                                    v-model="gjp.total_bet" /></td>
                                        </tr>
                                        <tr class="">
                                            <td>LB</td>
                                            <td class="fs-7">Line Bet *</td>
                                            <td><input style="width: 100px;" type="number" min="0"
                                                    v-model="gjp.line_bet" /></td>
                                        </tr>
                                        <tr class="">
                                            <td>W</td>
                                            <td class="fs-7">Total Win *</td>
                                            <td><input style="width: 100px;" type="number" min="0"
                                                    v-model="gjp.total_win" /></td>
                                        </tr>
                                        <template v-for="(p, j) in vm.eventVal('GJPs', i, gjp.prize)" :key="j">
                                            <tr class="" :id="`gjp${i}_prize${j}`">
                                                <td>P</td>
                                                <td class="fs-7">
                                                    <select style="width: 220px;height: 30px;" v-model="p.props"
                                                        v-on:change="vm.changeEventVal(j, p)">
                                                        <template v-for="(e, k) in vm.events" :key="k">
                                                            <option :value="e.val">{{ e.txt }}</option>
                                                        </template>
                                                    </select>
                                                </td>
                                                <td><input style="width: 100px;" type="number" min="0"
                                                        @input="vm.changeEventVal(j, p)" v-model="p.val" /></td>
                                            </tr>
                                            <MouseMenu :domId="`gjp${i}_prize${j}`" :menus="vm.getMouseMenuItem(j, p)">

                                            </MouseMenu>
                                        </template>


                                    </tbody>
                                </table>
                            </div>


                        </div>
                    </div>
                </template>

            </div>
            <div class="ms-2 overflow-y-auto" style="width: 600px;height: 600px;padding:3px;">
                <template v-for="(ljp, i) in vm.local.JPs" :key="i">
                    <div class=" d-flex flex-row border border-1 border-black rounded-2"
                        style="margin-bottom: 5px;padding: 3px;">
                        <div style="width: 170px;background-color:white;">
                            <div class=" d-flex flex-row align-items-center ">
                                <button class="btn btn-outline-danger p-0" type="button" @click="vm.local.remove(i)"
                                    style="width:30px;height:30px;">
                                    <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                </button>
                                <span class="ms-1">{{ `Local JP ${i + 1}` }}</span>
                            </div>
                            <div class=" border border-1 p-1">
                                <div class="input-group">
                                    <span class="input-group-text">Low:</span>
                                    <!-- <input type="number" min="0" class="form-control" /> -->
                                </div>
                                <input type="number" min="0" class="form-control" v-model="ljp.range.low" />
                            </div>
                            <div class=" border border-1 p-1">
                                <div class="input-group">
                                    <span class="input-group-text">Upper:</span>
                                    <!-- <input type="number" min="0" class="form-control" /> -->
                                </div>
                                <input type="number" min="0" class="form-control" v-model="ljp.range.high" />
                            </div>

                        </div>
                        <div style="width:430px;">
                            <div class="fs-7 d-flex flex-row">
                                <button type="button" class="btn btn-outline-dark p-0 me-2"
                                    @click="vm.local.addPrize(i)" style="width: 30px;height: 30px;">
                                    <fa-icon :icon="['fas', 'plus']" />
                                </button>
                                <!-- factor:<input class="fs-7" style="width: 70px;" min="1" type="number" /> -->
                            </div>
                            <div class=" overflow-y-auto " style="height:170px;">
                                <table class="table table-striped table-hover table-borderless  align-middle">
                                    <thead class=" table-dark ">
                                        <tr>
                                            <th style="width: 40px;">T</th>
                                            <th>{{ $t("event") }}</th>
                                            <th>{{ $t("detail") }}</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-group-divider">
                                        <tr class="">
                                            <td>TB</td>
                                            <td class="fs-7">Total Bet *</td>
                                            <td><input style="width: 100px;" type="number" min="0"
                                                    v-model="ljp.total_bet" /></td>
                                        </tr>
                                        <tr class="">
                                            <td>LB</td>
                                            <td class="fs-7">Line Bet *</td>
                                            <td><input style="width: 100px;" type="number" min="0"
                                                    v-model="ljp.line_bet" /></td>
                                        </tr>
                                        <tr class="">
                                            <td>W</td>
                                            <td class="fs-7">Total Win *</td>
                                            <td><input style="width: 100px;" type="number" min="0"
                                                    v-model="ljp.total_win" /></td>
                                        </tr>
                                        <template v-for="(p, j) in vm.eventVal('JPs', i, ljp.prize)" :key="j">
                                            <tr class="" :id="`ljp${i}_prize${j}`">
                                                <td>P</td>
                                                <td class="fs-7">
                                                    <select style="width: 220px;height: 30px;" v-model="p.props"
                                                        v-on:change="vm.changeEventVal(j, p)">
                                                        <template v-for="(e, k) in vm.events" :key="k">
                                                            <option :value="e.val">{{ e.txt }}</option>
                                                        </template>
                                                    </select>
                                                </td>
                                                <td><input style="width: 100px;" type="number" min="0"
                                                        @input="vm.changeEventVal(j, p)" v-model="p.val" /></td>
                                            </tr>
                                            <MouseMenu :domId="`ljp${i}_prize${j}`" :menus="vm.getMouseMenuItem(j, p)">

                                            </MouseMenu>
                                        </template>
                                    </tbody>
                                </table>
                            </div>


                        </div>
                    </div>
                </template>


            </div>
        </div>


    </div>
</template>
<script setup>
import { inject, reactive, ref, watch, computed } from 'vue'
import { CandyParty } from '@/config/GameConfig'
import { tryObjToArray, tryZero, Log } from '@/plugin/Utils'
import { ProvideFlag } from '@/config/Enum'
import Popper from "vue3-popper"
import * as _ from 'lodash'
import MouseMenu from '../MouseMenu.vue'

const lua = inject(ProvideFlag.lua)
const jp = inject(ProvideFlag.jp)
const log = inject(ProvideFlag.log)

//console.log(`lua jp->${jp.jsonString()}`)
// watch(jp, () => {
//     if (jp.value)
//         console.log(`lua jp->${jp.value.jsonString()}`)
// }, { deep: true })

// let objs = reactive({
//     list: computed({
//         get: () => lua.value?.levels[0].objs.map(o => {
//             return { id: o.id, name: o.name }
//         }) ?? []
//     }),
//     fineById(id) {
//         return lua.value?.levels[0].objs.first(o => o.id == id) ?? null
//     }
// })

//view model
let vm = reactive({
    popperShow: false,
    onAdd() {
        vm.popperShow = !vm.popperShow
    },
    total: computed({
        get: function () {
            return jp.value?.total ?? 0
        },
        set: function (v) {
            if (!jp.value) return
            jp.value.total = v.toNum()
        }
    }),
    global: {
        JPs: computed({
            get: function () {
                return jp.value?.GJPs ?? []
            }
        }),
        addJP() {
            vm.popperShow = false
            if (!jp.value) return
            jp.value.GJPs.push({
                range:
                {
                    low: 0,
                    high: 0
                },
                total_bet: 0,
                line_bet: 0,
                total_win: 0,
                prize: []
            })
        },
        addPrize(i) {
            if (!jp.value) return
            jp.value.GJPs[i]?.prize.push({
                type: 0,
                target_id: 1,
                con_time: 1,
                val_type: 0,
                val: 0,
            })
        },
        remove(i) {
            if (!jp.value) return
            _.remove(jp.value.GJPs, (n, index) => {
                return index == i
            })
        }
    },
    local: {
        JPs: computed({
            get: function () {
                return jp.value?.JPs ?? []
            }
        }),
        addJP() {
            vm.popperShow = false
            if (!jp.value) return
            jp.value.JPs.push({
                range:
                {
                    low: 0,
                    high: 0
                },
                total_bet: 0,
                line_bet: 0,
                total_win: 0,
                prize: []
            })
        },
        addPrize(i) {
            if (!jp.value) return
            jp.value.JPs[i]?.prize.push({
                type: 0,
                target_id: 1,
                con_time: 1,
                val_type: 0,
                val: 0,
            })
        },
        remove(i) {
            if (!jp.value) return
            _.remove(jp.value.JPs, (n, index) => {
                return index == i
            })
        }
    },

    eventVal(t, jp_index, prize) {
        return prize.map(p => {
            return {
                type: t,
                jp: jp_index,
                props: [p.type, p.target_id, p.con_time, p.val_type].join('-'),
                val: p.val
            }
        })
    },

    changeEventVal(prize_index, prize) {
        //console.log(`changeEvent index->${prize_index} data->${prize.jsonString()}`)
        let pProps = prize.props.split('-').map(v=>v.toNum())
        //console.log(`changeEvent prize props->${pProps.jsonString()}`)

        jp.value[prize.type][prize.jp].prize[prize_index]
            .also(p => {
                //console.log(`changeEvent raw prize ->${p.jsonString()}`)
                p.type = pProps[0]
                p.target_id = pProps[1]
                p.con_time = pProps[2]
                p.val_type = pProps[3]
                p.val = prize.val.toNum()
            })
    },

    events: computed({
        get: function () {

            let objs = lua.value?.levels[0]?.objs.map(o => {
                return { id: o.id, name: o.name }
            }) ?? []

            //console.log(`event objs->${objs.jsonString()}`)

            if (objs.length < 1) return []

            let revStr = window.$t("revenue")
            let body = []

            for (let i = 1; i < 5; i++) {
                body.push({ txt: `%s CL*${i},${revStr}(Multi)`, con_time: i, val_type: 0 })
                body.push({ txt: `%s CL*${i},${revStr}=`, con_time: i, val_type: 1 })
                body.push({ txt: `%s CL*${i},${revStr}(BetMulti)=`, con_time: i, val_type: 2 })
                body.push({ txt: `%s CL*${i},${revStr}(All)`, con_time: i, val_type: 3 })
            }

            return objs
                //.filter(o => o.id != 1)
                .map(obj => {
                    let a = body.map(b => {
                        return {
                            txt: b.txt.format(obj.name),
                            val: [0, obj.id, b.con_time, b.val_type].join('-')//依照 {type}-{target_id}-{con_time}-{val_type}組合
                        }
                    })
                    //console.log(`event items->${a.jsonString()}`)

                    return a
                }).flat(1)

        }
    }),
    getMouseMenuItem(index, prize) {
        return [{
            label: window.$t("delete"),
            //tip: 'Alt+向左箭头',
            click: () => {
                //console.log(`right click prop->${p.jsonString()}`)
                //console.log(`bonus prop change->${lua.value.bonus.propertys.jsonString()}`)
                jp.value[prize.type][prize.jp].prize.remove(index)
            }
        }]
    }
})


</script>
<style></style>
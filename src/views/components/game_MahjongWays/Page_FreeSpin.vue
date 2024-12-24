<template>
    <div class=" d-flex flex-column m-2" style="">
        <div class=" pt-1 d-flex flex-row" style="width: 1200px;">

            <div class=" border border-2 border-black rounded rounded-2 w-75">
                <div class="pe-2 d-flex flex-row" style="background-color: azure;">
                    <div class="col col-4 d-flex justify-content-center align-items-center">
                        <span>Array:</span>
                        <div class="input-group" style="width: 140px;">
                            <input type="number" class="form-control" readonly v-model="rolls.rowNum" />
                            <span class="input-group-text">X</span>
                            <input type="number" class="form-control" readonly v-model="rolls.colNum" />
                        </div>

                    </div>
                    <div class="col d-flex justify-content-end">
                        <div class="input-group pe-0" style="width: 250px;">
                            <span class="input-group-text">Location Setup</span>
                            <input type="text" class="form-control" placeholder=""
                                :value="rolls.item.now ? `${rolls.item.now.x},${rolls.item.now.y}` : ''" />
                        </div>
                    </div>


                </div>
                <div class="d-flex flex-row" style="height:480px">
                    <div class="" style="height:100%;">
                        <div class="d-flex overflow-auto p-1" style="height:250px;width:400px;">

                            <template v-for="(a1, i) in rolls.array" :key="i">
                                <div class="" :style="{ width: `${rolls.item.w}px` }">
                                    <template v-for="(o, j) in a1" :key="j">
                                        <div :class="[rolls.item.checkSelect(o.x, o.y)]" class="m-1 card"
                                            :style="{ height: `${rolls.item.h}px` }">
                                            <div class=" card-body " @click="rolls.item.select(o)">
                                                {{ o.x }},{{ o.y }}
                                            </div>
                                        </div>
                                    </template>

                                </div>
                            </template>

                        </div>
                        <div class="m-1 rounded rounded-2 border border-2 border-black p-1" style="width: 400px;">
                            <div class=" d-flex justify-content-end ">
                                <div class="input-group " style="width: 250px;">
                                    <span class="input-group-text">KO Denominator</span>
                                    <input type="number" v-model="kickout.total" class="form-control" />
                                </div>
                            </div>
                            <div class="bg-white grid-view-y-1 p-0" style="height:135px;">

                                <template v-for="(v, i) in kickout.items" :key="i">
                                    <div class="mb-1 d-flex flex-row ">
                                        <div class="input-group col">
                                            <span class="input-group-text fs-6" style="">{{ v.type == KO.Multiple ?
                                                'Multiple' : 'Quota' }}:</span>
                                            <input type="number" min="0" class="form-control" v-model="v.key_val"
                                                @input="kickout.itemChange(i, v)" />
                                            <span class="input-group-text fs-6" style="">KO:</span>
                                            <input type="number" min="0" class="form-control" v-model="v.weight"
                                                @input="kickout.itemChange(i, v)" />
                                        </div>
                                        <button class="btn btn-outline-danger ms-1 " type="button"
                                            @click="kickout.onDelete(v)">
                                            <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                        </button>

                                    </div>
                                </template>


                            </div>
                            <div style="text-align: start;margin-top: 5px;">
                                <Popper placement="right" offsetDistance="3" :show="kickout.popperShow">
                                    <button @click="kickout.onAdd" type="button" class="btn btn-outline-dark p-0"
                                        style="width: 50px;height: 30px;">
                                        <fa-icon :icon="['fas', 'plus']" />
                                    </button>

                                    <template #content>
                                        <!-- Hover added -->
                                        <div class="list-group">
                                            <a @click="kickout.addItem(KO.Multiple)"
                                                class="list-group-item list-group-item-action">Mulitple</a>
                                            <a @click="kickout.addItem(KO.Quota)"
                                                class="list-group-item list-group-item-action">Quota</a>
                                        </div>

                                    </template>
                                </Popper>
                            </div>


                        </div>

                    </div>
                    <div class="col rounded rounded-2 border border-1 border-secondary p-1"
                        style="height:100%;text-align: start;">
                        <div class="grid-view-y-1 card-body " style="height: 430px;">

                            <template v-for="(o, i) in rolls.item.detail" :key="i">
                                <div class=" d-flex flex-row rounded rounded-2 border border-secondary"
                                    style="height:50px;margin-bottom:5px;">
                                    <div class=" input-group " style="width: 200px;">
                                        <span class="input-group-text">{{ i }}</span>
                                        <input type="text" readonly class="form-control"
                                            :value="`[${o.id}]:${objs.fineById(o.id)?.name ?? ''}`" />
                                    </div>
                                    <div class=" input-group ms-2">
                                        <span class="input-group-text">drag:</span>
                                        <input type="number" class="form-control" min="0" v-model="o.drag" />
                                        <button class="btn" type="button" @click="rolls.item.remove(i)">
                                            <fa-icon style="color: red;" :icon="['fas', 'circle-xmark']" />
                                        </button>
                                    </div>
                                </div>


                            </template>
                        </div>

                        <Popper placement="right" offsetDistance="3" :show="rolls.item.popperShow">
                            <button type="button" class="btn btn-outline-dark p-0 mt-2" @click="rolls.item.showAddPop()"
                                style="width: 50px;height: 30px;">
                                <fa-icon :icon="['fas', 'plus']" />
                            </button>

                            <template #content>
                                <div class="dropdown">
                                    <button class="btn btn-secondary dropdown-toggle" type="button"
                                        data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        {{ $t("object_selection") }}
                                    </button>
                                    <div class="dropdown-menu">
                                        <template v-for="(o, i) in objs.list" :key="i">
                                            <a class="dropdown-item" @click="rolls.item.add(o)">{{ `[${o.id}]:${o.name}`
                                                }}</a>
                                        </template>

                                    </div>
                                </div>

                            </template>
                        </Popper>
                        <button type="button" class="btn btn-outline-dark ms-2" @click="rolls.item.copy(0)" v-tooltip
                            :title="`${$t('copy')}`">
                            <fa-icon :icon="['fas', 'clone']" />
                        </button>
                        <button type="button" class="btn btn-outline-dark ms-2" v-tooltip @click="rolls.item.copy(1)"
                            :title="`${$t('copy')}-${$t('column')}`">
                            <fa-icon :icon="['fas', 'table-columns']" />
                        </button>
                    </div>

                </div>

            </div>

            <div class="card ms-1" style="width:250px;height: 300px;">
                <div class="card-body">
                    <h5 class="card-title">{{ $t('spin_bonus_multiplier') }}
                        <button type="button" class="btn btn-outline-secondary" v-on:click="prize.add()">
                            <fa-icon :icon="['fas', 'plus']" />
                        </button>
                        <!-- <a href="#" style="width:70px;" class="btn btn-outline-secondary fs-6">新增</a> -->
                    </h5>


                </div>
                <div class=" card-body mb-2" style="overflow-y: auto;">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th class=" col-2" scope="col">{{ $t('id') }}</th>
                                <th class="text-center" scope="col">{{ $t('multiply') }}</th>
                            </tr>
                        </thead>
                        <tbody>

                            <template v-for="(v, i) in prize.multi" :key="i">
                                <tr class="text-center">
                                    <td scope="row">
                                        <span>
                                            {{ i + 1 }}
                                        </span>
                                    </td>
                                    <td class="">
                                        <div class="input-group">
                                            <input type="text" class="form-control"
                                                @input="prize.setMulti($event.target.value, i)" :value="v" />
                                            <button class="btn btn-outline-danger" type="button"
                                                @click="prize.setMulti(-1, i)">
                                                <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </template>


                        </tbody>
                    </table>
                </div>

            </div>


        </div>

        <div class="mt-1 p-0 border border-2 border-black rounded rounded-2" style="width:2200px;">
            <div class=" d-flex flex-row " style="background-color: azure;">
                <div class="input-group" style="width: 300px;">
                    <span class="input-group-text" style="color:red;">UC Denominator</span>
                    <input type="number" class="form-control" v-model="uc.total" min="0" />
                </div>
                <div class="col col-7 d-flex justify-content-center align-items-center">
                    <span class="fs-2 fw-bold">Algorithm Editor</span>
                </div>

            </div>
            <div class="p-1" style="">
                <div class="d-flex justify-content-start align-items-start">

                    <template v-for="(a, i) in uc.items" :key="i">
                        <div :style="{ width: `${uc.w}px` }">
                            <template v-for="(b, j) in a" :key="j">
                                <div class=" border border-2 border-secondary card p-1 m-1" style="">
                                    <div class=" card-body p-0">
                                        <div style="height: 75px;">
                                            <div class="row">
                                                <div class="col input-group">
                                                    <span class="input-group-text p-0" style="font-size: small;">Serial
                                                        Order:</span>
                                                    <input type="number" class="form-control p-0"
                                                        v-model="b.uc.order" />
                                                </div>
                                                <div class="col input-group">
                                                    <span class="input-group-text p-0" style="font-size: small;">UC
                                                        Prob:</span>
                                                    <input type="number" class="form-control p-0" v-model="b.uc.uc" />
                                                </div>

                                            </div>
                                            <div class="row mt-1">
                                                <div class="col input-group">
                                                    <span class="input-group-text p-0" style="font-size: small;">CP
                                                        Relation:</span>
                                                    <input type="number" class="form-control p-0"
                                                        v-model="b.uc.cp_numerator" />
                                                </div>
                                                <div class="col input-group">
                                                    <span class="input-group-text p-0"
                                                        style="font-size: small;">UC(Mutex):</span>
                                                    <input type="number" class="form-control p-0"
                                                        v-model="b.uc.uc_mutex_numerator" />
                                                </div>

                                            </div>

                                        </div>
                                        <div class="d-flex flex-row ">
                                            <div class=" w-50" style="text-align: start;">
                                                <div style="text-align: center;">relation</div>
                                                <div class="grid-view-y-1" style=" height:150px;">

                                                    <template v-for="(c, k) in b.uc.relation" :key="k">

                                                        <div class="input-group" style="height:auto;margin-bottom:3px;">
                                                            <select class="form-select " v-model="c.target" style="">
                                                                <template v-for="(l) in uc.findUcTarget(b.uc.order)"
                                                                    :key="l.order">
                                                                    <option :value="l.target">{{ l.order }}</option>
                                                                </template>
                                                            </select>
                                                            <input class=" form-control" min="0" type="number"
                                                                v-model="c.weight" />

                                                            <button class="btn btn-outline-danger" type="button"
                                                                @click="uc.removeItem(b.uc.order, 'relation', k)">
                                                                <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                                            </button>

                                                        </div>

                                                    </template>

                                                </div>
                                                <button type="button" class="btn btn-outline-dark p-0 ms-1 mt-1"
                                                    @click="uc.addItem(b.uc.order, 'relation')"
                                                    style="width: 50px;height: 30px;">
                                                    <fa-icon :icon="['fas', 'plus']" />
                                                </button>
                                            </div>
                                            <div class="w-50" style="text-align: start;">
                                                <div style="text-align: center;">uncopy</div>
                                                <div class="grid-view-y-1" style="height:150px;">

                                                    <template v-for="(c, k) in b.uc.uncopy" :key="k">

                                                        <div class="input-group" style="height:auto;margin-bottom:3px;">
                                                            <select class="form-select " v-model="c.target" style="">
                                                                <template v-for="(l) in uc.findUcTarget(b.uc.order)"
                                                                    :key="l.order">
                                                                    <option :value="l.target">{{ l.order }}</option>
                                                                </template>
                                                            </select>
                                                            <input class=" form-control" min="0" type="number"
                                                                v-model="c.weight" />

                                                            <button class="btn btn-outline-danger" type="button"
                                                                @click="uc.removeItem(b.uc.order, 'uncopy', k)">
                                                                <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                                            </button>

                                                        </div>

                                                    </template>



                                                </div>
                                                <button type="button" class="btn btn-outline-dark p-0 ms-1 mt-1"
                                                    @click="uc.addItem(b.uc.order, 'uncopy')"
                                                    style="width: 50px;height: 30px;">
                                                    <fa-icon :icon="['fas', 'plus']" />
                                                </button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </template>

                        </div>
                    </template>




                </div>
            </div>

        </div>
    </div>
</template>

<script setup>
import * as _ from 'lodash'
import { inject, ref, reactive, toRefs, watch, watchEffect, computed } from 'vue'
import { tryZero, tryObjToArray, tryArray } from '@/plugin/Utils'
import Popper from "vue3-popper";
import { KO,ProvideFlag } from '@/config/Enum'

const lua = inject(ProvideFlag.lua)
const free = inject(ProvideFlag.free)
const parent = inject(ProvideFlag.parent)


let objs = reactive({
    list: computed({
        get: () => lua.value?.objs.map(o => {
            return { id: o.id, name: o.name }
        }) ?? []
    }),
    fineById(id) {
        return lua.value?.objs.first(o => o.id == id) ?? null
    },
})

let prize = reactive({
    multi: computed({
        get: function () {
            return free.value?.prize_multi ?? []
        }
    }),
    add: function () {
        free.value?.prize_multi.push(0)
    },
    /**
     * when input value=-1 remove element
     * @param {*} v input value
     * @param {*} i index
     */
    setMulti: function (v, i) {
        //console.log(`setMulti v->${v} typev->${typeof v} i->${i}`)
        if (v == -1) {
            _.remove(free.value.prize_multi, (n, index) => {
                return index == i
            })
        } else {
            _.fill(free.value.prize_multi, tryZero(v), i, i + 1)
        }
        //console.log(`change multi result->${free.value.prize_multi.jsonString()}`)

    }
})

let rolls = reactive({
    rowNum: computed({ get: () => free.value?.rolls.line_count ?? 0 }),
    colNum: computed({ get: () => free.value?.rolls.roll_count ?? 0 }),
    array: computed({
        get: function () {
            //console.log(`rolls raw data->${lua.value?.rolls.jsonString()}`)
            let arr = free.value?.rolls.let(o => {
                let row = o.line_count
                let col = o.roll_count
                let a = []
                for (let x = 0; x < col; x++) {
                    let b = []

                    for (let y = 0; y < row; y++) {
                        b.push({
                            x: x,
                            y: y
                        })
                    }

                    a.push(b)
                }
                return a
            }) ?? []

            console.log(`rolls arr result->${arr.jsonString()}`)

            return arr
        }
    }),
    item: {
        popperShow: false,
        h: computed({ get: () => (250 / free.value?.rolls.roll_count) ?? 0 }),
        w: computed({ get: () => (400 / free.value?.rolls.line_count) ?? 0 }),
        now: null,
        checkSelect(x, y) {
            if (!rolls.item.now)
                return ''

            return (rolls.item.now.x == x && rolls.item.now.y == y) ? 'bg-warning' : ''
        },
        select: function (o) {
            rolls.item.now = o
        },

        detail: computed({
            get: function () {
                return rolls.item.now?.let(n => {


                    // let a = selectRollList()
                    let b = selectRollItemList()


                    console.log(`detail select list->${b.jsonString()}`)


                    const unwatch = watch(b, () => {
                        console.log(`rolls detail change->${b.jsonString()}`)

                        for (let i = 0; i < b.length; i++) {
                            let o = b[i];
                            if (i == 0) {
                                o.cur_total = o.drag
                            } else {
                                let pre_o = b[i - 1]
                                o.cur_total = pre_o.cur_total + o.drag
                            }
                        }

                        unwatch()//只執行一次
                    }, { deep: true })
                    //tile.push(raw.slice(si, ei))

                    return b
                }) ?? []
            }
        }),
        showAddPop() {
            //防呆
            if (!rolls.item.now) {
                parent.showDialog({ msg: window.$t('please_click_on_the_shaft_component_first') })
                return
            }

            rolls.item.popperShow = !rolls.item.popperShow
        },
        copy(type) {
            //防呆
            if (!rolls.item.now) {
                parent.showDialog({ msg: window.$t('please_click_on_the_shaft_component_first') })
                return
            }

            let index = rolls.item.now.x * rolls.rowNum + rolls.item.now.y

            //console.log(`copy now->${rolls.item.now.jsonString()} index->${index}`)

            let sList = free.value.rolls.rolls[index]
            //console.log(`copy selectRollList->${sList.jsonString()}`)

            switch (type) {
                case 1: {//複製-列
                    let si = rolls.item.now.x * rolls.rowNum
                    let ei = si + rolls.rowNum
                    //console.log(`rolls item copy col si->${si} ei->${ei}`)

                    for (let i = si; i < ei; i++) {
                        free.value.rolls.rolls[i] = sList.map(o => o.copy())
                    }
                    break;
                }
                default: {//全複製

                    for (let i = 0; i < free.value.rolls.rolls.length; i++) {
                        free.value.rolls.rolls[i] = sList.map(o => o.copy())
                    }
                    break;
                }
            }

        },
        add(o) {
            let list = selectRollItemList()
            list.push({
                id: o.id,
                drag: 0,
                cur_total: list[list.length - 1]?.cur_total ?? 0
            })
            rolls.item.popperShow = false
        },
        remove(i) {
            let list = selectRollItemList()
            list.remove(i)
        }
    },

})

let uc = reactive({
    w: computed({ get: () => (2200 / free.value?.rolls.line_count) ?? 0 }),
    total: computed({
        get: () => free.value?.uc.total ?? 0,
        set: (v) => {
            if (free.value?.uc)
                free.value.uc.total = v
        }
    }),
    items: computed({
        get: function () {
            return free.value?.uc.let(u => {
                let row = free.value?.rolls.line_count ?? 0
                let col = free.value?.rolls.roll_count ?? 0

                let a = []

                for (let x = 0; x < col; x++) {
                    let b = []

                    for (let y = 0; y < row; y++) {

                        let index = x * row + y
                        let u = free.value?.uc.rolls[index]

                        let unwatch = watch(u, () => {

                            u.total = u.cp_numerator + u.col_cp_numerator + u.uc_mutex_numerator + u.uc

                            free.value.uc.order = _.orderBy(free.value.uc.rolls, 'order', 'asc')
                                .let(l1 => {
                                    //console.log(`free uc orderBy result->${l1.jsonString()}`)
                                    let order = []
                                    l1.forEach(l => {
                                        order.push(_.findIndex(free.value.uc.rolls, (o) =>
                                            (o.order == l.order && o.uc == l.uc && o.uc_mutex_numerator == l.uc_mutex_numerator)) + 1)
                                    })
                                    //console.log(`free uc new order->${order.jsonString()}`)
                                    return order
                                })

                            unwatch()
                        }, { deep: true })

                        b.push({
                            x: x,
                            y: y,
                            uc: u
                        })
                    }

                    a.push(b)
                }

                console.log(`uc items->${a.jsonString()}`)
                return a
            }) ?? []
        }
    }),
    findUcTarget: function (order) {
        let a = free.value?.uc.rolls ?? []
        let b = []
        for (let i = 0; i < a.length; i++) {
            const u = a[i];
            if (u.order < order) {
                b.push({
                    target: i + 1,
                    order: u.order
                })
            }
        }

        //console.log(`uc find target order:${order} list->${b.jsonString()}`)
        return b
    },

    removeItem(order, name, index) {
        let items = free.value?.uc.rolls.first(o => o.order == order)
        // console.log(`uc removeItem order:${order} name:${name} index:${index}`)
        // console.log(`uc removeItem items->${items.jsonString()}`)
        // console.log(`uc removeItem item->${items[name]?.jsonString()}`)
        items[name].remove(index)
    },
    addItem(order, name) {
        let items = free.value?.uc.rolls.first(o => o.order == order)
        items[name].push({
            target: 0,
            weight: 0
        })
    }

})

let kickout = reactive({
    popperShow: false,
    items: computed({
        get: function () {
            if (!free.value)
                return []
            //先multiple 在quota
            let arr = tryObjToArray(free.value.kick_out.multiple)
                .map(a => a.copy().also(c => c.type = KO.Multiple))
                .concat(tryObjToArray(free.value.kick_out.quota)
                    .map(b => b.copy().also(c => c.type = KO.Quota)))

            return arr
        }
    }),
    //這邊的index是指computed items的index
    itemChange(index, value) {
        //console.log(`kickout item change->${value.jsonString()}`)
        switch (value.type) {
            case KO.Multiple: {
                //console.log(`kickout item change Multiple index->${index}`)
                free.value.kick_out.multiple[index].copy(value)
                break;
            }
            case KO.Quota: {
                index = index - tryObjToArray(free.value.kick_out.multiple).length
                //console.log(`kickout item change Quota index->${index}`)
                free.value.kick_out.quota[index].copy(value)
                break;
            }
        }
    },
    total: computed({
        get: function () {
            if (!free.value)
                return 0
            return free.value.kick_out.total
        },
        set: function (v) {
            free.value.kick_out.total = v
        }
    }),
    onAdd() {
        kickout.popperShow = !kickout.popperShow
    },
    onDelete(v) {
        //console.log(`kickout delete value->${v.jsonString()}`)
        switch (v.type) {
            case KO.Multiple: {
                let i = tryObjToArray(free.value.kick_out.multiple)
                    .findIndex(a => a.key_val == v.key_val && a.weight == v.weight)
                //console.log(`kickout multiple delete index->${i}`)
                if (i > -1)
                    free.value.kick_out.multiple.remove(i)
                break;
            }

            case KO.Quota: {
                let ii = tryObjToArray(free.value.kick_out.quota)
                    .findIndex(a => a.key_val == v.key_val && a.weight == v.weight)
                //console.log(`kickout quota delete index->${ii}`)
                if (ii > -1)
                    free.value.kick_out.quota.remove(ii)
                break;
            }

        }
    },
    addItem(v) {
        let item = { key_val: 0, weight: 0 }
        if (v == KO.Multiple) {
            free.value.kick_out.multiple = tryObjToArray(free.value.kick_out.multiple)
                .also(a => a.push(item))

        } else if (v == KO.Quota) {
            free.value.kick_out.quota = tryObjToArray(free.value.kick_out.quota)
                .also(a => a.push(item))
        }

        kickout.popperShow = false
    }
})

// function selectRollList() {
//     return rolls.item.now?.let(n => {
//         let row = lua.value?.rolls.line_count ?? 0
//         let col = lua.value?.rolls.roll_count ?? 0

//         let si = n.x * row
//         let ei = si + row
//         //console.log(`detail array select start->${si} end->${ei} y->${n.y}`)
//         return lua.value?.rolls.rolls.slice(si, ei) ?? []
//     }) ?? []
// }

function selectRollItemList() {//每個格子內部的array
    return rolls.item.now?.let(n => {
        let row = free.value?.rolls.line_count ?? 0
        //let col = lua.value?.rolls.roll_count ?? 0

        let si = n.x * row
        let ei = si + row

        let a = free.value?.rolls.rolls.slice(si, ei) ?? []
        console.log(`detail array select start->${si} end->${ei} y->${n.y}`)
        return a[n.y]
    }) ?? []
}


</script>
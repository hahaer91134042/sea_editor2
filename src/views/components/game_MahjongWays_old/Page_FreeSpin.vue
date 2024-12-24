<style>
.input-cell-1 {
    width: 60px;
}
</style>
<template>
    <div class="container mb-5" style="padding-top:10px;">
        <div class="mb-2 text-start d-flex flex-row ">
            <div class="card" style="width:250px;height: 300px;">
                <div class="card-body">
                    <h5 class="card-title">{{ Lang.tc.spin_bonus_multiplier }}
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
                                <th class=" col-2" scope="col">{{ Lang.tc.id }}</th>
                                <th class="text-center" scope="col">{{ Lang.tc.multiply }}</th>
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
            <div class="card ms-2" style="width:250px;height: 300px;">
                <div class="card-body">
                    <h5 class="card-title">{{ Lang.tc.gold_appearance_rate }}</h5>
                </div>
                <div class=" card-body mb-2" style="overflow-y: auto;">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th class=" col-4" scope="col">{{ Lang.tc.quantity }}</th>
                                <th class="text-center" scope="col">{{ Lang.tc.weights }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-for="(v) in gold.items" :key="v.count">
                                <tr class="text-center">
                                    <td scope="row">
                                        <span>
                                            {{ v.count }}
                                        </span>
                                    </td>
                                    <td class="">
                                        <div class="input-group">
                                            <input type="number" class="form-control" v-model="v.k" />

                                        </div>
                                    </td>
                                </tr>
                            </template>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card ms-2 " style="width:350px;height: 300px;">
                <div class=" card-header">
                    <div class="input-group" style="width: 250px;">
                        <span class="input-group-text" style="color:red;">KO Denominator</span>
                        <input type="number" v-model="kickout.total" class="form-control" />
                    </div>
                </div>
                <div class="card-body pt-1 ps-1 pe-1 pb-0">
                    <div class="col overflow-y-auto " style="height:180px;">
                        <template v-for="(v, i) in kickout.items" :key="i">
                            <div class="mb-1 d-flex flex-row ">
                                <div class="input-group col">
                                    <span class="input-group-text fs-6" style="">{{ v.type == KO.Multiple ? 'Multiple' :
                                        'Quota'
                                    }}:</span>
                                    <input type="number" min="0" class="form-control" v-model="v.key_val"
                                        @input="kickout.itemChange(i, v)" />
                                    <span class="input-group-text fs-6" style="">KO:</span>
                                    <input type="number" min="0" class="form-control" v-model="v.weight"
                                        @input="kickout.itemChange(i, v)" />
                                </div>
                                <button class="btn btn-outline-danger ms-1 " type="button" @click="kickout.onDelete(v)">
                                    <fa-icon style="" :icon="['fas', 'circle-xmark']" />
                                </button>

                            </div>
                        </template>

                    </div>
                </div>
                <div class=" card-footer ">
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
        <div class="border border-2 border-black " style="width:100%;height:470px; overflow-x: auto;">
            <div style="width: 150px;background-color: white;">
                {{ Lang.tc.roller }}({{ Lang.tc.freeSpin }})
            </div>
            <div class="row ps-3 pe-1 " style="height:420px;width: 2000px;">
                <template v-for="r in MahJongWays.Rolls" :key="r.num">
                    <div class="col me-1 p-0 card " style="overflow-y: auto;">
                        <div class="card-header row bg-white  p-0">
                            <div class="col col-md-8 text-center ">
                                <h5>[{{ r.num }}]</h5>
                            </div>
                            <div class="col m-1">
                                <div class="float-right input-group" style="">
                                    <button class="btn btn-success p-0" @click="roll.addSlotColItem(r.num)">{{
                                        Lang.tc.add
                                    }}</button>
                                    <button class="btn btn-danger p-0" @click="roll.cleanSlotCol(r.num)">{{ Lang.tc.clean
                                    }}</button>
                                </div>
                            </div>
                        </div>
                        <div class=" card-body p-1">
                            <template v-for="(col, i) in roll.slotColItems(r.num)" :key="i">
                                <div class="row mb-1">
                                    <div class="col col-2">
                                        {{ i + 1 }}
                                    </div>
                                    <div class="col input-group ">
                                        <label class="input-group-text">{{ Lang.tc.object }}</label>
                                        <select class="form-select" v-model="col.obj_id">
                                            <template v-for="(s, i2) in roll.symbols" :key="i2">
                                                <option :value="s.id">{{ s.name }}</option>
                                            </template>
                                        </select>
                                        <span class="input-group-text">{{ Lang.tc.resistance }}</span>
                                        <input type="text" class="form-control" v-model="col.drag" />
                                        <button type="button" class="btn btn-secondary dropdown-toggle"
                                            data-bs-toggle="dropdown">

                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end">
                                            <li><a class="dropdown-item" @click="roll.addSlotColItem(r.num, i)">{{
                                                Lang.tc.insert
                                            }}</a></li>
                                            <li><a class="dropdown-item" @click="roll.cleanSlotCol(r.num, i)">{{
                                                Lang.tc.delete }}</a></li>
                                        </ul>
                                    </div>

                                </div>
                            </template>

                        </div>

                    </div>
                </template>






            </div>

        </div>
    </div>
</template>

<script setup>
import * as _ from 'lodash'
import { inject, reactive, toRefs, watch, computed } from 'vue'
import { MahJongWays } from '@/config/GameConfig'
import { Lang } from '@/config/Lang'
import { tryZero, tryArray, tryObjToArray } from '@/plugin/Utils'
import Popper from "vue3-popper";
import { KO } from '@/config/Enum'
// let props = defineProps({
//     lua: Object,
//     free: Object,
//     name: String
// })
// const { lua, free, name } = toRefs(props)

const lua = inject('lua')
const free = inject('free')

let prize = reactive({
    multi: computed({
        get: function () {
            if (!free.value)
                return []
            return free.value.prize_multi
        }
    }),
    add: function () {
        if (!free.value)
            return
        free.value.prize_multi.push(0)
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

let roll = reactive({
    symbols: computed({
        get: function () {
            if (!lua.value)
                return []
            return lua.value.objs.map(o => {
                return {
                    id: o.id,
                    name: o.name
                }
            })
        }
    }),
    slotCol: computed({
        get: function () {
            if (!free.value)
                return {}
            return free.value.roll_slots.let(slots => {
                let d = {}
                MahJongWays.Rolls.forEach(r => d[r.num] = slots[r.num - 1])
                return d
                // return {
                //     "1": slots[0],
                //     "2": slots[1],
                //     "3": slots[2],
                //     "4": slots[3],
                //     "5": slots[4],
                // }
            })
        }
    }),
    cleanSlotCol: function (rollIndex, itemIndex = -1) {
        let col = roll.slotCol[rollIndex]
        //console.log(`roll col->${col.jsonString()}`)
        if (col) {
            if (itemIndex < 0) {
                col.roll_slot = []
            } else {
                _.remove(col.roll_slot, (n, index) => {
                    return index == itemIndex
                })
            }
            col.total_drag = _.sumBy(col.roll_slot, (o) => o.drag)
        }
    },
    addSlotColItem: function (rollIndex, insertIndex = -1) {
        let col = roll.slotCol[rollIndex]
        //console.log(`roll rollIndex->${rollIndex} insertIndex->${insertIndex} col->${col.jsonString()}`)
        if (col) {
            let sb = roll.symbols.first()
            if (sb) {
                if (insertIndex < 0) {
                    tryArray(col.roll_slot,
                        () => col.roll_slot.push({ obj_id: sb.id, drag: 1, obj_name: sb.name }),
                        () => col.roll_slot = [])
                } else {
                    col.roll_slot.splice(insertIndex + 1, 0, { obj_id: sb.id, drag: 1, obj_name: sb.name })
                }
            }
            col.total_drag = _.sumBy(col.roll_slot, (o) => o.drag)
        }
    },
    slotColItems: function (i) {
        if (!roll.slotCol[i])
            return []

        return roll.slotCol[i].roll_slot
    }

})

let gold = reactive({
    items: computed({
        get: function () {
            if (!free.value)
                return []
            return tryObjToArray(free.value.Gold)
        }
    })
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

watch(free, (_) => {
    //console.log(`mainGame lua watch->${_}`)
    if (_) {
        free.value.roll_slots.forEach(item => {
            watch(item.roll_slot,
                (now) => {
                    //console.log(`FreeSpin lua watch slot->${now.jsonString()}`)
                    tryObjToArray(now).forEach(o => {
                        let sb = roll.symbols.first(s => s.id == o.obj_id)
                        //console.log(`mainGame id->${o.obj_id} symbols->${sb}`)
                        if (sb)
                            o.obj_name = sb.name
                    })
                })
        })
    }
})



</script>


<template>
    <div class=" overflow-x-auto d-flex flex-row p-2" style="width: 1500px;">
        <div class=" " style="width: 500px;">
            <div class=" rounded-2 border border-1 border-black p-1" style="height: 668px;">
                <div class="d-flex flex-row ps-2">
                    <!-- <button type="button" class="btn btn-outline-dark p-0" style="width: 50px;height: 30px;">
                        <fa-icon :icon="['fas', 'plus']" />
                    </button> -->
                    <div class="col" style="">
                        Symble Setup
                    </div>
                </div>
                <div class="mt-1" style="overflow: auto; height: 620px;">

                    <template v-for="(data) in objs.items" :key="data.id">
                        <div class="d-flex flex-row border-bottom border-secondary border-1"
                            style="height: auto; text-align: start;">
                            <div class="" style="width: 120px;">
                                <span class="ms-2">{{ data.id }}</span>
                                <input type="text" class="form-control" v-model="data.name"
                                    @input="objs.onItemChange(data)" />

                                <div class="form-check mt-1">
                                    <input class="form-check-input" type="checkbox" :checked="data.disable_copy == 1"
                                        @change="objs.onCopyChange(data)" />
                                    <label class="form-check-label" for=""> {{ $t('disable_being_copied') }}
                                    </label>
                                </div>

                            </div>
                            <div class="col table-responsive" style="">
                                <table class="table table-primary table-striped-columns m-0">
                                    <thead>
                                        <tr>
                                            <th class="col col-1 " scope="col">{{ $t('type') }}</th>
                                            <th class="col col-5">{{ $t('event') }}</th>
                                            <th class="col col-5">{{ $t('detail') }}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <template v-for="(con, i2) in data.content" :key="i2">
                                            <tr class="">
                                                <td scope="row">{{ con.type }}</td>
                                                <td>
                                                    <select class="form-select" v-model="con.event"
                                                        @change="objs.onItemChange(data)">
                                                        <template v-if="con.type == 'W' || con.type == 'key'">
                                                            <option>{{ con.event }}</option>
                                                        </template>

                                                        <template v-else v-for="e, i3 in objs.events" :key="i3">
                                                            <option :value="e.key">{{ e.value }}</option>
                                                        </template>

                                                    </select>
                                                </td>
                                                <td>
                                                    <div class="">
                                                        <input type="text" class="form-control"
                                                            @input="objs.onItemChange(data)" placeholder=""
                                                            v-model="con.param" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </template>


                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </template>

                </div>

            </div>
            <!-- 鎖匙概率 -->
            <!-- <div class="border border-1 border-black rounded-2 bg-info d-flex flex-row mt-1 p-1" style="height: 260px;">

                <div style="width: 160px;background-color: aquamarine;">
                    <div class="input-group mb-2">
                        <span class="input-group-text fs-7 p-0">鎖匙概率</span>
                        <input type="number" class="form-control fs-7" placeholder="" />
                        <span class="input-group-text fs-7 p-0">/1000</span>
                    </div>
                    <div class="border border-1 border-black mb-1 fs-7">
                        開寶箱配置
                        <div class="input-group mb-1">
                            <span class="input-group-text fs-7">龍珠權值</span>
                            <input type="number" class="form-control fs-7" placeholder="" />
                        </div>
                        <div class="input-group mb-1">
                            <span class="input-group-text fs-7">獎金權值</span>
                            <input type="number" class="form-control fs-7" placeholder="" />
                        </div>

                    </div>
                    <div class="input-group mb-1">
                        <span class="input-group-text fs-7">通關寶箱數量</span>
                        <input type="number" class="form-control fs-7" placeholder="" />
                    </div>
                    <div class="input-group mb-1">
                        <span class="input-group-text fs-7">N連消獲龍珠</span>
                        <input type="number" class="form-control fs-7" placeholder="" />
                    </div>

                </div>
                <div class="col ms-1 ">
                    <div class=" d-flex flex-row">
                        <div class="col">
                            <div class="input-group " style="width:200px;">
                                <span class="input-group-text fs-7">開寶箱獎金分母</span>
                                <input type="number" class="form-control fs-7" placeholder="" />
                            </div>
                        </div>
                        <button type="button" class="btn btn-outline-dark p-0" style="width: 50px;height: 30px;">
                            <fa-icon :icon="['fas', 'plus']" />
                        </button>
                    </div>

                    <div class="table-responsive overflow-y-auto mt-2" style="height:160px;">
                        <table class="table table-striped table-primary m-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="col-1">id</th>
                                    <th class="col-3">權值</th>
                                    <th class="col-3">賠率-低</th>
                                    <th class="col-3">賠率-高</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>
                                <tr class="table-primary">
                                    <td scope="row">id</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                    <td>Item</td>
                                </tr>

                            </tbody>

                        </table>
                    </div>
                    <div class="input-group mt-1">
                        <span class="input-group-text">公式:</span>
                        <input type="text" disabled class="form-control" value="賠率*totalbet/分母" />
                    </div>

                </div>

            </div> -->
        </div>
        <div class=" ms-1" style="width:700px;">
            <div class="round rounded-2 border border-1 border-black mb-2 p-1" style="text-align: start;">
                <div class="pe-2 d-flex flex-row" style="background-color: azure;">
                    <div class=" col col-6 d-flex justify-content-center align-items-center" style="">
                        <span class="fs-5 fw-bold">Symble Weight</span>
                    </div>

                    <div class="input-group col pe-0">
                        <span class="input-group-text fs-7" style="color: red;">Symble Denominator</span>
                        <input type="text" readonly class="form-control" placeholder="" v-model="symble.denominator" />
                    </div>
                </div>
                <div class="grid-view-y-6" style="height:220px;">

                    <template v-for="o in symble.items" :key="o.id">
                        <div class=" card " style="width: 150px;height: 110px;">
                            <div class=" card-body ">
                                <div class="input-group mb-1">
                                    <span class="input-group-text fs-6">{{ o.id }}</span>
                                    <input type="text" readonly class="form-control" v-model="o.name" />
                                </div>
                                <div class="input-group">
                                    <span class="input-group-text fs-6 p-1">k:</span>
                                    <input type="number" class="form-control" v-model="o.k" />
                                </div>

                            </div>
                        </div>
                    </template>

                </div>


            </div>
            <div class=" border border-1 border-black rounded rounded-2 p-1" style="text-align: start;">
                <div class=" d-flex flex-row">
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
                <div class="d-flex flex-row mt-1" style="height:340px">
                    <div class="" style="height:100%;">
                        <div class="d-flex flex-row overflow-auto p-1" style="height:150px;width:300px;">

                            <template v-for="(a1, i) in rolls.array" :key="i">
                                <div class="">
                                    <template v-for="(o, j) in a1" :key="j">
                                        <div :class="[rolls.item.checkSelect(o.x, o.y)]"
                                            class="m-1 d-flex justify-content-center align-items-center rounded rounded-2 border border-1"
                                            :style="{ width: `${rolls.item.w}px`, height: `${rolls.item.h}px` }"
                                            style="text-align: center;" @click="rolls.item.select(o)">

                                            <span class="fs-7">{{ o.x }},{{ o.y }}</span>

                                        </div>
                                    </template>

                                </div>
                            </template>

                        </div>
                        <div class="m-1 rounded rounded-2 border border-1 border-black p-1" style="width: 300px;">
                            <div class=" d-flex justify-content-end ">
                                <div class="input-group " style="width: 200px;">
                                    <span class="input-group-text fs-7">KO Denominator</span>
                                    <input type="number" v-model="kickout.total" class="form-control" />
                                </div>
                            </div>
                            <div class="bg-white grid-view-y-1 p-0" style="height:100px;">

                                <template v-for="(v, i) in kickout.items" :key="i">
                                    <div class="mb-1 d-flex flex-row ">
                                        <div class="input-group col">
                                            <span class="input-group-text fs-7" style="">
                                                {{ v.type == KO.Multiple ? 'Multiple' : 'Quota' }}:</span>
                                            <input type="number" min="0" class="form-control fs-8" v-model="v.key_val"
                                                @input="kickout.itemChange(i, v)" />
                                            <span class="input-group-text fs-7" style="">KO:</span>
                                            <input type="number" min="0" class="form-control fs-8" v-model="v.weight"
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
                        <div class="grid-view-y-1 card-body " style="height: 285px;">

                            <template v-for="(o, i) in rolls.item.detail" :key="i">
                                <div class=" d-flex flex-row rounded rounded-2 border border-secondary"
                                    style="height:50px;margin-bottom:5px;">
                                    <div class=" input-group " style="width: 270px;">
                                        <span class="input-group-text">{{ i }}</span>
                                        <input type="text" readonly class="form-control"
                                            :value="`[${o.id}]:${objs.fineById(o.id)?.name ?? ''}`" />
                                    </div>
                                    <div class=" input-group ms-2">

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
        </div>

        <div class="ms-1 " style="width:250px;">
            <div class="input-group mb-1">
                <span class="input-group-text fs-7">{{ $t("number_of_treasure_chests_cleared") }}</span>
                <input type="number" min="0" class="form-control fs-7" v-model="passKey">
            </div>
            <div class="input-group mb-1">
                <span class="input-group-text fs-7">{{ $t("freespin_odds") }}</span>
                <input type="number" min="0" class="form-control fs-7" v-model="bonusWeight">
                <span class="input-group-text fs-7">/1000</span>
            </div>
            <div class="card" style="width:250px;height: 300px;">
                <div class="card-body">
                    <h5 class="card-title">{{ $t("freespin_multiply") }}
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
                                <th class="text-center" scope="col">{{ $t('multiplier') }}</th>
                                <th class="text-center" scope="col">{{ $t('weight') }}</th>
                                <th style="width:30px;"></th>
                            </tr>
                        </thead>
                        <tbody>

                            <template v-for="(v, i) in prize.multi" :key="i">
                                <tr class="text-center">
                                    <td scope="row">
                                        <input type="number" min="0" class="form-control fs-7" v-model="v.prize" />
                                    </td>
                                    <td class="">
                                        <input type="number" min="0" class="form-control fs-7" v-model="v.k" />
                                        <!-- <div class="input-group">
                                            <input type="text" class="form-control"
                                                v-model="v.prize" />
                                            
                                        </div> -->
                                    </td>
                                    <td style="vertical-align: middle;">
                                        <fa-icon style="color: red;" :icon="['fas', 'circle-xmark']"
                                            @click="prize.setMulti(-1, i)" />

                                    </td>
                                </tr>
                            </template>


                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
    <div class="border border-1 border-black rounded-2 p-1 ms-2" :style="{ width: `${rolls.colNum * uc.w}px` }">
        <div class=" d-flex flex-row " style="background-color: azure;">
            <div class="input-group" style="width: 300px;">
                <span class="input-group-text fs-7" style="color:red;">UC Denominator</span>
                <input type="number" class="form-control" v-model="uc.total" min="0" />
            </div>
            <div class="col col-7 d-flex justify-content-center align-items-center">
                <span class="fs-4 fw-bold">Algorithm Editor</span>
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
                                        <div class="col input-group mb-1">
                                            <span class="input-group-text p-0" style="font-size: small;">Serial
                                                Order:</span>
                                            <input type="number" class="form-control p-0" v-model="b.uc.order"
                                                @input="uc.onChangeOrder()" />
                                        </div>
                                        <div class="col input-group">
                                            <span class="input-group-text p-0" style="font-size: small;">UC
                                                Prob:</span>
                                            <input type="number" class="form-control p-0" v-model="b.uc.uc"
                                                @input="uc.onChangeOrder()" />
                                        </div>

                                    </div>
                                    <div class="d-flex flex-row ">
                                        <div class="" style="text-align: start;">
                                            <div style="text-align: center;">Copy Relation</div>
                                            <div class="grid-view-y-1" style="height:150px;">

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

                                    </div>
                                </div>
                            </div>
                        </template>

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
import { ProvideFlag, KO } from '@/config/Enum'
import * as _ from 'lodash'
import Popper from "vue3-popper";

const lua = inject(ProvideFlag.lua)
//第三關
let round = computed({
    get: () => lua.value?.levels[2] ?? null
})


const parent = inject(ProvideFlag.parent)


let objs = reactive({
    list: computed({
        get: () => round.value?.objs.map(o => {
            return { id: o.id, name: o.name }
        }) ?? []
    }),
    fineById(id) {
        return round.value?.objs.first(o => o.id == id) ?? null
    },
    events: computed({
        get: () => CandyParty.ObjEvent.getProps()
    }),
    items: computed({
        get: function () {
            return round.value?.objs.map(v => CandyParty.DataObj(v)) ?? []
        },
    }),
    onItemChange(value) {
        console.log(`objs change name value->${value.jsonString()}`)

        console.log(`objs in lua->${round.value.objs.first(o => o.id == value.id).jsonString()}`)

        let luaObj = CandyParty.LuaObj(value)
        console.log(`data to lua ->${luaObj.jsonString()}`)
        round.value.objs
            .first(o => o.id == value.id)
            .also(obj => {
                obj.copy(luaObj)
                if (luaObj.is_ChangeID == 1)
                    obj.is_ChangeID = 1
                else
                    delete obj['is_ChangeID']
            })

    },
    onCopyChange(v) {
        //console.log(`gold 1 change->${v.jsonString()}`)
        v.disable_copy = v.disable_copy == 0 ? 1 : 0
        //console.log(`gold 2 change->${v.jsonString()}`)
        objs.onItemChange(v)
    }
})

let passKey = computed({
    get: () => round.value?.pass_key_count ?? 0,
    set: function (v) {
        if (!round.value)
            return
        round.value.pass_key_count = v
    }
})

let bonusWeight = computed({
    get: () => round.value?.bonus_weight ?? 0,
    set: function (v) {
        if (!round.value)
            return
        round.value.bonus_weight = v
    }
})

let prize = reactive({

    multi: computed({
        get: function () {
            return round.value?.prize_multi ?? []
        }
    }),
    add: function () {
        round.value?.prize_multi.push({ k: 0, prize: 0 })
    },
    /**
     * when input value=-1 remove element
     * @param {*} v input value
     * @param {*} i index
     */
    setMulti: function (v, i) {
        //console.log(`setMulti v->${v} typev->${typeof v} i->${i}`)
        if (v == -1) {
            _.remove(round.value.prize_multi, (n, index) => {
                return index == i
            })
        }
        //目前沒用
        // else {
        //     _.fill(round.value.prize_multi, tryZero(v), i, i + 1)
        // }
        //console.log(`change multi result->${round.value.prize_multi.jsonString()}`)

    }
})

let symble = reactive({
    denominator: computed({
        get: () => round.value?.objs.sum(o => o.k) ?? 0
    }),
    items: computed({
        get: function () {
            return round.value?.objs ?? []
        }
    })

})

let rolls = reactive({
    rowNum: 6,
    colNum: 6,
    array: computed({
        get: function () {
            //console.log(`rolls raw data->${lua.value?.rolls.jsonString()}`)
            let arr = round.value?.rolls.let(o => {
                let row = rolls.rowNum
                let col = rolls.colNum
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
        h: computed({ get: () => 33 }),
        w: computed({ get: () => 37 }),
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

            let sList = round.value.rolls.rolls[index]
            //console.log(`copy selectRollList->${sList.jsonString()}`)

            switch (type) {
                case 1: {//複製-列
                    let si = rolls.item.now.x * rolls.rowNum
                    let ei = si + rolls.rowNum
                    //console.log(`rolls item copy col si->${si} ei->${ei}`)

                    for (let i = si; i < ei; i++) {
                        round.value.rolls.rolls[i] = sList.map(o=>o.copy())
                    }
                    break;
                }
                default: {//全複製

                    for (let i = 0; i < round.value.rolls.rolls.length; i++) {
                        round.value.rolls.rolls[i] = sList.map(o=>o.copy())
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
    w: computed({ get: () => 250 }),
    total: computed({
        get: () => round.value?.uc.total ?? 0,
        set: (v) => {
            if (round.value?.uc)
                round.value.uc.total = v
        }
    }),
    items: computed({
        get: function () {
            return round.value?.uc.let(u => {
                let row = rolls.rowNum
                let col = rolls.colNum

                let a = []

                for (let x = 0; x < col; x++) {
                    let b = []

                    for (let y = 0; y < row; y++) {

                        let index = x * row + y
                        let u = round.value?.uc.rolls[index]

                        // let unwatch = watch(u, () => {

                        //     //u.total = u.uc


                        //     round.value.uc.order = _.orderBy(round.value.uc.rolls, 'order', 'asc')
                        //         .let(l1 => {
                        //             //console.log(`lua uc orderBy result->${l1.jsonString()}`)
                        //             let order = []
                        //             l1.forEach(l => {
                        //                 order.push(_.findIndex(round.value.uc.rolls, (o) =>
                        //                     (o.order == l.order && o.uc == l.uc)) + 1)
                        //             })
                        //             //console.log(`lua uc new order->${order.jsonString()}`)
                        //             return order
                        //         })
                        //     unwatch()
                        // }, { deep: true })

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
        let a = round.value?.uc.rolls ?? []
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
        let items = round.value?.uc.rolls.first(o => o.order == order)
        // console.log(`uc removeItem order:${order} name:${name} index:${index}`)
        // console.log(`uc removeItem items->${items.jsonString()}`)
        // console.log(`uc removeItem item->${items[name]?.jsonString()}`)
        items[name].remove(index)
    },
    addItem(order, name) {
        let items = round.value?.uc.rolls.first(o => o.order == order)
        items[name].push({
            target: 0,
            weight: 0
        })
    },
    onChangeOrder() {
        //console.log(`---uc onChangeLog---`)
        round.value.uc.order = _.orderBy(round.value.uc.rolls, 'order', 'asc')
            .let(l1 => {
                //console.log(`lua uc orderBy result->${l1.jsonString()}`)
                let order = []
                l1.forEach(l => {
                    order.push(_.findIndex(round.value.uc.rolls, (o) =>
                        (o.order == l.order && o.uc == l.uc)) + 1)
                })
                //console.log(`lua uc new order->${order.jsonString()}`)
                return order
            })
    }

})

let kickout = reactive({
    popperShow: false,
    items: computed({
        get: function () {
            if (!round.value)
                return []
            //先multiple 在quota
            let arr = tryObjToArray(round.value.kick_out.multiple)
                .map(a => a.copy().also(c => c.type = KO.Multiple))
                .concat(tryObjToArray(round.value.kick_out.quota)
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
                round.value.kick_out.multiple[index].copy(value)
                break;
            }
            case KO.Quota: {
                index = index - tryObjToArray(round.value.kick_out.multiple).length
                //console.log(`kickout item change Quota index->${index}`)
                round.value.kick_out.quota[index].copy(value)
                break;
            }
        }
    },
    total: computed({
        get: function () {
            if (!round.value)
                return 0
            return round.value.kick_out.total
        },
        set: function (v) {
            round.value.kick_out.total = v
        }
    }),
    onAdd() {
        kickout.popperShow = !kickout.popperShow
    },
    onDelete(v) {
        //console.log(`kickout delete value->${v.jsonString()}`)
        switch (v.type) {
            case KO.Multiple: {
                let i = tryObjToArray(round.value.kick_out.multiple)
                    .findIndex(a => a.key_val == v.key_val && a.weight == v.weight)
                //console.log(`kickout multiple delete index->${i}`)
                if (i > -1)
                    round.value.kick_out.multiple.remove(i)
                break;
            }

            case KO.Quota: {
                let ii = tryObjToArray(round.value.kick_out.quota)
                    .findIndex(a => a.key_val == v.key_val && a.weight == v.weight)
                //console.log(`kickout quota delete index->${ii}`)
                if (ii > -1)
                    round.value.kick_out.quota.remove(ii)
                break;
            }

        }
    },
    addItem(v) {
        let item = { key_val: 0, weight: 0 }
        if (v == KO.Multiple) {
            round.value.kick_out.multiple = tryObjToArray(round.value.kick_out.multiple)
                .also(a => a.push(item))

        } else if (v == KO.Quota) {
            round.value.kick_out.quota = tryObjToArray(round.value.kick_out.quota)
                .also(a => a.push(item))
        }

        kickout.popperShow = false
    }
})


function selectRollItemList() {//每個格子內部的array
    return rolls.item.now?.let(n => {
        let row = rolls.rowNum
        //let col = round1.value?.rolls.roll_count ?? 0

        let si = n.x * row
        let ei = si + row

        let a = round.value?.rolls.rolls.slice(si, ei) ?? []
        console.log(`detail array select start->${si} end->${ei} y->${n.y}`)
        return a[n.y]
    }) ?? []
}

</script>
<style></style>